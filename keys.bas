!
!
!================================================
! Give instructions on pilot controls
SUB KEYS

%INCLUDE "EXT$CLS"

CALL CLS

PRINT "Keys:"
PRINT "Thrust: 1:20%, 2:40%, 3:60%, 4:80%, 5:100%, 0:Engine Cut"
PRINT "        [:-10%, ]:+10%, ;:-2%, ':+2%"
PRINT "Attitude: C:-60 degrees, V:vertical, B:+60 degrees"
PRINT "          -:-5 degrees, +:+5 degrees"
PRINT "Simulation: P:Pause, R:Restart, I:Instructions, K:Keys"

LET T$ = INKEY$(0%, WAIT)
CALL CLS

END SUB

