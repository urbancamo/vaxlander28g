PROGRAM Sine
OPTION TYPE = EXPLICIT
DECLARE REAL turn, x, y

FOR turn = 0.0 TO 2.0 * PI STEP 0.1
	x = (turn/(2.0 * PI))
	y = ((SIN(turn) * 0.5) + 0.5)
	PLOT LINES x,y;
NEXT turn

PLOT LINES
END PROGRAM
