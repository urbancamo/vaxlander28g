PROGRAM ELLIPSE

    OPTION TYPE = EXPLICIT

    EXTERNAL PICTURE RECURS_ELLIPSE (REAL, ,LONG)

    SET WINDOW -0.5,0.5,-0.5,0.5   
    DRAW RECURS_ELLIPSE(0.9,0.1,0)

    SLEEP 5%
END PROGRAM 

PICTURE RECURS_ELLIPSE (REAL Width, Height_1, LONG counter)
    
    OPTION TYPE = EXPLICIT

    EXTERNAL PICTURE recurs_ellipse(REAL,,LONG)
    DECLARE SINGLE CONSTANT Number_of_steps = 60

    DECLARE SINGLE  Half_width, &
		    Half_Height, &
		    Half_width_squared, &
		    Half_height_squared, &
		    Increment, &
		    X_pos, &
		    Y_pos
    !+
    ! This picture is based on the general formula of an ellipse centered
    ! at (0,0):
    !
    !	x^2   y^2
    !	--- + --- = 1
    !	b^2   a^2
    !
    ! "A" is one half the major axis dimension of the ellipse, and "b" is one
    ! half the minor axis dimension.
    ! This formula yields an ellipse whose major axis is on the y axis,
    ! so later on we will call "a" "Half_height", and call "b" "Half_width".
    !
    ! Solving this equation for y, we have the alternate form:
    !
    !	y^2       x^2				      x^2
    !	--- = 1 - ---	    or	    y^2 = b^2 * ( 1 - --- )
    !	b^2       a^2				      a^2
    !
    ! Since a^2 and b^2 are used in the calculation of each point, and since
    ! they are constant during the execution of this picture, we set aside
    ! separate variables for each, and calculate them only once. "A^2" is called
    ! "Half_height_squared" and "b^2" is "Half_width_squared".
    !-

    Half_height = Height_1 / 2
    Half_width = Width / 2
    Half_height_squared = Half_height * Half_height
    Half_width_squared = Half_width * Half_width

    Increment = Width/Number_of_steps

    !+
    ! Draw the top of the ellipse...
    !-

    PLOT LINES -Half_width, 0;
    FOR X_pos = -Half_width + Increment TO Half_width STEP Increment
    	Y_pos = SQRT (ABS (Half_height_squared * &
			    (1-X_pos*X_pos/Half_width_squared)))
        PLOT LINES X_pos, Y_pos;
    NEXT X_pos

    !+
    ! Since we cannot assure that the FOR loop above will exactly terminate
    ! at +Half_width due to the imprecision of floating point arithmetic,
    ! complete the top half of the ellipse.
    !-

    PLOT LINES Half_width, 0;

    !+
    ! Now draw the bottom of the ellipse.
    !-

    FOR X_pos = Half_width - Increment TO -Half_width STEP -Increment
	Y_pos = -SQRT (ABS (Half_height_squared * &
			    (1-X_pos*X_pos/Half_width_squared)))
        PLOT LINES X_pos, Y_pos;
    NEXT X_pos

    !+
    ! Since we cannot assure that the FOR loop above will exactly terminate
    ! at -Half_width due to the imprecision of floating point arithmetic,
    ! complete the bottom half of the ellipse.
    !-

    PLOT LINES -Half_width, 0

    counter = counter + 1
    IF counter < 18
    THEN
	width = width - 0.05
	height_1 = height_1 + 0.05
	IF counter > 12
	THEN 
	    SET LINE COLOR 3
	ELSE 
	    IF counter > 6
	    THEN 
		SET LINE COLOR 2
	    END IF
	END IF
	DRAW recurs_ellipse(width,height_1,counter)
    ELSE 
	EXIT PICTURE
    END IF

END PICTURE	
