SUB DELAY

%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"

! TODO Get time from system for delay
LET T = TIME(0)
LET DT = T + (GameState::ts * 0.1)
WHILE T < DT
   LET T = TIME(0)
NEXT

! CALL PRINT_TAB(0,5, "T=" + T + "TS=" + GameState::ts)
END SUB
