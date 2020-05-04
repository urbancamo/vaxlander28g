SUB PRINT_TAB(LONG col, LONG row, STRING strVal)

LET rows$ = NUM1$(row+1)
LET cols$ = NUM1$(col+1)

LET out$ = ESC + "[" + rows$ + ";" + cols$ + "H" + strVal
PRINT out$

END SUB
