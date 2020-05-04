! LUNAR LANDER, by Mark Wickens
! developed for Summer 2010 Retrochallenge
! V30A, 30-JUL-2010
! http://hecnet.eu/rc2010sc
!
! Modified from the Z88/BBC BASIC version to run under VAX/VMS and OpenVMS Alpha
! for the 2020/04 Retrochallenge competition
!
! Preamble
! ========
! Require that all variable as declared
!
!================================================
PROGRAM VAXLander28G

OPTION TYPE = EXPLICIT

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

! This defines the global variable 'LanderState' to be a record of type LanderStateType
DECLARE LanderStateType LanderState

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

! Variable defining the state of the game
DECLARE GameStateType GameState

! Set the initial game state
LET GameState::landed = False
LET GameState::restart = False
LET GameState::quit = False
LET GameState::st = 0
LET GameState::ts = 100
LET GameState::gravity = 10 / 3 ! Gravity, metres/second

EXTERNAL SUB SIMLOOP

CALL SIMLOOP
STOP

END PROGRAM
