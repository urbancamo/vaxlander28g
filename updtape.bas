!
!
!================================================
!
! Update a tape display
!
SUB UPDTAPE(LONG col, LONG curr, LONG prev) ! -- Update tape display

%INCLUDE "EXT$PRINT_TAB"

CALL PRINT_TAB(col, prev, " ") ! clear previous indicator position
IF curr < 0 
THEN 
   CALL PRINT_TAB(col, 0, "^")
END IF

IF curr > 6 
THEN 
    CALL PRINT_TAB(col, 6, "V")
END IF

IF curr >= 0 AND curr <= 6 
THEN 
    CALL PRINT_TAB(COL,CURR, ">")
END IF 

END SUB
