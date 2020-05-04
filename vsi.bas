!
!
!================================================
SUB VSI

%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$UPDTAPE"

LET LanderState::vsi = ( 0 - LanderState::dy ) * 6 / 15
IF LanderState::vsi <> LanderState::pvsi
THEN 
    CALL UPDTAPE(59, LanderState::vsi, LanderState::pvsi)
END IF

LET LanderState::pvsi = LanderState::vsi

IF LanderState::pvsi < 0 
THEN 
    LET LanderState::pvsi = 0
END IF

IF LanderState::pvsi > 6 
THEN 
    LET LanderState::pvsi = 6
END IF

END SUB
