!
!================================================
! Check if lander has landed
!
SUB TESTLAND

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$LANDED"

IF LanderState::y <= 0 ! AND LanderState::br = 0
THEN 
    LET GameState::landed = True
    CALL LANDED
END IF

END SUB
