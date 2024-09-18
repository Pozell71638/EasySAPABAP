*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK14.

TYPES: BEGIN OF ts_vbak,
         vbeln TYPE vbak-vbeln,
         kunnr TYPE vbak-kunnr,
       END OF ts_vbak.


TYPES: BEGIN OF ts_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,

       END OF ts_vbap.


TYPES: BEGIN OF ts_kna1,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,

       END OF ts_kna1.



DATA: it_vbak  TYPE STANDARD TABLE OF ts_vbak,
      it_vbap  TYPE STANDARD TABLE OF ts_vbap,
      it_kna1  TYPE STANDARD TABLE OF ts_kna1,
      itab TYPE ztt_threetable_pk1,

      wa_vbak  TYPE ts_vbak,
      wa_vbap  TYPE ts_vbap,
      wa_kna1  TYPE ts_kna1,
      wa TYPE zstr_threetable_pk1,
      wa1 TYPE zstr_kna1_pk1.


DATA: FNAM TYPE RS38L_FNAM. "SSF_FUNCTION_MODULE_NAME'NE TIKLADIK ASSOCIATE TYPE (EXPORT DA) I KOPYALADIK BURADA KULLANDIK:


DATA:var TYPE vbak-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT vbeln kunnr
FROM vbak INTO TABLE it_vbak
  WHERE vbeln IN s_vbeln.

IF sy-subrc = 0.
  SORT it_vbak BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Mara' TYPE 'I'.
ENDIF.
************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT vbeln posnr matnr

  FROM vbap INTO TABLE it_vbap    FOR ALL ENTRIES IN it_vbak    WHERE vbeln = it_vbak-vbeln.
ENDIF.

IF sy-subrc = 0.
  SORT it_vbap BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Marc' TYPE 'I'.
ENDIF.

************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT kunnr  name1

    FROM kna1 INTO TABLE it_kna1  FOR ALL ENTRIES IN it_vbak   WHERE kunnr = it_vbak-kunnr.
ENDIF.
IF sy-subrc = 0.
  SORT it_kna1 BY kunnr.
ELSE.
  MESSAGE 'Data not found in table Mard' TYPE 'I'.
ENDIF.


LOOP AT it_vbap INTO wa_vbap.
  wa-vbeln = wa_vbap-vbeln.
  wa-posnr = wa_vbap-posnr.
  wa-matnr = wa_vbap-matnr.

  READ TABLE it_vbak INTO wa_vbak WITH KEY wa_vbap-vbeln BINARY SEARCH.


  wa-kunnr = wa_vbak-kunnr.
  READ TABLE it_kna1 INTO wa_kna1 WITH KEY wa_vbak-kunnr BINARY SEARCH.

  wa-name1 = wa_kna1-name1.



  APPEND wa TO itab.
  CLEAR: wa, wa_vbak, wa_vbap, wa_kna1.
ENDLOOP.



READ TABLE IT_kna1 INTO WA_kna1 INDEX 1.
SELECT SINGLE kunnr land1 name1 ort01
  from kna1 into wa1 where kunnr = wa-kunnr.


CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZSF_PK12'
*   VARIANT                  = ' '
*   DIRECT_CALL              = ' '
 IMPORTING
   FM_NAME                  = FNAM
* EXCEPTIONS
*   NO_FORM                  = 1
*   NO_FUNCTION_MODULE       = 2
*   OTHERS                   = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.





CALL FUNCTION  FNAM  "'/1BCDWB/SF00000070'
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
    wa_kna1                    = wa1
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  tables
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
