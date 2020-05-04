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

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "EXT$PRINT_TAB"

EXTERNAL SUB SIMLOOP

! This defines the global variable 'LanderState' to be a record of type LanderStateType
DECLARE LanderStateType LanderState

! Variable defining the state of the game
DECLARE GameStateType GameState

! Set the initial game state
LET GameState::landed = False
LET GameState::restart = False
LET GameState::quit = False
LET GameState::st = 0
LET GameState::ts = 100
LET GameState::gravity = 10 / 3 ! Gravity, metres/second

CALL SIMLOOP

IF GameState::quit = True
THEN 
    CALL PRINT_TAB(0, 10, "DONE")
    EXIT
END IF

END PROGRAM
