        IDENTIFICATION DIVISION.
        PROGRAM-ID. advent-of-code-day-1.
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
           SELECT input-file ASSIGN TO input-file-name
           ORGANIZATION IS LINE SEQUENTIAL.
        DATA DIVISION.
        FILE SECTION.
        fd input-file.
        01 file-data.
           05 file-datum PIC X(4).
        WORKING-STORAGE SECTION.
        01 input-file-name PIC X(25).

        77 eof PIC X(1) VALUE 'N'.
        77 i PIC 9(4) VALUE 1.
        77 i-in PIC 9(4) VALUE 1.
        77 i-chunk PIC 9(4).
        77 chunk-size PIC 9 VALUE 3.
        77 ndata PIC 9(4) VALUE 2000.

        01 w-in PIC 9(4).
        01 w-cur PIC 9(5).
        01 w-last PIC 9(5).
        01 w-count PIC 9(4) VALUE 0.
        01 w-sum PIC 9(5).
        01 w-i-offset PIC 9(4).
        01 w-i-max-offset PIC 9(4).

        77 temp PIC 9(4) VALUE 1.

        01 input-data.
           02 input-datum PIC 9(4) OCCURS 1 TO 9999 TIMES 
           DEPENDING ON ndata.
        01 squish-data.
           02 squish-datum PIC 9(5) OCCURS 1 TO 9999 TIMES 
           DEPENDING ON ndata.
        PROCEDURE DIVISION.
           ACCEPT input-file-name FROM COMMAND-LINE.

           OPEN INPUT input-file.
           PERFORM data-load.
           PERFORM data-squish.
           PERFORM data-process.
           CLOSE input-file.
           DISPLAY 'result: ' w-count
           STOP RUN.

       data-load.
           PERFORM UNTIL eof = 'Y'
               READ input-file
                  AT END MOVE 'Y' TO eof
                  NOT AT END MOVE file-datum TO w-in
                  MOVE w-in TO input-datum OF input-data(i-in)
                  ADD 1 TO i-in
               END-READ
           END-PERFORM.

       data-squish.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > ndata
              MOVE 0 TO w-sum
              ADD i chunk-size GIVING w-i-max-offset
              IF w-i-max-offset <= ndata
                 PERFORM VARYING i-chunk FROM 1 BY 1
                 UNTIL i-chunk > chunk-size
                    ADD i i-chunk GIVING w-i-offset
                    ADD w-sum input-datum OF input-data(w-i-offset) 
                    GIVING w-sum
                 END-PERFORM
              END-IF
              MOVE w-sum TO squish-datum OF squish-data(i)
           END-PERFORM.

       data-process.
           MOVE 0 TO w-count
           PERFORM VARYING i FROM 0 BY 1 UNTIL i > ndata
              MOVE squish-datum OF squish-data(i) TO w-cur
              IF i NOT = 0 AND w-cur > w-last
                 ADD 1 TO w-count
              END-IF
              MOVE w-cur TO w-last
           END-PERFORM.
