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

        77 eof PIC X VALUE 'N'.
        77 chunk-size PIC 9(1) VALUE 3.
        77 ndata PIC 9(4) VALUE 2000.

        01 idx PIC 9(4) VALUE 1.
        01 c-idx PIC 9 VALUE 1.
        01 sub-idx PIC 9(4).
        01 last-sum PIC 9(5).
        01 cur-sum PIC 9(5).
        01 datum PIC 9(4).
        01 cnt PIC 9(4).

        01 input-data.
          02 input-datum PIC 9(4) OCCURS 1 TO 9999 TIMES
          DEPENDING ON ndata.
        PROCEDURE DIVISION.
           ACCEPT input-file-name FROM COMMAND-LINE.
           OPEN INPUT input-file.
           PERFORM UNTIL eof = 'Y'
               READ input-file
                  AT END MOVE 'Y' TO eof
                  NOT AT END MOVE file-datum TO datum
                  ADD cur-sum datum GIVING cur-sum
                  MOVE datum TO input-datum OF input-data (idx)
                  IF idx > chunk-size 
                     SUBTRACT chunk-size FROM idx GIVING sub-idx
                     SUBTRACT input-datum OF input-data (sub-idx) 
                     FROM cur-sum GIVING cur-sum
                     IF cur-sum > last-sum
                        ADD 1 TO cnt
                     END-IF
                     MOVE cur-sum TO last-sum
                  END-IF
                  ADD 1 TO idx
               END-READ
           END-PERFORM.
           CLOSE input-file.
           DISPLAY 'result: ' cnt
           STOP RUN.
