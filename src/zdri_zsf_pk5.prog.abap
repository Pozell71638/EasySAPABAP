*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK5.

DATA: ITAB TYPE ZTT_KKNA1_PK1,
      WA TYPE ZSTR_KKNA1_PK1.

SELECT-OPTIONS: S_KUNNR FOR WA-KUNNR.

SELECT KUNNR LAND1 NAME1 ORT01 FROM KNA1
  INTO TABLE ITAB WHERE KUNNR IN S_KUNNR.


CALL FUNCTION '/1BCDWB/SF00000048'
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
    it_kna1                    = ITAB
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
