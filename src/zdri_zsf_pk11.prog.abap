*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdri_zsf_pk11.

DATA: itab TYPE ztt_final_pk1,
      wa   TYPE zstr_final_pk1.


DATA: wa1 TYPE zstr_sf_spm6.

SELECT-OPTIONS s_vbeln FOR wa-vbeln.
*
*SELECT VBELN KUNNR FROM VBAK INTO TABLE ITAB
*  where vbeln in s_vbeln.


SELECT a~vbeln,
       a~kunnr,

      b~posnr,
      b~matnr,
      b~arktx

  INTO TABLE @itab
  FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
  WHERE a~vbeln IN @s_vbeln.

*IF sy-subrc = 0.
*  SORT itab BY vbeln.
*ELSE.
*  MESSAGE 'data not found' TYPE 'I'.
*ENDIF.
READ TABLE ITAB INTO WA INDEX 8.
SELECT SINGLE matnr mtart mbrsh meins
  from mara into wa1 where matnr = wa-matnr.



call function '/1BCDWB/SF00000069'
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
    wa_mara                    = wa1
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  TABLES
    it_final                   = itab
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
