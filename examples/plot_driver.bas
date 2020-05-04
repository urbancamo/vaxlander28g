PROGRAM Plot_driver

    !+
    !	This routine provides an example interface to the PLOT routine.  
    !	You will be prompted to determine if the routine should generate
    !	points for an example plot, or if X,Y pairs are to be requested
    !	from the user.
    !-

    OPTION TYPE = EXPLICIT

    DECLARE INTEGER num_pts 
    DECLARE INTEGER CONSTANT max_num_pts = 40%
    DECLARE SINGLE X(max_num_pts), Y(max_num_pts)
    DECLARE LONG i, j
    DECLARE SINGLE f, temp
    DECLARE STRING prom,xlab, ylab

    INPUT 'ENTER "1" IF YOU WISH TO ENTER POINTS, ANYTHING ELSE FOR STD CURVE ';PROM
    num_pts = 0%

    WHEN ERROR IN 
  loop:
	WHILE -1
	IF prom = '1'
	THEN
	    input 'INPUT X > ';X(num_pts)
	    INPUT 'INPUT Y > '; Y(num_pts)
	    num_pts = num_pts + 1%
	ELSE
	    x(num_pts) = rnd*20
	    y(num_pts) = X(num_pts)**2
	    num_pts = num_pts + 1%
	    IF num_pts = 20% THEN EXIT LOOP END IF
	END IF
	NEXT 
	xlab = 'X VALUE'
	ylab = 'Y VALUE'
    USE
	INPUT 'X LABEL ';XLAB
	INPUT 'Y LABEL ';YLAB
        IF LEN(EDIT$(XLAB,8 + 128)) = 0 
        THEN
    	XLAB = 'X LABEL'
        END IF
        IF LEN(EDIT$(YLAB,8 + 128)) = 0 
        THEN
	    YLAB = 'Y LABEL'
        END IF
    END WHEN
    
    FOR J = 0% TO num_pts - 2%
	FOR I = J + 1% TO num_pts - 1%
	    IF X(I) < X(J)
	    THEN
		TEMP = X(I)
		X(I) = X(J)
		X(J) = TEMP
		TEMP = Y(I)
		Y(I) = Y(J)
		Y(J) = TEMP
	    END IF
	NEXT I
    NEXT J
    CALL entire_screen
    CALL PLOT (num_pts, x(), y(), xlab, ylab)
    SLEEP 5%
END PROGRAM 
