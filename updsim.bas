!
!================================================
! Update simulation parameters
!
SUB UPDSIM

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"

! horizontal component of lander angle multiplied by burn rate
LET LanderState::horizThrust = LanderState::la / 90 * LanderState::br / 10 

LET LanderState::vertThrust = ( 1 - ( ABS( LanderState::la ) / 90 ) ) * LanderState::br / 10

! vert. speed affected by gravity and vert. thrust
LET LanderState::dy = LanderState::dy - GameState::gravity + LanderState::vertThrust 

LET LanderState::y = LanderState::y + LanderState::dy

LET LanderState::dx = LanderState::dx - LanderState::horizThrust

LET LanderState::x = LanderState::x + LanderState::dx

! If there is not enough fuel left to sustain the burn rate, then use what is left
IF LanderState::f - LanderState::br < 0 
THEN 
    LET LanderState::br = LanderState::f
END IF

! Reduce fuel remaining by the burn rate
IF LanderState::f > 0
THEN 
   LET LanderState::f = LanderState::f - LanderState::br
END IF

! If we have hit the ground set height to zero
IF LanderState::y < 0
THEN 
    LET LanderState::y = 0
END IF

END SUB
