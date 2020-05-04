    PROGRAM FONT_DEMO

    !+
    !	This program will output an example of all available text fonts.
    !-

    OPTION TYPE = EXPLICIT
    DECLARE LONG variety

    SET WINDOW 0,100,0,100
    SET TEXT HEIGHT 5

    FOR variety = -1 TO -23 STEP -1
	SET TEXT FONT variety , "STROKE"
	IF variety > -13
	THEN
	    GRAPH TEXT AT 0,100-(ABS(variety) * 8) : &
			    "Font No. " + STR$(variety)
	ELSE
	    GRAPH TEXT AT 50,100-(ABS((variety) * 8) - 90) : &
			    "Font No. " + STR$(variety)
	END IF  
    NEXT variety
    SLEEP 5%
    END PROGRAM
