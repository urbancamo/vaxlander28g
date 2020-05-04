!
!
!================================================
SUB TAPE(LONG col, LONG minVal, LONG tick)

%INCLUDE "EXT$PRINT_TAB"
%INCLUDE "EXT$PRINT_TABVW"
%INCLUDE "EXT$MINW0DP"

CALL MINW0DP
CALL PRINT_TABVW(COL, 0, "-", minVal, 2)
CALL PRINT_TAB(COL, 1, ".")
CALL PRINT_TABVW(COL, 2, "-", (minVal + tick), 2)
CALL PRINT_TAB(COL, 3, ".")
CALL PRINT_TABVW(COL, 4, "-", (minVal + ( tick * 2 )), 2)
CALL PRINT_TAB(COL, 5, ".")
CALL PRINT_TABVW(COL, 6, "-", (minVal + ( tick * 3 )), 2)

END SUB
