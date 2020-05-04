SUB PRINT_TABVW(LONG col, LONG row, STRING strVal, LONG numVal, LONG valWidth)

LET rows$ = NUM1$(row+1)
LET cols$ = NUM1$(col+1)
LET fmts$ = STRING$(valWidth, 35%)
LET vals$ = FORMAT$(numVal, fmts$)

LET out$ = ESC + "[" + rows$ + ";" + cols$ + "H" + strVal + vals$
PRINT out$

END SUB
