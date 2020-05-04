PROGRAM Party_crowd

    DIM SINGLE next_face(4,4), temp_face(4,4)
    EXTERNAL PICTURE face

    SET WINDOW 0,5,0,5

    !+
    !Draw the party crowd
    !-

    DRAW face WITH SCALE(1.25,3.25)
    DRAW face WITH SHIFT(1.5,1.25)

    MAT next_face = SHIFT(1.5,1.25) * SHEAR(15/57)
    DRAW face WITH next_face

    MAT temp_face = next_face * SHIFT(2,1)
    MAT next_face = temp_face * SHEAR(-30/57)	
    DRAW face WITH next_face

    MAT temp_face = next_face * SHIFT(-0.5,1.5)
    MAT next_face = temp_face
    DRAW face WITH next_face

    MAT temp_face = next_face * SHEAR(30/57)     
    MAT next_face = temp_face * SCALE(0.75,0.75) * SHIFT(-0.5,1)
    DRAW face WITH next_face

    MAT temp_face = next_face
    MAT next_face = temp_face * SHIFT(0,-3) * SCALE(1,0.75)
    DRAW face WITH next_face

    MAT temp_face = next_face
    MAT next_face = temp_face * SHIFT(-2,2)
    DRAW face WITH next_face

    MAT temp_face = next_face 
    MAT next_face = temp_face * SHIFT(1,1)  * SCALE(3/4,0.75)  
    DRAW face WITH next_face

    MAT temp_face = next_face * SHEAR(25/57) 
    MAT next_face = temp_face * SHIFT(1.5,-2.5) * SCALE(1,1.25)
    DRAW face WITH next_face
  
    DRAW face WITH ROTATE(300/57) * SHEAR(60/57)     &
             * SHIFT(1.25,0.75)


    SET TEXT HEIGHT 0.25
    GRAPH TEXT AT 0.25,3.4 : "Your BASIC Party Crowd"

    SLEEP 5%
END PROGRAM

PICTURE face

    EXTERNAL PICTURE head,mouth,eyes

    DRAW head
    DRAW eyes
    DRAW mouth

END PICTURE

PICTURE head

    DIM SINGLE xs(40), ys(40)

    radius = 0.5
    npoints = 40
    increment = 2*pi/npoints
    an_gle = 0

    for loop_count = 0 to npoints - 1
	x = cos ( an_gle ) * radius + 0.5
	y = sin ( an_gle ) * radius + 0.5
	xs(loop_count) = x 
	ys(loop_count) = y
	an_gle = an_gle + increment
    next loop_count

    xs(npoints) = xs(0)
    ys(npoints) = ys(0)
   
    MAT PLOT LINES : xs,ys
END PICTURE

PICTURE mouth

    DECLARE SINGLE mouth_x(6),mouth_y(6)

    DATA 0.25,0.425,0.34,0.36,0.4,0.325,   	&
             0.5,0.324,0.6,0.325,0.66,0.365,	&
             0.75,0.425

    READ mouth_x(loop),mouth_y(loop)  FOR loop = 0 TO 6
    MAT PLOT LINES : mouth_x,mouth_y

END PICTURE

PICTURE eyes

    DIM SINGLE eyes_x(1),eyes_y(1)
    SET POINT STYLE 4
    eyes_x(0) = 0.35
    eyes_x(1) = 0.65
    eyes_y(0) = 0.65
    eyes_y(1) = 0.65
    MAT PLOT POINTS : eyes_x,eyes_y

END PICTURE
