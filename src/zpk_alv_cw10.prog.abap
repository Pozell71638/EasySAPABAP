*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw10.
*TYPE-POOLS: slis.
*TYPES: BEGIN OF ts_ekpo,
*         ebeln TYPE ekpo-ebeln,
*         ebelp TYPE ekpo-ebelp,
*         matnr TYPE ekpo-matnr,
*         meins TYPE ekpo-meins,
*       END OF ts_ekpo.
*
*TYPES: BEGIN OF ts_ekko,
*         ebeln TYPE ekko-ebeln,
*         bukrs TYPE ekko-bukrs,
*         lifnr TYPE ekko-lifnr,
*       END OF ts_ekko.
*
*TYPES: BEGIN OF ty_final,
*         ebeln   TYPE ekpo-ebeln,
*         ebelp   TYPE ekpo-ebelp,
*         matnr   TYPE ekpo-matnr,
*         meins   TYPE ekpo-meins,
*         bukrs   TYPE ekko-bukrs,
*         lifnr   TYPE ekko-lifnr,
*         c_index TYPE sy-tabix,
*       END OF ty_final.
*
*DATA: it_ekpo  TYPE STANDARD TABLE OF ts_ekpo,
*      it_ekko  TYPE STANDARD TABLE OF ts_ekko,
*      it_final TYPE STANDARD TABLE OF ty_final,
*
*      wa_ekpo  TYPE ts_ekpo,
*      wa_ekko  TYPE ts_ekko,
*      wa_final TYPE ty_final.
*
*DATA: it_fcat TYPE slis_t_fieldcat_alv,
*      wa_fcat TYPE slis_fieldcat_alv.
*
*DATA:var TYPE ekko-ebeln.
*
*SELECT-OPTIONS: s_ebeln FOR var.
*
*SELECT   ebeln
*          bukrs
*          lifnr
*
*FROM ekko INTO TABLE it_ekko
*  WHERE ebeln IN s_ebeln.
*
*IF sy-subrc = 0.
*  SORT it_ekko BY ebeln.
*ELSE.
*  MESSAGE 'Data not found in table LIKP' TYPE 'I'.
*ENDIF.
*
*
*IF it_ekko IS NOT INITIAL.
*
*  SELECT  ebeln
*          ebelp
*          matnr
*          meins
*  FROM ekpo INTO TABLE it_ekpo    FOR ALL ENTRIES IN it_ekko    WHERE ebeln = it_ekko-ebeln.
*ENDIF.
*
*IF sy-subrc = 0.
*  SORT it_ekpo BY ebeln.
*ELSE.
*  MESSAGE 'Data not found in table LIPS' TYPE 'I'.
*ENDIF.
*
*LOOP AT it_ekpo INTO wa_ekpo.
*  wa_final-ebeln = wa_ekpo-ebeln.
*  wa_final-ebelp = wa_ekpo-ebelp.
*  wa_final-matnr = wa_ekpo-matnr.
*  wa_final-meins =  wa_ekpo-meins.
*  READ TABLE it_ekko INTO wa_ekko WITH KEY ebeln = wa_ekpo-ebeln BINARY SEARCH.
*
*  wa_final-bukrs = wa_ekko-bukrs.
*  wa_final-lifnr = wa_ekko-lifnr.
*
*
*
*  APPEND wa_final TO it_final.
*  CLEAR: wa_final, wa_ekko, wa_ekpo.
*ENDLOOP.
*
*CLEAR wa_final.
*LOOP AT it_final INTO wa_final.
*  wa_final-c_index = sy-tabix.
*  MODIFY it_final FROM wa_final INDEX sy-tabix TRANSPORTING c_index.
*ENDLOOP.
*
*
**------------------------------------------*
*wa_fcat-col_pos = 0.
*wa_fcat-fieldname = 'C_INDEX' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'SERIAL NO'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*wa_fcat-col_pos = 1.
*wa_fcat-fieldname = 'EBELN' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Purchasing Document Number'.
*wa_fcat-no_zero  = 'X'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*
*wa_fcat-col_pos = 2.
*wa_fcat-fieldname = 'EBELP' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Item Number of Purchasing Document'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*wa_fcat-col_pos = 3.
*wa_fcat-fieldname = 'MATNR' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Material Number'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*
*wa_fcat-col_pos = 4.
*wa_fcat-fieldname = 'MEINS' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Base Unit of Measure'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*wa_fcat-col_pos = 5.
*wa_fcat-fieldname = 'BUKRS' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Company Code'.
*
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*wa_fcat-col_pos = 6.
*wa_fcat-fieldname = 'LIFNR' .
*wa_fcat-tabname = 'IT_FINAL'.
*wa_fcat-seltext_m = 'Vendors account number'.
*APPEND wa_fcat TO it_fcat.
*CLEAR wa_fcat.
*
*
*data: wa_layout type slis_layout_alv.
*
*wa_layout-colwidth_optimize = 'X'.
*WA_LAYOUT-zebra             = 'X'.
*
*
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
* EXPORTING
**   I_INTERFACE_CHECK                 = ' '
**   I_BYPASSING_BUFFER                = ' '
**   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                 = SY-REPID
**   I_CALLBACK_PF_STATUS_SET          = ' '
**   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE             = 'TOP'
**   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
**   I_CALLBACK_HTML_END_OF_LIST       = ' '
**   I_STRUCTURE_NAME                  =
**   I_BACKGROUND_ID                   = ' '
**   I_GRID_TITLE                      =
**   I_GRID_SETTINGS                   =
*   IS_LAYOUT                          = WA_LAYOUT
*   IT_FIELDCAT                        = IT_FCAT
**   IT_EXCLUDING                      =
**   IT_SPECIAL_GROUPS                 =
**   IT_SORT                           =
**   IT_FILTER                         =
**   IS_SEL_HIDE                       =
**   I_DEFAULT                         = 'X'
**   I_SAVE                            = ' '
**   IS_VARIANT                        =
**   IT_EVENTS                         =
**   IT_EVENT_EXIT                     =
**   IS_PRINT                          =
**   IS_REPREP_ID                      =
**   I_SCREEN_START_COLUMN             = 0
**   I_SCREEN_START_LINE               = 0
**   I_SCREEN_END_COLUMN               = 0
**   I_SCREEN_END_LINE                 = 0
**   I_HTML_HEIGHT_TOP                 = 0
**   I_HTML_HEIGHT_END                 = 0
**   IT_ALV_GRAPHICS                   =
**   IT_HYPERLINK                      =
**   IT_ADD_FIELDCAT                   =
**   IT_EXCEPT_QINFO                   =
**   IR_SALV_FULLSCREEN_ADAPTER        =
**   O_PREVIOUS_SRAL_HANDLER           =
** IMPORTING
**   E_EXIT_CAUSED_BY_CALLER           =
**   ES_EXIT_CAUSED_BY_USER            =
*  TABLES
*    t_outtab                          = IT_final
** EXCEPTIONS
**   PROGRAM_ERROR                     = 1
**   OTHERS                            = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*FORM TOP.
*  DATA:HEADER TYPE SLIS_T_LISTHEADER,
*        WA    TYPE SLIS_LISTHEADER.
*
*  WA-typ = 'H'.
*  WA-info = 'ALV BASIC REPORT'.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
*  WA-typ = 'H'.
*  WA-info = 'REPORT PREPARED BY PINAR'.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
* WA-typ = 'A'.
*  WA-info = SY-uname.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
*  WA-typ = 'A'.
*  WRITE SY-UZEIT TO WA-INFO.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
*  WA-typ = 'S'.
**  WRITE SY-DATUM TO WA-INFO.
*  WA-INFO = SY-DATUM.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
*  WA-typ = 'S'.
*  WRITE SY-DATUM TO WA-INFO.
**  WA-INFO = SY-DATUM.
*  APPEND WA TO HEADER.
*  CLEAR WA.
*
*
*
*  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
*    EXPORTING
*      it_list_commentary       = HEADER
*     I_LOGO                   = 'ENJOYSAP_LOGO'
**     I_END_OF_LIST_GRID       =
**     I_ALV_FORM               =
*            .
*  ENDFORM.
***************************************************
TYPE-POOLS: slis.
*mara + makt
*mara - matnr, mtart, mbrsh,meins
*makt- matnr, spras, maktx
*joining field is matnr
*for all entries
TYPES: BEGIN OF ts_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         meins TYPE mara-meins,
       END OF ts_mara.

TYPES: BEGIN OF ts_makt,
         matnr TYPE makt-matnr,
         spras TYPE makt-spras,
         maktx TYPE makt-maktx,
       END OF ts_makt.
TYPES: BEGIN OF ty_final,
         matnr   TYPE mara-matnr,
         mtart   TYPE mara-mtart,
         mbrsh   TYPE mara-mbrsh,
         meins   TYPE mara-meins,

         spras   TYPE makt-spras,
         maktx   TYPE makt-maktx,
         c_index TYPE sy-tabix,
       END OF ty_final.

DATA: it_mara  TYPE STANDARD TABLE OF ts_mara,
      it_makt  TYPE STANDARD TABLE OF ts_makt,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_mara  TYPE ts_mara,
      wa_makt  TYPE ts_makt,
      wa_final TYPE ty_final.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat TYPE slis_fieldcat_alv.

DATA:var TYPE mara-matnr.

SELECT-OPTIONS: s_matnr FOR var.



SELECT   matnr
         mtart
         mbrsh
         meins
FROM mara INTO TABLE it_mara
  WHERE matnr IN s_matnr.

IF sy-subrc = 0.
  SORT it_mara BY matnr.
ELSE.
  MESSAGE 'Data not found in table LIKP' TYPE 'I'.
ENDIF.


IF it_mara IS NOT INITIAL.

  SELECT  matnr
          spras
          maktx

  FROM makt INTO TABLE it_makt    FOR ALL ENTRIES IN it_mara    WHERE matnr = it_mara-matnr.
ENDIF.

IF sy-subrc = 0.
  SORT it_makt BY matnr.
ELSE.
  MESSAGE 'Data not found in table LIPS' TYPE 'I'.
ENDIF.



LOOP AT it_mara INTO wa_mara.
  wa_final-matnr = wa_mara-matnr.
  wa_final-mtart = wa_mara-mtart.
  wa_final-mbrsh = wa_mara-mbrsh.
  wa_final-meins =  wa_mara-meins.

  READ TABLE it_makt INTO wa_makt WITH KEY matnr = wa_mara-matnr BINARY SEARCH.


  wa_final-spras = wa_makt-spras.
  wa_final-maktx = wa_makt-maktx.


  APPEND wa_final TO it_final.
  CLEAR: wa_final, wa_makt, wa_mara.
ENDLOOP.

CLEAR wa_final.
LOOP AT it_final INTO wa_final.
  wa_final-c_index = sy-tabix.
  MODIFY it_final FROM wa_final INDEX sy-tabix TRANSPORTING c_index.
ENDLOOP.


**------------------------------------------*
wa_fcat-col_pos = 0.
wa_fcat-fieldname = 'C_INDEX' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'SERIAL NO'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.
*
wa_fcat-col_pos = 2.
wa_fcat-fieldname = 'MTART' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Material type'.
wa_fcat-no_zero  = 'X'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.
*
*
wa_fcat-col_pos = 3.
wa_fcat-fieldname = 'MBRSH' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Item Number of Purchasing Document'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 1.
wa_fcat-fieldname = 'MATNR' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Material Number'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.


wa_fcat-col_pos = 4.
wa_fcat-fieldname = 'MEINS' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Base Unit of Measure'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.
*
wa_fcat-col_pos = 5.
wa_fcat-fieldname = 'SPRAS' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Language Key'.

APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 6.
wa_fcat-fieldname = 'MAKTX' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Material Description'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.


DATA: wa_layout TYPE slis_layout_alv.

wa_layout-colwidth_optimize = 'X'.
wa_layout-zebra             = 'X'.



CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK      = ' '
*   I_BYPASSING_BUFFER     = ' '
*   I_BUFFER_ACTIVE        = ' '
    i_callback_program     = sy-repid
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
    i_callback_top_of_page = 'TOP'
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME       =
*   I_BACKGROUND_ID        = ' '
*   I_GRID_TITLE           =
*   I_GRID_SETTINGS        =
    is_layout              = wa_layout
    it_fieldcat            = it_fcat
*   IT_EXCLUDING           =
*   IT_SPECIAL_GROUPS      =
*   IT_SORT                =
*   IT_FILTER              =
*   IS_SEL_HIDE            =
*   I_DEFAULT              = 'X'
*   I_SAVE                 = ' '
*   IS_VARIANT             =
*   IT_EVENTS              =
*   IT_EVENT_EXIT          =
*   IS_PRINT               =
*   IS_REPREP_ID           =
*   I_SCREEN_START_COLUMN  = 0
*   I_SCREEN_START_LINE    = 0
*   I_SCREEN_END_COLUMN    = 0
*   I_SCREEN_END_LINE      = 0
*   I_HTML_HEIGHT_TOP      = 0
*   I_HTML_HEIGHT_END      = 0
*   IT_ALV_GRAPHICS        =
*   IT_HYPERLINK           =
*   IT_ADD_FIELDCAT        =
*   IT_EXCEPT_QINFO        =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER =
  TABLES
    t_outtab               = IT_final
* EXCEPTIONS
*   PROGRAM_ERROR          = 1
*   OTHERS                 = 2
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

FORM top.
  DATA:header TYPE slis_t_listheader,
       wa     TYPE slis_listheader.

  wa-typ = 'H'.
  wa-info = 'ALV BASIC REPORT'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'H'.
  wa-info = 'REPORT PREPARED BY PINAR'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  wa-info = sy-uname.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  WRITE sy-uzeit TO wa-info.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'S'.
*  WRITE SY-DATUM TO WA-INFO.
  wa-info = sy-datum.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'S'.
  WRITE sy-datum TO wa-info.
*  WA-INFO = SY-DATUM.
  APPEND wa TO header.
  CLEAR wa.



  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = header
      i_logo             = 'ENJOYSAP_LOGO'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.
