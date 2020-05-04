SUB PRINT_TABV(LONG col, LONG row, STRING strVal, LONG numVal)

LET rows$ = NUM1$(row+1)
LET cols$ = NUM1$(col+1)
LET vals$ = FORMAT$(numVal, "######")

LET out$ = ESC + "[" + rows$ + ";" + cols$ + "H" + strVal + vals$
PRINT out$

END SUB
