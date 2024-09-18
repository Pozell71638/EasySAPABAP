*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK14_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK14_1.

tables:zpk_library_t1.
DATA: ITAB TYPE ZTT_LIBRARY,
      WA TYPE ZSTR_LIBRARY.


SELECT  * FROM ZPK_LIBRARY_T1
  INTO TABLE itab WHERE library_ID = zpk_library_t1-library_id.



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
