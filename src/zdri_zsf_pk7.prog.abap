*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK7.

DATA: ITAB  TYPE ZTT_FINAL_PK1,
       WA TYPE ZSTR_FINAL_PK1.

SELECT-OPTIONS S_VBELN FOR WA-VBELN.
*
*SELECT VBELN KUNNR FROM VBAK INTO TABLE ITAB
*  where vbeln in s_vbeln.


SELECT a~vbeln,
       a~kunnr,

      b~posnr,
      b~matnr,
      b~arktx

  INTO TABLE @ITAB
  FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
  WHERE a~vbeln IN @s_vbeln.

*IF sy-subrc = 0.
*  SORT itab BY vbeln.
*ELSE.
*  MESSAGE 'data not found' TYPE 'I'.
*ENDIF.





CALL FUNCTION '/1BCDWB/SF00000055'
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
    it_final                   = ITAB
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
