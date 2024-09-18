*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK6.
DATA: ITAB TYPE ZTT_VBAK_PK1,
      WA TYPE ZSTR_VBAK_PK1.

SELECT-OPTIONS: S_VBELN FOR WA-VBELN.

SELECT VBELN KUNNR FROM VBAK
  INTO TABLE ITAB WHERE VBELN IN S_VBELN.


CALL FUNCTION '/1BCDWB/SF00000053'
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
    it_vbak                    = itab
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
