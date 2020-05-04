!
!
!================================================
SUB MORE(F$)

%INCLUDE "EXT$READ"
%INCLUDE "EXT$CLS"

WHEN ERROR IN
OPEN F$ FOR INPUT AS FILE #1%
CALL READ(1) 
USE
    PRINT "Cannot open/read: "; F$; " any key..."
    LET T$ = INKEY$(0%, WAIT)
END WHEN
CLOSE #1

CALL CLS

END SUB
