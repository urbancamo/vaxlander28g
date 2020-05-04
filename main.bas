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
%INCLUDE "GLOBALS"
%INCLUDE "EXT$INITIAL"

EXTERNAL SUB SIMLOOP

! Set the initial game state
LET GameState::landed = False
LET GameState::restart = False
LET GameState::quit = False
LET GameState::st = 0
LET GameState::ts = 10
LET GameState::gravity = 10 / 3 ! Gravity, metres/second

CALL INITIAL
CALL SIMLOOP

IF GameState::quit = True
THEN 
    PRINT "DONE"
END IF

END PROGRAM
