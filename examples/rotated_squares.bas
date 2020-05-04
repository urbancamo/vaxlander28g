PROGRAM Rotated_squares

	!+
	! Draws square rotated and scaled			
	!-

	OPTION	TYPE = EXPLICIT, CONSTANT TYPE = INTEGER

	EXTERNAL PICTURE square ( LONG, SINGLE )

	DECLARE SINGLE CONSTANT Square_size = 0.05

	DECLARE LONG color_var,		&
                SINGLE counter

        SET WINDOW -1.0,1.0,-1.0,1.0

        color_var = 1
  	DRAW square(color_var, Square_size)
	FOR counter =  1.0 TO 13.0 STEP 0.25
	    Color_var = MOD(Color_var+1, 3) + 1
	    DRAW Square(Color_var, Square_size) 			&
		WITH ROTATE(counter) * SCALE(counter,counter)
        NEXT counter
    
	SLEEP 5%  
END PROGRAM 
