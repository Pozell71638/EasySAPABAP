*&---------------------------------------------------------------------*
*& Report ZPK_ALV_FAE_CW22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_FAE_CW22.
TYPES: BEGIN OF ts_vbak,
         vbeln TYPE vbak-vbeln,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         kunnr TYPE vbak-kunnr,
       END OF ts_vbak.


TYPES: BEGIN OF ts_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ts_vbap.


TYPES: BEGIN OF ts_kna1,
         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,
       END OF ts_kna1.

TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         kunnr TYPE vbak-kunnr,

         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,

         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,
       END OF ty_final.

DATA: it_vbak  TYPE STANDARD TABLE OF ts_vbak,
      it_vbap  TYPE STANDARD TABLE OF ts_vbap,
      it_kna1  TYPE STANDARD TABLE OF ts_kna1,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_vbak  TYPE ts_vbak,
      wa_vbap  TYPE ts_vbap,
      wa_kna1  TYPE ts_kna1,
      wa_final TYPE ty_final.



DATA:var TYPE vbak-vbeln.
DATA: IT_FCAT TYPE slis_t_fieldcat_alv ,
      WA_FCAT type slis_fieldcat_alv.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT vbeln vkorg vtweg spart kunnr
FROM vbak INTO TABLE it_vbak
  WHERE vbeln IN s_vbeln.

IF sy-subrc = 0.
  SORT it_vbak BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Vbak' TYPE 'I'.
ENDIF.
************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT vbeln posnr matnr arktx

  FROM vbap INTO TABLE it_vbap    FOR ALL ENTRIES IN it_vbak    WHERE vbeln = it_vbak-vbeln.
ENDIF.

IF sy-subrc = 0.
  SORT it_vbap BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Vbap' TYPE 'I'.
ENDIF.

************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT kunnr land1 name1 ort01

    FROM kna1 INTO TABLE it_kna1  FOR ALL ENTRIES IN it_vbak   WHERE kunnr = it_vbak-kunnr.
ENDIF.
IF sy-subrc = 0.
  SORT it_kna1 BY kunnr.
ELSE.
  MESSAGE 'Data not found in table Kna1' TYPE 'I'.
ENDIF.



LOOP AT it_vbap INTO wa_vbap.
  wa_final-vbeln = wa_vbap-vbeln.
  wa_final-posnr = wa_vbap-posnr.
  wa_final-matnr = wa_vbap-matnr.
  wa_final-arktx  = wa_vbap-arktx.
  READ TABLE it_vbak INTO wa_vbak WITH KEY vbeln = wa_vbap-vbeln BINARY SEARCH.

  wa_final-vkorg = wa_vbak-vkorg.
  wa_final-vtweg = wa_vbak-vtweg.
  wa_final-spart = wa_vbak-spart.
  wa_final-kunnr = wa_vbak-kunnr.
  READ TABLE it_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr BINARY SEARCH.

  wa_final-land1 = wa_kna1-land1.
  wa_final-name1 = wa_kna1-name1.
  wa_final-ort01 = wa_kna1-ort01.


  APPEND wa_final TO it_final.
  CLEAR: wa_final, wa_vbak, wa_vbap, wa_kna1.
ENDLOOP.


*LOOP AT it_final INTO wa_final.
*  WRITE:/ wa_final-vbeln COLOR 1,
*          wa_final-posnr COLOR 2,
*          wa_final-matnr COLOR 3,
*          wa_final-vtweg COLOR 4,
*          wa_final-kunnr COLOR 5,
*          wa_final-land1 COLOR 6,
*          wa_final-name1 COLOR 7,
*          wa_final-ort01 COLOR 1.
*ENDLOOP.

WA_FCAT-COL_POS = 1.
WA_FCAT-fieldname = 'VBELN' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Sales Document'.
WA_FCAT-no_zero  = 'X'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 2.
WA_FCAT-fieldname = 'POSNR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Sales Document Item'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 3.
WA_FCAT-fieldname = 'MATNR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Material Number'.

WA_FCAT-COL_POS = 4.
WA_FCAT-fieldname = 'VTWEG' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Distribution Channel'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 5.
WA_FCAT-fieldname = 'KUNNR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Customer Number'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 6.
WA_FCAT-fieldname = 'LAND1' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Country/Region Key'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 7.
WA_FCAT-fieldname = 'NAME1' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Name1'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 8.
WA_FCAT-fieldname = 'ORT1' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'City'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.




CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = SY-REPID
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
*   IS_LAYOUT                         =
   IT_FIELDCAT                        = IT_FCAT
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = IT_FINAL
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
