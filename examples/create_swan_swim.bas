    PROGRAM CREATE_SWAN_SWIM
	 EXTERNAL PICTURE Swan
    	 SET WINDOW , TRAN 1 : -200,200,-200,200
	 DRAW Swan WITH SHIFT(50,0)
	 DRAW Swan WITH SHIFT(-25,0)
	 DRAW Swan WITH SHIFT(-100,0)
	 DRAW Swan WITH SHIFT(-135,-100)
	 DRAW Swan WITH SHIFT(-60,-100)
	 DRAW Swan WITH SHIFT(15,-100)
	 DRAW Swan WITH SHIFT(90,-100)

	 SET TEXT HEIGHT 10%
	 GRAPH TEXT AT -50,-5 : "Seven Swans A-Swimming"

	 SLEEP 5%
    END PROGRAM

    PICTURE Swan
	 OPTION TYPE = EXPLICIT
	 DECLARE LONG Counter
	 DECLARE SINGLE X_Array(98), Y_Array(98), 		&
			Mark_X(3), Mark_Y(3),			&
			Eye_X(2), Eye_Y(2),			&
	                Wing_Area_x(28), Wing_Area_Y(28)

	 Outline_Data:
	        DATA 82,80.5,80,80.5,75,81,72,81.5,70,83.5,	           &
	  	     68,84,65,84.5,63,83,61,82,60.5,80,60.55,78,	   &
		     62.5,75,64,70,66.5,67,70,62.5,72,60,75,57,78,54,      &
	             80,50,82.5,46,84,40,86.5,30,87,24.5,87,20,86,17.5,    &
	             83.5,13.5,82,12,80,11.5,77,10,70,9,65,9,60,9.2,       &
	             53,10,50,10.5,40,12,35,14,30,18,27,20,20,27.5,        &
	             14,36,12,40,8.5,50,8,59,10,52.5,14,48,20,45,17,50,	   &
		     16.75,57,20,60,18,61.5,20,67,27,75,27.5,72,37,85,36,  &
		     80,34,75,32.25,70,32,65,32.25,60,32.35,58,34,53,35,   &
		     50,38,45,40,41,43.5,38,48,34,52,32.5,60,31,63,32,	   &
		     69.5,35.5,70.5,37,72,40,70.5,43,69.5,47,68.5,50,      &
		     65.5,55,62.5,60,60,65,57.5,70,55,75,54,80,54.25,83,   &
		     54,84.5,55,87,59,90,60,91,63,92.25,66.5,93,68,92.75,  &
	             70,92,71.5,91,73,89.5,74,87,75.5,85,78,84,80,82,82,   &
		     82,80,80.5,82,80.5

	 Wing_Area_Data:		
	        DATA 32.35,58,34,53,35,50,38,45,40,41,43.5,38,48,34,52,    &
		     32.5,60,31,63,32,69.5,35.5,70.5,37,32.35,58,30.05,	   &
		     50,28,42,27.5,44.5,28.5,30,30,24,31.5,20,35,14,	   &
	 	     40,12,45,13,50,14,53,15,58.5,17.5,61,19,64.5,22,69,   &
		     30,70.5,37

	 Head_Mark_Area:
	        DATA	73,87,70,86,73,85,73.15,86,67,89,69,88,70.5,90
	        	
	 READ X_Array(Counter),Y_Array(Counter) FOR Counter = 0% TO 98%
	 READ Wing_Area_X(Counter),Wing_Area_Y(Counter) FOR Counter = 0% TO 28%
	 READ Mark_X(Counter),Mark_Y(Counter) FOR Counter = 0% TO 3%
	 READ Eye_X(Counter), Eye_Y(Counter) FOR Counter = 0% TO 2%  

	 Display_The_Swan:
	  	SET LINE COLOR 1
	  	SET LINE STYLE 1
	   	MAT PLOT LINES X_Array, Y_Array
		SET AREA STYLE "SOLID"
		MAT PLOT AREA : Wing_Area_X, Wing_Area_Y
	 	SET LINE COLOR 2
		MAT PLOT LINES Eye_X, Eye_Y
		MAT PLOT AREA : Mark_X, Mark_Y
    END PICTURE
