!
!
!================================================
! Pause the simulation
SUB PAUSE

%INCLUDE "EXT$PRINT_TAB"

CALL PRINT_TAB(0, 4, "PAUSED - Press 'P' to continue...")
LET C$ = ' '
UNTIL C$ = 'P' OR C$ = 'p'
    LET C$ = INKEY$(0%, WAIT)
NEXT
CALL PRINT_TAB(0, 4, "                                 ")

END SUB
