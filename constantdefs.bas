DECLARE INTEGER CONSTANT True = 1
DECLARE INTEGER CONSTANT False = 0


! Records (Structures)
! This record encapsulates the dynamic state of the lander
!
RECORD LanderStateType
    LONG vsi		! Vertical Speed Indicator Position
    LONG pvsi		! Previous VSI indicator
    LONG alt		! Altitude indicator
    LONG palt           ! Previous altitude indicator
    LONG hpi            ! Horizontal position indicator
    LONG la             ! Lander angle (0=vertical)
    LONG br		! Burn rate/%
    LONG f		! Fuel remaining/kg
    LONG x		! Range to landing site
    LONG y		! Initial height/metres
    LONG dx		! Initial horizontal velocity/ms
    LONG dy		! Initial vertical velocity/ms
    LONG vertThrust	! Vertical thrust component
    LONG horizThrust	! Horizontal thrust component
END RECORD LanderStateType


! This record can hold the state of a game
RECORD GameStateType
    LONG landed	! Set to 1 when landed
    LONG restart	! pilot has requested game restart
    LONG quit
    LONG st 		! Step counter
    LONG ts
    LONG score		! The final score, if eligible for one!
    LONG gravity
END RECORD GameStateType

