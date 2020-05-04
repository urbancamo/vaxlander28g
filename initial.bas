!
!
!================================================
! Set the initial lander conditions
!
SUB INITIAL

%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"

LET LanderState::vsi = 0	! Vertical Speed Indicator Position
LET LanderState::pvsi = 3	! Previous VSI indicator
LET LanderState::alt = 0 	! Altitude indicator
LET LanderState::palt = 3 	! Previous altitude indicator
LET LanderState::hpi = 0	! Horizontal position indicator
LET LanderState::la = 60	! Lander angle (0=vertical)
LET LanderState::br = 0		! Burn rate/%
LET LanderState::f = 25000 	! Initial fuel/kg
LET LanderState::x = -30000 	! Range to landing site
LET LanderState::y = 10000	! Initial height/metres
LET LanderState::dx = 500	! Initial horizontal velocity/ms
LET LanderState::dy = 0 	! Initial vertical velocity/ms
LET LanderState::vertThrust = 0 	! Vertical thrust component
LET LanderState::horizThrust = 0 	! Horizontal thrust component

END SUB
