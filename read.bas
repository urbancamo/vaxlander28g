!
!
!================================================
SUB READ(I%)

LET T$=""
DECLARE STRING inLine
LET LC% = 0

! TODO Check for EOF somehow
WHEN ERROR IN
UNTIL T$="Q" OR T$="q"

    INPUT LINE #1, inLine
    PRINT inLine

    LET LC% = LC% + 1
    IF MOD(LC%, 24) = 0 
    THEN 
        LET T$ = INKEY$(0%, WAIT)
    END IF
NEXT
USE
  IF ERR = 11%
  THEN
	PRINT "EOF..."
  ELSE
	EXIT HANDLER
  END IF
END WHEN

LET T$=INKEY$(0%, WAIT)

END SUB
