PROGRAM Draw_pie_chart

    OPTION TYPE = EXPLICIT, CONSTANT TYPE = INTEGER
    DECLARE LONG CONSTANT max_num_points = 100
    EXTERNAL SUB PIE (LONG, SINGLE DIM(), STRING DIM (), STRING DIM ())
    DECLARE SINGLE array (1 TO max_num_points), &
	    STRING labels (1 TO max_num_points)
    DECLARE LONG point_count, more_points
    DECLARE STRING title(1 TO 2)

    RANDOMIZE
    SET NO PROMPT

    point_count = 1
    more_points = -1

    INPUT "TITLE OF GRAPH (first line)> ";title(1)
    INPUT "TITLE OF GRAPH (second line)> ";title(2)

    WHILE more_points
	WHEN ERROR IN

	    INPUT "VALUE, LABEL> ";array(point_count),labels(point_count)

	    IF array(point_count) <> 0
	    THEN
		point_count = point_count + 1
	    END IF
	USE
	    IF point_count > MAX_NUM_POINTS
	    THEN
		PRINT 'MAX NUMBER OF POINTS EXCEEDED'
	    ELSE
		IF ERR <> 11
		THEN
		    PRINT 'INVALID INPUT, TRY AGAIN'
		    RETRY
		END IF
	    END IF

	    more_points = 0
	    point_count = point_count - 1

	END WHEN
    NEXT
	
    CALL pie (point_count, array(), labels(), TITLE())
    SLEEP 5%

END PROGRAM
