!
!
!================================================
! Restart the game
SUB RESTART

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$INITIAL"

LET GameState::restart = False
CALL INITIAL

END SUB
