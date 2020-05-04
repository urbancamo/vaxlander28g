!
! Process keyboard input
!
!================================================

SUB GETKEY

%INCLUDE "CONSTANTS"
%INCLUDE "RECORDS"
%INCLUDE "GLOBALS"
%INCLUDE "EXT$INSTR"
%INCLUDE "EXT$KEYS"
%INCLUDE "EXT$PAUSE"

DECLARE STRING keystroke

WHEN ERROR IN
!LET keystroke = INKEY$(0%, WAIT GameState::ts * 0.1)
LET keystroke = INKEY$(0%)

IF keystroke=']' AND LanderState::br<100 
THEN 
    LET LanderState::br = LanderState::br + 10
END IF

IF keystroke='[' AND LanderState::br > 0 
THEN
    LET LanderState::br = LanderState::br - 10
END IF

IF keystroke='-' AND LanderState::la > -60
THEN 
    LET LanderState::la = LanderState::la - 5
END IF

IF keystroke='=' AND LanderState::la < 60 
THEN 
    LET LanderState::la = LanderState::la + 5
END IF

IF keystroke=';' AND LanderState::br >= 2 
THEN 
    LET LanderState::br = LanderState::br - 2
END IF

IF keystroke="'" AND LanderState::br <= 98 
THEN 
    LET LanderState::br = LanderState::br + 2
END IF

IF keystroke='V' OR keystroke='v' 
THEN 
    LET LanderState::la = 0
END IF

IF keystroke='C' OR keystroke='c' 
THEN 
    LET LanderState::la = -60
END IF 

IF keystroke='B' OR keystroke='b' 
THEN 
    LET LanderState::la = 60
END IF 

IF keystroke='1' 
THEN 
    LET LanderState::br = 20
END IF

IF keystroke='2' 
THEN 
    LET LanderState::br = 40
END IF

IF keystroke='3' 
THEN 
    LET LanderState::br = 60
END IF

IF keystroke='4' 
THEN 
    LET LanderState::br = 80
END IF

IF keystroke='5' 
THEN 
    LET LanderState::br = 100
END IF

IF keystroke='0' 
THEN 
    LET LanderState::br = 0
END IF

IF keystroke='R' OR keystroke='r' 
THEN 
    LET GameState::restart = True
END IF

IF keystroke='I' OR keystroke='i' 
THEN 
    CALL INSTR
END IF

IF keystroke='P' OR keystroke='p' 
THEN 
    CALL PAUSE
END IF

IF keystroke='K' OR keystroke='k' 
THEN 
    CALL KEYS
END IF

IF keystroke='Q' OR keystroke='q' 
THEN 
    GameState::quit = True
END IF

USE
! Ignore the error
END WHEN

END SUB
