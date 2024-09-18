*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK10.



DATA: WA TYPE ZSTR_FINAL_PK1,
      ITAB  TYPE ZTT_FINAL_PK1.

PARAMETERS:P_VBELN TYPE ZSTR_FINAL_PK1-VBELN.


SELECT a~vbeln,
       a~kunnr,

      b~posnr,
      b~matnr,
      b~arktx

  INTO TABLE @ITAB
  FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
  WHERE a~vbeln = @P_vbeln.

CALL FUNCTION '/1BCDWB/SF00000068'
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    wa_final                   = wa
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
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
