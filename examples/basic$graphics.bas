%TITLE "ASK_REALIZED_DEVICE_VIEWPORT"
%SBTTL "Return realized values of the device viewport"
%IDENT "V1-0"

SUB ASK_REALIZED_DEVICE_VIEWPORT BY REF	&
	(LONG Device_ID, SINGLE Left_DC, Right_DC, Bottom_DC, Top_DC)
!++
! FACILITY:
! 
!   BASIC Graphics Support
! 
! FUNCTIONAL DESCRIPTION:        
! 
! Return the  "realized"  values  for  the  device  viewport as
! opposed to the "set" values.  We do this by inquiring the current
! set values for the device viewport and device window and getting the
! aspect ratio from them.  We then make sure the ratios match.  If they
! don't match then we make both ratios equal to the lesser of the two.
! Lastly we multiply the device window top and right values by the ratio
! to get the new proportional device viewport values.  We add in the
! left and bottom values (which are usually zero) to get the final
! result.
!
! Note that calling ASK_REALIZED_DEVICE_VIEWPORT  in  place  of
! the  ASK  DEVICE  VIEWPORT  statement  will  produce  correct
! results with VAX GKS V2.0 as well as VAX GKS V3.0 or later.
!
! 
! INPUT PARAMETERS:
! 
!   Device_ID.rl.r
!	- Identifies the device for which you want information.
!	  Use zero for the default device.
! 
! OUTPUT PARAMETERS:
! 
!   Left_DC.rf.r, Right_DC.rf.r, Bottom_DC.rf.r, Top_DC.rf.r
!	- The realized boundary settings for the device viewport.
! 
! SIDE EFFECTS:
! 
!   This routine executes the ASK DEVICE VIEWPORT and ASK DEVICE
!   WINDOW statements and modifies the Top_DC and Right_DC
!   parameters to ensure a 1:1 aspect ratio.
! 
!--
    
    OPTION TYPE = EXPLICIT

    %PAGE
    %SBTTL "Declarations"
    
    !+
    ! Local Variables
    !-

    DECLARE SINGLE Left_WC, Right_WC, Bottom_WC, Top_WC
    DECLARE SINGLE X_Ratio, Y_Ratio

    !+
    ! Get the current device window and viewport values so
    ! we can make sure the ratio is correct.
    !-

    ASK DEVICE VIEWPORT #Device_ID: Left_DC, Right_DC, Bottom_DC, Top_DC
    ASK DEVICE WINDOW #Device_ID: Left_WC, Right_WC, Bottom_WC, Top_WC

    !+
    ! Calculate the aspect ratios.
    !-

    X_Ratio = (Right_DC - Left_DC) / (Right_WC - Left_WC)
    Y_Ratio = (Top_DC - Bottom_DC) / (Top_WC - Bottom_WC)

    !+
    ! Use the smaller of the two ratios to ensure we get the
    ! largest rectangle not larger than the device window.
    !-

    IF (X_Ratio > Y_Ratio) THEN
      X_Ratio = Y_Ratio
    ELSE
      Y_Ratio = X_Ratio
    END IF

    !+
    ! Adjust the device viewport boundaries to maintain the 1:1 aspect ratio.
    !-

    Right_DC = ((Right_WC - Left_WC) * X_Ratio) + Left_DC
    Top_DC = ((Top_WC - Bottom_WC) * Y_Ratio) + Bottom_DC

END SUB	! End of SUB ASK_REALIZED_DEVICE_VIEWPORT
    PICTURE Circle (SINGLE Center_X, Center_Y, Radius)

    !+
    !    This picture will draw a circle, with its center at the
    !    point specified by (Center_x, Center_y), and the radius as 
    !	 specified in Y world coordinates of the current transformation.
    !-

    OPTION TYPE = EXPLICIT

    EXTERNAL SUB ASK_REALIZED_DEVICE_VIEWPORT (LONG, SINGLE, , ,)

    DECLARE LONG trans_num
    DECLARE SINGLE x, increment, initial_x, aspect_ratio, &
	dc_min_x, dc_max_x, dc_min_y, dc_max_y, &
	wc_min_x, wc_max_x, wc_min_y, wc_max_y, &
	vp_min_x, vp_max_x, vp_min_y, vp_max_y, &
	dw_min_x, dw_max_x, dw_min_y, dw_max_y

    ASK TRANSFORMATION trans_num
!    ASK DEVICE VIEWPORT dc_min_x, dc_max_x, dc_min_y, dc_max_y
    CALL ASK_REALIZED_DEVICE_VIEWPORT (0%, dc_min_x, dc_max_x, &
			               dc_min_y, dc_max_y)
    ASK DEVICE WINDOW dw_min_x, dw_max_x, dw_min_y, dw_max_y
    ASK WINDOW , TRAN trans_num: wc_min_x, wc_max_x, wc_min_y, wc_max_y
    ASK VIEWPORT , TRAN trans_num: vp_min_x, vp_max_x, vp_min_y, vp_max_y

    aspect_ratio = dc_max_y / dc_max_x *  &
		    ( (wc_max_x - wc_min_x) / (wc_max_y-wc_min_y) ) * &
		    ( (vp_max_y-vp_min_y) ) / (vp_max_x - vp_min_x) * &
		    ( (dw_max_x - dw_min_x) / (dw_max_y-dw_min_y) )

    Increment = .0125			! Increment between points on the circle
    Initial_X = Center_X / Aspect_ratio	! First X adjusted by aspect ratio

    FOR X = 0 TO 2 * PI STEP Increment
	PLOT LINES:						&
		(Radius * SIN (X) + Initial_X) * Aspect_Ratio,	&
		Radius * COS (X) + Center_Y;
    NEXT X

    !+
    !    Close the circle and turn off the beam
    !-

    PLOT LINES Initial_X * Aspect_ratio, Radius + Center_Y

  END PICTURE

    SUB ENTIRE_SCREEN

	!+
	!   This Subroutine will modify the VIEWPORT, DEVICE VIEWPORT,
	!   and DEVICE WINDOW so that the World Coordinate WINDOW
	!   selected will be mapped to the entire terminal screen.
	!   
	!   This is accomplished by mapping the selected WC Window
	!   onto a portion of NDC space that is proportional to the 
	!   device, and then mapping that same portion of NDC space 
	!   to the entire device.
	!-

	OPTION TYPE = EXPLICIT

	DECLARE SINGLE DC_XMAX, DC_YMAX, ASPECT_RATIO
	ASK DEVICE SIZE DC_XMAX, DC_YMAX

	ASPECT_RATIO = DC_YMAX / DC_XMAX
	SET VIEWPORT 0,1,0,ASPECT_RATIO
	SET DEVICE WINDOW 0,1,0,ASPECT_RATIO
	SET DEVICE VIEWPORT 0,DC_XMAX, 0,DC_YMAX

    END SUB
    SUB HALF_SCREEN

	!+
	!   This Subroutine will modify the VIEWPORT, DEVICE VIEWPORT,
	!   and DEVICE WINDOW so that the World Coordinate WINDOW
	!   selected will be mapped to the entire terminal screen.
	!   
	!   This is accomplished by mapping the selected WC Window
	!   onto a portion of NDC space that is proportional to the 
	!   device, and then mapping that same portion of NDC space 
	!   to the entire device.
	!-

	OPTION TYPE = EXPLICIT

	DECLARE SINGLE DC_XMAX, DC_YMAX, ASPECT_RATIO
	ASK DEVICE SIZE DC_XMAX, DC_YMAX

	ASPECT_RATIO = DC_YMAX / DC_XMAX
	SET VIEWPORT 0,1,0,1
	SET DEVICE WINDOW 0,1,0,1
	SET DEVICE VIEWPORT 0,DC_XMAX/2, 0,DC_XMAX/2

    END SUB
PICTURE HISTOGRAM (SINGLE VALUES(), STRING LABELS(), BYTE ITEM_COUNT)

!+
!  This sample BASIC program draws a histogram using the values in the array
!  VALUES.  These values must be SINGLE values in the range 0 to 8.  Values
!  outside of this range will be set to zero.  Each bar is labeled with the 
!  corresponding string in the array LABELS.  Each label can be a maximum of 
!  6 characters long.  Longer strings will be truncated.   ITEM_COUNT
!  is the number of bars to plot.  The maximum number of bars that will fit
!  on a screen is 8.
!-

DECLARE SINGLE CURRENT_VALUE, X, Y, &
	STRING CURRENT_LABEL

!+
!   Verify the input
!-

IF ITEM_COUNT > 8
THEN
    PRINT "There is only room for eight items."
    ITEM_COUNT = 8
END IF

FOR I = 0 TO ITEM_COUNT-1
    IF VALUES (I) < 0 OR VALUES (I) > 8
    THEN
	PRINT "Value must be in the range 0 to 8.  Illegal value set to zero."
	VALUES (I) = 0
    END IF

    IF LEN (LABELS(I)) > 6
    THEN
	PRINT "Label must be six characters or less.  String truncated."
	LABELS(I) = LEFT$ (LABELS(I), 6)
    END IF
NEXT I

!+
!   Draw the grid.
!-

CLEAR

PLOT LINES: 0.1,0.95; 0.1,0.1; 0.95,0.1

!+
!   Mark off the scale on the vertical axis with an "_" character.
!-

Y = 0.2
FOR I = 2 TO 9
    GRAPH TEXT AT 0.1, Y : "_"
    Y = Y + 0.1
NEXT I

!+
!   Label the vertical axis with a scale from 0 through 8.
!   Use the CHAR font of the default text size.
!-

SET TEXT FONT 1, "CHAR"

DATA 0,1,2,3,4,5,6,7,8

Y = 0.1
FOR I = 0 TO 8
    READ CURRENT_LABEL
    GRAPH TEXT AT 0.05, Y : CURRENT_LABEL
    Y = Y + 0.1
NEXT I

!+
!   Draw the bars and label them.  Change to STROKE precision and 
!   make the text smaller, so that longer labels will fit.  Center 
!   each label under its bar.
!-

SET AREA COLOR 3
SET TEXT COLOR 2

SET TEXT FONT 1, "STROKE"
SET TEXT JUSTIFY "CENTER", "BASE"
ASK TEXT HEIGHT H
SET TEXT HEIGHT H * 0.8
ASK TEXT EXPAND EX
SET TEXT EXPAND EX * 0.8

X = 0.2
DELTA = 0.02

FOR J = 0 TO ITEM_COUNT-1
    CURRENT_VALUE = (VALUES (J) + 1) / 10.0		! Scale the value
    PLOT AREA : X-DELTA, 0.1; X-DELTA, CURRENT_VALUE; &
	        X+DELTA, CURRENT_VALUE; X+DELTA, 0.1

    GRAPH TEXT AT X, 0.05 : LABELS(J)
    X = X + 0.1
NEXT J

END PICTURE
%TITLE "Generic Pie Chart Routine"
%SBTTL "VAX BASIC Graphics Example"

SUB Pie (LONG input_points, SINGLE data_arr (), STRING labels(), TITLE())

!+
! This subprogram will draw a PIE chart using VAX BASIC Graphics.  The input
! parameters are as follows:
!
!   input_points - The number of data points in the DATA_ARR and LABELS arrays.
!
!   data_arr     - An array containing the data values to be used in generating 
!		   the PIE chart.
!
!   labels	 - The labels to be used on the PIE chart.  The label in the
!		   ith position in this array corresponds to the data in the 
!		   same position in the DATA_ARR array.
!-

    OPTION TYPE = EXPLICIT, CONSTANT TYPE = INTEGER

    DECLARE LONG CONSTANT npoints = 100
    DECLARE SINGLE CONSTANT radius = 0.275
    DECLARE LONG area_color, pies, first_point, last_point, too_big, &
	    loop_count, inner_loop, max_color, x_dir, mid_point, device_type
    DECLARE SINGLE xs(npoints), ys(npoints), x_pie(npoints), y_pie (npoints)
    DECLARE SINGLE DC_Y_MAX,DC_X_MAX, data_total, pie_completed, &
		mid_pie_x, mid_pie_y, temp_data
    DECLARE STRING temp_label, area_style
    DECLARE SINGLE xextent(3),yextent(3),xmin, xmax, ymin, ymax, theight

    ASK DEVICE SIZE dc_x_max, dc_y_max
    ASK DEVICE TYPE device_type
    ASK MAX COLOR max_color

    SET WINDOW -.5*dc_x_max/dc_y_max,.5*dc_x_max/dc_y_max,-.5,.5
    SET VIEWPORT 0,1,0,dc_y_max/dc_x_max
    SET DEVICE WINDOW 0,1,0,dc_y_max/dc_x_max
    SET DEVICE VIEWPORT 0, dc_x_max, 0, dc_y_max
    SET AREA STYLE "SOLID"
    SET AREA STYLE INDEX 1
    SET CLIP "OFF"
    SET TEXT JUSTIFY "CENTER", "HALF"

    IF device_type = 13
    THEN
	SET TEXT COLOR 3
	SET LINE COLOR 3
    END IF
	  
    ASK WINDOW xmin, xmax, ymin, ymax
    SET TEXT HEIGHT .030*(xmax - xmin)

    too_big = -1

    !+
    !   Check that the TITLE fits.  If not, reduce the spacing repeatedly
    !   until it does fit.
    !-

    DECLARE SINGLE expand_val, y_val

    FOR loop_count = 1 TO 2

	y_val = 2.0 * RADIUS - (loop_count * .25 * radius)
	WHILE too_big
	    ASK TEXT EXTENT, title(loop_count) AT 0, y_val : xextent, yextent
	    too_big = 0		IF xextent(0) > xmin OR xextent(1) < xmax

	    IF too_big
	    THEN
		ASK TEXT EXPAND expand_val
		SET TEXT EXPAND expand_val * .9
	    END IF

	NEXT	

	GRAPH TEXT AT 0, y_val: TITLE(loop_count)
	SET TEXT EXPAND 1.0
    NEXT loop_count

    !+
    !   Fill the XS and YS arrays with points to be used in drawing the PIE.
    !-

    FOR loop_count = 0 TO npoints
	xs(npoints - loop_count) = COS ( 2*PI/npoints*loop_count ) * radius
	ys(npoints - loop_count) = SIN ( 2*PI/npoints*loop_count ) * radius
    NEXT loop_count

    !+
    !   Order the input points by decreasing value, and total the values.
    !-

    IF input_points > 1
    THEN 
	FOR loop_count = 1 TO input_points - 1
	    FOR inner_loop = loop_count + 1 TO input_points
		IF data_arr(inner_loop) > data_arr(loop_count)
		THEN
		    temp_data = data_arr (loop_count)
		    temp_label = labels (loop_count)
		    data_arr(loop_count) = data_arr(inner_loop)
		    labels (loop_count) = labels (inner_loop)
		    data_arr(inner_loop) = temp_data
		    labels (inner_loop) = temp_label
		END IF
	    NEXT inner_loop
	NEXT loop_count
    END IF

    data_total = 0
    FOR loop_count = 1 TO input_points 
	data_total = data_total + data_arr(loop_count)
    NEXT loop_count

    !+
    !   Group all data points below some level into 
    !   an 'OTHER' category.
    !-

    cleanup_points:

    FOR loop_count = 1 TO input_points 
	IF data_arr (loop_count) < .02 * data_total
	THEN
	    last_point = loop_count
	    labels (last_point) = "OTHER"
	    FOR inner_loop = loop_count + 1 TO input_points
		data_arr(last_point) = data_arr (last_point) + data_arr (inner_loop)
	    NEXT inner_loop
	    input_points = last_point	
	    EXIT cleanup_points
	END IF
    NEXT loop_count

    pie_completed = 0
    area_color = 1
    SET AREA STYLE 'HATCH'

    !+
    !   Walk through the DATA array, generating the appropriate PIE segments.
    !-

    FOR loop_count = input_points TO 1 STEP -1

	First_point = INT(npoints* pie_completed/data_total)
	Last_point = INT (npoints*(pie_completed + data_arr(loop_count))/data_total)
	FOR pies = first_point TO last_point
	    x_pie (pies-first_point) = xs(pies)
	    y_pie (pies-first_point) = ys(pies)
	NEXT pies

	pie_completed = pie_completed + data_arr(loop_count)
	    
	!+
	!   In all cases except where there is one data point that makes
	!   up the entire pie, add the center point to the array containing
	!   the points for this datas "slice".
	!-

	IF (pies - first_point) < npoints
	THEN
	    Pies = pies + 1
	    x_pie (pies - first_point) = 0
	    y_pie (pies - first_point) = 0
	END IF

	!+
	!   Alternate between SOLID and HATCH fill area styles every
	!   time we cycle through all the colors.
	!-

	IF area_color = 1
	THEN
	    ASK AREA STYLE area_style
	    SELECT area_style

	    CASE "SOLID"
		SET AREA STYLE "HATCH"
	    CASE "HATCH"
		SET AREA STYLE "SOLID"
			
	    END SELECT
	END IF

	SET AREA COLOR area_color
	ASK AREA STYLE area_style 

	!+
	!   Avoid having the first and last (adjacent)
	!   pieces of the pie being the same color and fill
	!-
	
	IF (loop_count = 1) AND  &
	    (area_color = 1) AND	&
	    (area_style = 'SOLID')
	THEN
	    SET AREA COLOR max_color
	END IF
	       
	area_color = MOD(area_color, max_color) + 1
	    
	!+
	!   GRAPH the PIE "slice"
	!-

	MAT GRAPH AREA , count (pies-first_point+1) : x_pie, y_pie

	!+
	!   Draw the LABEL for this "slice" of the PIE.
	!-

	mid_point = first_point + (last_point-first_point)/2
	mid_pie_x = xs(mid_point )
	mid_pie_y = ys(mid_point )

	IF mid_pie_x < 0
	THEN
	    x_dir = -1
	    SET TEXT JUSTIFY 'RIGHT', 'HALF'
	ELSE
	    x_dir = 1
	    SET TEXT JUSTIFY 'LEFT', 'HALF'
	END IF

	GRAPH LINES mid_pie_x, mid_pie_y ; &
		1.15*mid_pie_x+(.05*x_dir), 1.15*mid_pie_y

	ASK WINDOW xmin, xmax, ymin, ymax
	SET TEXT HEIGHT .020*(xmax - xmin)

	too_big = -1
	temp_label = labels (loop_count) + ' ' + &
		    FORMAT$(data_arr(loop_count)*100.0/data_total, "###.#") + '%'

	!+
	!   Check that the label fits.  If not, reduce the size repeatedly
	!   until it does fit.
	!-

	WHILE too_big
	    ASK TEXT EXTENT, temp_label AT &
		    1.15*mid_pie_x+(.09*x_dir), 1.15*mid_pie_y: xextent, yextent

	    too_big = 0		IF x_dir = -1 AND xextent(0) > xmin
	    too_big = 0		IF x_dir = 1  AND xextent(1) < xmax

	    IF too_big
	    THEN
		ASK TEXT HEIGHT theight
		SET TEXT HEIGHT theight*.9
	    END IF

	NEXT

	GRAPH TEXT AT 1.15*mid_pie_x+(.09*x_dir), 1.15*mid_pie_y: temp_label 
    NEXT loop_count

END SUB


    SUB PLOT (INTEGER num_of_points, SINGLE xarr(), yarr(), STRING xlab, ylab)

    !+
    !	This is a program which will plot NUM_OF_POINTS points in the
    !	arrays XARR and YARR.  The labels for the axis are specified
    !	by XLAB and YLAB.
    !

    OPTION TYPE = EXPLICIT, CONSTANT TYPE = INTEGER 

    DECLARE INTEGER CONSTANT green = 1%
    DECLARE INTEGER CONSTANT red = 2%
    DECLARE INTEGER CONSTANT blue = 3%

    DECLARE STRING TRIMMED_XLAB, TRIMMED_YLAB

    DECLARE SINGLE x_min, x_max, y_min, y_max, x_incr, y_incr
    DECLARE LONG do_x, i

    !+
    !   Determine MAX and MIN values for X and Y
    !-

    x_min, y_min = 2.0**31
    y_max, x_max = -2.0**31

    FOR i = 0% TO num_of_points - 1%
	x_min = xarr(i)		IF xarr(i) < x_min
	x_max = xarr(i)		IF xarr(i) > x_max
	Y_min = yarr(i)		IF yarr(i) < y_min
	y_max = yarr(i)		IF yarr(i) > Y_max
    NEXT i

    SET WINDOW x_min - .30*(x_max - x_min), x_max + .10 * (x_max - x_min), &
	    y_min - .30 * (y_max - y_min), y_max + .10*(y_max - y_min)

    CLEAR

    !+
    !	Find the appropriate interval size
    !-

    x_incr = (x_max - x_min)/10%
    y_incr = (y_max - y_min)/10%

    DIM single xx(10%), yy(10%)

    !+
    !   Fill in background of graph area
    !-

    XX(0) = x_min \ yy(0) = y_min
    xx(1) = x_max \ yy(1) = y_min

    XX(2) = x_max \ yy(2) = y_max
    xx(3) = x_min \ yy(3) = y_max

    SET AREA COLOR blue
    SET AREA STYLE 'SOLID'
    MAT GRAPH AREA, COUNT 4%: xx,yy

    !+
    !   Define characteristics of Axis lines
    !-

    SET LINE STYLE 1
    SET LINE COLOR green

    !+
    !   Draw axis
    !-

    MAT GRAPH LINES, COUNT 2%: XX,YY

    XX(0) = x_min \ yy(0) = y_min
    xx(1) = x_min \ yy(1) = y_max
    MAT GRAPH LINES, COUNT 2%: XX, YY

    !+
    !   Label and mark increments on AXIS
    !-

    SET POINT STYLE 2
    SET POINT SIZE .3
    SET POINT COLOR GREEN
    SET CLIP 'OFF'

    SET TEXT HEIGHT .035 * (y_max - y_min)

    xx(0) = x_min
    yy(0) = y_min
    do_x = 1
    FOR i = 1% TO 10%

	yy(i) = y_min + (i * y_incr)
	SET TEXT JUSTIFY "RIGHT", "HALF"
	GRAPH TEXT AT x_min-.25*x_incr,yy(i): NUM1$(int(yy(i)*100%)/100.0)
	GRAPH POINTS x_min, yy(i)

	!+
	!   Only label every other increment on X axis because of space
	!-

	xx(i) = x_min + (i * x_incr)
	IF do_x
	THEN
	    SET TEXT JUSTIFY "CENTER", "TOP"
		GRAPH TEXT AT xx(i), y_min - .5* y_incr: &
				    NUM1$(int(xx(i)*100%)/100.0)
	END IF
	do_x = 1 - do_x
	GRAPH POINTS xx(i), y_min
    NEXT i

    !+
    !   PLOT POINTS
    !-

    SET POINT COLOR red
    SET POINT SIZE .5

    MAT GRAPH POINTS, COUNT num_of_points: xarr, yarr

    !+
    !   Connect points with solid line
    !-

    SET LINE COLOR red
    MAT GRAPH LINES, COUNT num_of_points: xarr, yarr

    !+
    !   Label AXIS
    !-

    trimmed_xlab = EDIT$(xlab, 8 + 128)		! Trim leading and trailing spaces and tabs
    trimmed_ylab = EDIT$(ylab, 8 + 128)		! Trim

    SET TEXT JUSTIFY "CENTER", "HALF"

    SET TEXT HEIGHT .05 * (y_max - y_min)
    GRAPH TEXT AT x_min + .55 *(x_max - x_min), &
		    y_min - .15 * (y_max - y_min): trimmed_xlab
    SET TEXT PATH "DOWN"
    GRAPH TEXT AT x_min -.25 * (x_max - x_min), &
		    y_min + .55 * (y_max - y_min) : trimmed_ylab

    END SUB

PICTURE square(LONG color_var, SINGLE Square_size )

   SET LINE COLOR color_var
   PLOT LINES : -Square_size,  Square_size;	&
		 Square_size,  Square_size;	&
		 Square_size, -Square_size;	&
		-Square_size, -Square_size;	&
		-Square_size,  Square_size		

END PICTURE
