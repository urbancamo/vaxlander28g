!
!
!================================================
SUB INSTR

%INCLUDE "EXT$CLS"
%INCLUDE "EXT$MORE"

CALL CLS

PRINT "Whilst listing pressing Q will QUIT, any other key to scroll"
PRINT "Press any key to display instructions"

LET T$=INKEY$(0%, WAIT)
CALL CLS
CALL MORE("[]README.TXT")

END SUB
