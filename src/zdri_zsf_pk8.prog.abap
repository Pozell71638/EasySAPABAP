*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK8.
DATA: ITAB TYPE ZTT_SCUSTOM_PK1,
      WA TYPE ZSTR_SCUSTOM_PK1.

SELECT-OPTIONS: S_ID FOR WA-ID.

SELECT ID NAME CITY COUNTRY FROM SCUSTOM
  INTO TABLE ITAB WHERE ID IN S_ID.
  CALL FUNCTION '/1BCDWB/SF00000061'
*   EXPORTING
*     ARCHIVE_INDEX              =
*     ARCHIVE_INDEX_TAB          =
*     ARCHIVE_PARAMETERS         =
*     CONTROL_PARAMETERS         =
*     MAIL_APPL_OBJ              =
*     MAIL_RECIPIENT             =
*     MAIL_SENDER                =
*     OUTPUT_OPTIONS             =
*     USER_SETTINGS              = 'X'
*   IMPORTING
*     DOCUMENT_OUTPUT_INFO       =
*     JOB_OUTPUT_INFO            =
*     JOB_OUTPUT_OPTIONS         =
    TABLES
      it_scustom                 = itab
*   EXCEPTIONS
*     FORMATTING_ERROR           = 1
*     INTERNAL_ERROR             = 2
*     SEND_ERROR                 = 3
*     USER_CANCELED              = 4
*     OTHERS                     = 5
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
