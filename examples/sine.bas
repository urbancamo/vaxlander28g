    OPTION ANGLE = DEGREES

    CALL half_screen
    SET WINDOW 0,360,-1,1

    !+
    !  DRAW X and Y AXIS
    !-

    GRAPH LINES 0,-1 ; 0,1
    GRAPH LINES 0,0 ; 360,0

    !+
    !	PLOT SINE curve
    !-

    PLOT LINES : x,SIN (x) ;	FOR x = 0 to 360 STEP 10

    SLEEP 10%
    END
