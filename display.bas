!
!================================================
! Generate the display
!
SUB DISPLAY

%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$PRINT_TAB"
%INCLUDE "EXT$PRINT_TABV"
%INCLUDE "EXT$TENW2DP"

CALL NAVDISPLAY
CALL TENW2DP

CALL PRINT_TABV(0, 0," F=", LanderState::f)
CALL PRINT_TABV(14, 0, " X=", LanderState::x)
CALL PRINT_TABV(28, 0, " Y=", LanderState::y)
CALL PRINT_TABV(0, 1, "DX=", LanderState::dx)
CALL PRINT_TABV(14, 1, "DY=", LanderState::dy)
CALL PRINT_TABV(28, 1, "BR=", LanderState::br)
CALL PRINT_TABV(0, 2, "LA=", LanderState::la)
CALL PRINT_TABV(14, 2, "VT=", LanderState::vertThrust)
CALL PRINT_TABV(28, 2, "HT=", LanderState::horizThrust)

LET stm = MOD(GameState::st, 2)
IF LanderState::f < 3000 AND stm = 0 
THEN 
    CALL PRINT_TAB(0, 3, "FUEL") 
ELSE 
    CALL PRINT_TAB(0, 3, "    ")
END IF


IF LanderState::dy > 0 
THEN 
    CALL PRINT_TAB(5, 3, "ASC") 
ELSE 
    CALL PRINT_TAB(5, 3, "   ")
END IF

IF LanderState::y < 1000 
THEN 
    CALL PRINT_TAB(9, 3, "RADAR")
END IF

IF LanderState::y < 3 
THEN 
    CALL PRINT_TAB(9, 3, "CONTACT") 
END IF

IF LanderState::y > 1000 
THEN
    CALL PRINT_TAB(9 ,3, "     ")
END IF

IF LanderState::br = 0 AND LanderState::f = 0 
THEN 
    CALL PRINT_TAB(17, 3, "ENGINE")
END IF

IF LanderState::x >= -500 AND LanderState::x <= 500 
THEN 
    CALL PRINT_TAB(24, 3, "RANGE") 
ELSE 
    CALL PRINT_TAB(24, 3, "     ")
END IF

CALL VSI
CALL ALT

END SUB
