*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK23I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2030  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2030 INPUT.




CASE sy-ucomm.
    WHEN 'PRINT1'.

      SELECT * FROM ZPK_LIBRARY_T1
  INTO TABLE ITAB WHERE library_ID = zpk_library_t1-library_id.
     IF sy-subrc = 0.
        MESSAGE 'Admin Login Successful' TYPE 'I'.


 CALL FUNCTION '/1BCDWB/SF00000076'
*  EXPORTING
*    ARCHIVE_INDEX              =
*    ARCHIVE_INDEX_TAB          =
*    ARCHIVE_PARAMETERS         =
*    CONTROL_PARAMETERS         =
*    MAIL_APPL_OBJ              =
*    MAIL_RECIPIENT             =
*    MAIL_SENDER                =
*    OUTPUT_OPTIONS             =
*    USER_SETTINGS              = 'X'
*  IMPORTING
*    DOCUMENT_OUTPUT_INFO       =
*    JOB_OUTPUT_INFO            =
*    JOB_OUTPUT_OPTIONS         =
   TABLES
     it_library                 = itab
*  EXCEPTIONS
*    FORMATTING_ERROR           = 1
*    INTERNAL_ERROR             = 2
*    SEND_ERROR                 = 3
*    USER_CANCELED              = 4
*    OTHERS                     = 5
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.



      ELSE.
        MESSAGE ' Please check your details' TYPE 'I'.
      ENDIF.
    WHEN 'DISPLAY1'.
      SELECT SINGLE library_id library_name reader_id reader_name  book_name  date_of_issue date_of_return late_fine CONT_NO_OF_THE_READER
         FROM zpk_library_t1
        INTO (zpk_library_t1-library_id, zpk_library_t1-library_name, zpk_library_t1-reader_id, zpk_library_t1-reader_name,
  zpk_library_t1-book_name, zpk_library_t1-date_of_issue, zpk_library_t1-date_of_return, zpk_library_t1-late_fine, zpk_library_t1-CONT_NO_OF_THE_READER)
      WHERE  library_id = zpk_library_t1-library_id.
    WHEN'CLEAR1'.
      CLEAR:zpk_library_t1-library_id, zpk_library_t1-library_name, zpk_library_t1-reader_id, zpk_library_t1-reader_name,
  zpk_library_t1-book_name, zpk_library_t1-date_of_issue, zpk_library_t1-date_of_return, zpk_library_t1-late_fine, zpk_library_t1-CONT_NO_OF_THE_READER.
    WHEN 'EXIT1'.
      LEAVE PROGRAM.
    WHEN 'CREATE1'.
      PERFORM save.
    WHEN 'EDIT1'.
      perform change.
    WHEN 'BACK1'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
