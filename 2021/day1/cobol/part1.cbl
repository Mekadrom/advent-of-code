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
        77 idx PIC 9(4) VALUE 1.

        01 w-cur PIC 9(4).
        01 w-last PIC 9(4).
        01 w-count PIC 9(4) VALUE 0.
        PROCEDURE DIVISION.
           ACCEPT input-file-name FROM COMMAND-LINE.

           OPEN INPUT input-file.
           PERFORM UNTIL eof = 'Y'
               READ input-file
                  AT END MOVE 'Y' TO eof
                  NOT AT END MOVE file-datum TO w-cur
                  IF idx NOT = 1 AND w-cur > w-last
                     ADD 1 TO w-count
                  END-IF
                  MOVE w-cur TO w-last
                  ADD 1 TO idx
               END-READ
           END-PERFORM
           CLOSE input-file.
           DISPLAY 'result: ' w-count
           STOP RUN.
