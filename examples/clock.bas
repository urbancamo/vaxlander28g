PROGRAM What_time_is_it

!+
! This BASIC program draws a clock which displays the correct time.  The clock
! will be drawn with the center at 0,0, with a radius specified as a parameter
! in the DRAW statement.  
!-

    EXTERNAL PICTURE CLOCK (SINGLE,LONG)

    DECLARE LONG Minutes_to_run

    SET WINDOW -50,50,-50,50

    INPUT "Minutes to run"; Minutes_to_run

    DRAW CLOCK (40, MINUTES_TO_RUN)

END PROGRAM

PICTURE CLOCK (SINGLE RADIUS, LONG CLOCK_LIFE)

!+
!   This PICTURE draws a clock at 0,0 in world coordinates, using
!   the specified radius.  The clock will "run" by continually repainting
!   the hands according to the system time.
!-

OPTION ANGLE = DEGREES,					&
       TYPE = EXPLICIT,					&
       CONSTANT TYPE = INTEGER

EXTERNAL PICTURE CLOCK_FACE (SINGLE)
EXTERNAL PICTURE CLOCK_HAND (SINGLE, SINGLE, LONG, LONG)
EXTERNAL BYTE FUNCTION CHECK_HANDS (LONG, LONG)

DECLARE LONG HOUR_ANGLE, MINUTE_ANGLE, SECOND_ANGLE, MINUTE, MINUTES
DECLARE LONG OLD_HOUR_ANGLE, OLD_MINUTE_ANGLE
DECLARE SINGLE HOURS, TIME_IN_SECS, TIME_IN_MINS
DECLARE BYTE HANDS_OVERLAP
DECLARE SINGLE SECOND_HAND_SIZE, MINUTE_HAND_SIZE, HOUR_HAND_SIZE
DECLARE LONG DEV_TYPE
DECLARE LONG SECONDS_BETWEEN_REPAINTS, REPAINTS_PER_MINUTE

DECLARE BYTE CONSTANT TRUE = 1, 			&
		       FALSE = 0

DECLARE SINGLE CONSTANT SECOND_HAND_SCALE = 0.65, 	&
			MINUTE_HAND_SCALE = 0.6, 	&
			HOUR_HAND_SCALE   = 0.45

DECLARE LONG CONSTANT   SECOND_HAND_WIDTH = 3,  	&
			MINUTE_HAND_WIDTH = 5,  	&
			HOUR_HAND_WIDTH   = 6

DECLARE LONG CONSTANT 	BLACK = 0, 			&
		    	GREEN = 1, 			&
			RED =   2,			&
			BLUE =  3

!+
!   Draw the face of the clock
!-

SET LINE COLOR GREEN
DRAW CLOCK_FACE (RADIUS)

!+
!   Set up the size of the clock hands.
!-

SECOND_HAND_SIZE = RADIUS * SECOND_HAND_SCALE
MINUTE_HAND_SIZE = RADIUS * MINUTE_HAND_SCALE
HOUR_HAND_SIZE = RADIUS * HOUR_HAND_SCALE

!+
!   Decide how often we want to update the second hand.  If we are
!   running on a VAXstation, we will update once per second.  Otherwise,
!   we will update once every 5 seconds.
!-

ASK DEVICE TYPE DEV_TYPE
IF DEV_TYPE = 41	! Device type for a VAXstation
THEN
    SECONDS_BETWEEN_REPAINTS = 1
ELSE
    SECONDS_BETWEEN_REPAINTS = 5
END IF

REPAINTS_PER_MINUTE = 60 / SECONDS_BETWEEN_REPAINTS

FOR MINUTE = 1 TO CLOCK_LIFE

!+
!   Figure out what time it is, in hours and minutes
!-

    TIME_IN_SECS = TIME(0)
    TIME_IN_MINS = INT (TIME_IN_SECS / 60)
    HOURS = TIME_IN_MINS / 60
    MINUTES = MOD (TIME_IN_MINS, 60)

!+
!   Calculate the angles for the hour and minute hands
!-

    HOUR_ANGLE = - INT( (HOURS - 3) * 30 )
    MINUTE_ANGLE = -( (MINUTES - 15%) * 6%)

!+
!   Erase the old hour and minutes hands (by drawing over them using
!   the background color) and draw the new ones
!-

    DRAW CLOCK_HAND (RADIUS, HOUR_HAND_SIZE, HOUR_HAND_WIDTH, BLACK) 	 &
			WITH ROTATE (OLD_HOUR_ANGLE)		

    DRAW CLOCK_HAND (RADIUS, MINUTE_HAND_SIZE, MINUTE_HAND_WIDTH, BLACK) &
			WITH ROTATE (OLD_MINUTE_ANGLE)		

    DRAW CLOCK_HAND (RADIUS, HOUR_HAND_SIZE, HOUR_HAND_WIDTH, BLUE) 	 &
			WITH ROTATE (HOUR_ANGLE)			

    DRAW CLOCK_HAND (RADIUS, MINUTE_HAND_SIZE, MINUTE_HAND_WIDTH, BLUE)  &
			WITH ROTATE (MINUTE_ANGLE)		

!+
!   Make the second hand sweep around (this should take about 1 minute)
!   We will update the second hand the number of times specified in
!   REPAINTS_PER_MINUTE.
!-
    FOR SECOND_ANGLE = 60 TO -270 STEP -(360/REPAINTS_PER_MINUTE)
        DRAW CLOCK_HAND (RADIUS, SECOND_HAND_SIZE, SECOND_HAND_WIDTH, RED) &
			WITH ROTATE (SECOND_ANGLE)		
        SLEEP SECONDS_BETWEEN_REPAINTS

	!+
	! Erase the old hand by re-painting it the same color as the background
	!-

        DRAW CLOCK_HAND (RADIUS, SECOND_HAND_SIZE, SECOND_HAND_WIDTH, BLACK) &
			WITH ROTATE (SECOND_ANGLE)		

	!+
	! If erasing the second hand has over-written either of the other two
	! hands, repaint them.
	!-

        HANDS_OVERLAP = CHECK_HANDS (MINUTE_ANGLE, SECOND_ANGLE)
    	IF HANDS_OVERLAP = TRUE
    	THEN
	    DRAW CLOCK_HAND (RADIUS, MINUTE_HAND_SIZE, MINUTE_HAND_WIDTH, &
			      BLUE) WITH ROTATE (MINUTE_ANGLE)
    	END IF

    	HANDS_OVERLAP = CHECK_HANDS (HOUR_ANGLE, SECOND_ANGLE)
    	IF HANDS_OVERLAP = TRUE
    	THEN
	    DRAW CLOCK_HAND (RADIUS, HOUR_HAND_SIZE, HOUR_HAND_WIDTH, BLUE) &
			WITH ROTATE (HOUR_ANGLE)
    	END IF

    NEXT SECOND_ANGLE

    !+
    ! Save the current position of the hour and minute hands, so we can
    ! erase them.
    !-

    OLD_HOUR_ANGLE = HOUR_ANGLE
    OLD_MINUTE_ANGLE = MINUTE_ANGLE

NEXT MINUTE

END PICTURE

!+
!   Bring in the picture for drawing circles.
!-

%INCLUDE "CIRCLE" %FROM %LIBRARY &
			"SYS$COMMON:[SYSHLP.EXAMPLES.BASIC]BASIC$GRAPHICS.TLB"

PICTURE Circle_area (SINGLE Center_X, Center_Y, Radius)

!+
!   This picture draws a circular area with the given center and radius.
!-

    OPTION ANGLE = RADIANS,				&
       TYPE = EXPLICIT,					&
       CONSTANT TYPE = INTEGER

    DECLARE SINGLE X, X_ARRAY(150), Y_ARRAY (150)
    DECLARE LONG I

    FOR X = 0 TO 2 * PI STEP .05
	X_ARRAY (I) = Radius * SIN (X) + Center_X
	Y_ARRAY (I) = Radius * COS (X) + Center_Y
	I = I + 1
    NEXT X

    MAT GRAPH AREA X_ARRAY, Y_ARRAY

END PICTURE

PICTURE CLOCK_FACE (SINGLE RADIUS)

!+
!   This picture draws the face of the clock at 0,0 in world coordinates,
!   using the specified radius.
!-

OPTION ANGLE = DEGREES,					&
       TYPE = EXPLICIT,					&
       CONSTANT TYPE = INTEGER

EXTERNAL PICTURE CIRCLE (SINGLE, SINGLE, SINGLE)
EXTERNAL PICTURE CIRCLE_AREA (SINGLE, SINGLE, SINGLE)

DECLARE STRING NEXT_NUMBER
DECLARE SINGLE NUMBER_RADIUS, HOW_HIGH
DECLARE SINGLE X

!+
!   Draw two concentric circles to form the outline of the clock.
!   Draw a filled-in circle for the center.
!-

DRAW CIRCLE (0, 0, RADIUS)
DRAW CIRCLE (0, 0, RADIUS * .98)
DRAW CIRCLE_AREA (0, 0, RADIUS * 0.05)

!+
!   Draw in the numbers, using a text font that looks nice.  Adjust the
!   text height to be proportional to the radius of the circle.
!-

DATA 12,1,2,3,4,5,6,7,8,9,10,11

SET TEXT FONT -16, "STROKE"
ASK TEXT HEIGHT HOW_HIGH
SET TEXT HEIGHT HOW_HIGH * RADIUS * 5
SET TEXT JUSTIFY "CENTER", "HALF"

NUMBER_RADIUS = RADIUS * .85

FOR X = 0.0 TO 330.0 STEP 30.0
    READ NEXT_NUMBER
    GRAPH TEXT AT NUMBER_RADIUS * SIN(X), NUMBER_RADIUS * COS(X) : NEXT_NUMBER
NEXT X

END PICTURE

PICTURE CLOCK_HAND (SINGLE RADIUS, LENGTH, LONG WIDTH, COLOR_VALUE)

!+
!   This picture draws a clock hand.  By specifying a different length,
!   width and color, you can draw hour, minute, and second hands.
!-

OPTION ANGLE = DEGREES,					&
       TYPE = EXPLICIT,					&
       CONSTANT TYPE = INTEGER

DECLARE SINGLE DELTA, X_START

SET LINE SIZE WIDTH
SET LINE COLOR COLOR_VALUE
SET AREA COLOR COLOR_VALUE

!+
!   Calculate X_START such that the hand does not over-write the 
!   center circle.
!-

X_START = RADIUS * 0.05
DELTA = RADIUS * 0.05

!+
!  Draw the hand as an arrow (a line with a triangle at the end).
!  The untransformed picture draws the hand along the x-axis.
!  Rotate it to the desired position with a ROTATE transformation
!  on the DRAW statement that invokes this picture.
!-

PLOT LINES X_START, 0; LENGTH, 0
PLOT AREA (LENGTH + DELTA), 0; LENGTH, DELTA; LENGTH, (- DELTA)

END PICTURE

FUNCTION BYTE CHECK_HANDS (LONG ANGLE1, LONG ANGLE2)

!+
!   This function returns TRUE the specified hands will overlap.
!   Use this function to determine whether or not to re-draw the
!   fixed (minute or hour) hand.
!-

OPTION ANGLE = DEGREES,					&
       TYPE = EXPLICIT,					&
       CONSTANT TYPE = INTEGER

DECLARE BYTE CONSTANT TRUE = 1, &
		       FALSE = 0
DECLARE BYTE CONSTANT DELTA = 10
DECLARE LONG FIXED_HAND, MOVING_HAND

FIXED_HAND = MOD (ANGLE1 + 720%, 360%)
MOVING_HAND = MOD (ANGLE2 + 720%, 360%)

IF (MOVING_HAND - DELTA) < FIXED_HAND AND 		&
   (MOVING_HAND + DELTA) > FIXED_HAND
THEN
    EXIT FUNCTION TRUE
END IF

END FUNCTION FALSE
