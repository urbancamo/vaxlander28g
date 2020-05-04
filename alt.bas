!
!
!================================================
SUB ALT

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$UPDTAPE"

IF LanderState::y > 75 
THEN 
    LanderState::alt = -1 
ELSE 
    LET LanderState::alt = 6 - ( LanderState::y / 75 * 6 )
END IF

IF LanderState::alt <> LanderState::palt
THEN 
    CALL UPDTAPE( 50, LanderState::alt, LanderState::palt)
END IF

LET LanderState::palt = LanderState::alt

IF LanderState::palt < 0 
THEN
    LET palt = 0
END IF

IF LanderState::palt > 6 
THEN 
    LET LanderState::palt = 6
END IF

END SUB
