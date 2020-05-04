!
!================================================
! Process landing
!
SUB LANDED

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$DISPLAY"

IF LanderState::dx < 0 
THEN 
    LET LanderState::dx = -LanderState::dx
END IF

IF LanderState::x < 0 
THEN 
    LET LanderState::x = -LanderState::x
END IF

CALL DISPLAY

IF LanderState::dx <= 6 AND LanderState::dy >= -6
THEN 
    CALL PRINT_TAB(0, 4, "You have landed successfully!")
END IF

IF LanderState::dx < 6 AND LanderState::dy < -3 AND LanderState::dy > -6 
THEN 
    CALL PRINT_TAB(0, 4, "You have landed with a bounce!")
END IF

IF LanderState::dy < -6 OR LanderState::dx > 6 
THEN 
    CALL PRINT_TAB(0, 4, "You have CRASHED!")
END IF

! TODO: @%=&00000000

IF X > 500 
THEN 
    PRINT X; " metres from the landing site"
END IF

IF LanderState::dy < -6.0 
THEN 
    PRINT "You left a crater "; (ABS(LanderState::dy)*2.5); " metres deep"
END IF

IF LanderState::dx = 0.0 
THEN
    LET LanderState::dx = 0.1
END IF

IF LanderState::dy = 0.0
THEN 
    LET LanderState::dy = 0.1
END IF

LET divisor = ABS( LanderState::dx ) * ABS( LanderState::dy )
IF divisor > 0
THEN
   LET GameState::score = 100 / divisor
END IF

IF ABS(LanderState::x) < 500 AND ABS(LanderState::dx) < 6.0 AND ABS(LanderState::dy) < 6.0 
THEN
    PRINT "YOUR SCORE IS: "; GameState::score
END IF

END SUB
