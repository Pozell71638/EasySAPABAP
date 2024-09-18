*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK13.

tables:zpk_admin_t.
DATA: wa TYPE zstr_admin,
      ITAB TYPE ztt_admin.

SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
          FROM zpk_admin_t
          INTO wa   WHERE  teacher_id = zpk_admin_t-teacher_id AND
                teacher_name = zpk_admin_t-teacher_name.




CALL FUNCTION '/1BCDWB/SF00000073'
* EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  TABLES
    it_admin                   = itab
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
