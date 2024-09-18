*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw8.
*vbak- vbeln, ernam, vkorg,vtweg, kunnr
*kna1- kunnr,land1,name1
*Inner Join

**************************************************

TYPE-POOLS: slis.


TYPES: BEGIN OF ts_vbak,
         vbeln TYPE vbak-vbeln,
         ernam TYPE vbak-ernam,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         kunnr TYPE vbak-kunnr,
       END OF ts_vbak.



TYPES: BEGIN OF ts_kna1,
         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
       END OF ts_kna1.

TYPES: BEGIN OF ty_final,
         vbeln   TYPE vbak-vbeln,
         ernam   TYPE vbak-ernam,
         vkorg   TYPE vbak-vkorg,
         vtweg   TYPE vbak-vtweg,
         kunnr   TYPE vbak-kunnr,
         land1   TYPE kna1-land1,
         name1   TYPE kna1-name1,
         c_index TYPE sy-tabix,
       END OF ty_final.

DATA: it_vbak  TYPE STANDARD TABLE OF ts_vbak,
      it_kna1  TYPE STANDARD TABLE OF ts_kna1,

      it_final TYPE STANDARD TABLE OF ty_final,

      wa_vbak  TYPE ts_vbak,
      wa_kna1  TYPE ts_kna1,

      wa_final TYPE ty_final.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat TYPE slis_fieldcat_alv.

DATA:var TYPE vbak-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT
      k~vbeln
      k~ernam
      k~vkorg
      k~vtweg
      k~kunnr
      p~land1
     p~name1

  INTO TABLE it_final
  FROM vbak AS k INNER JOIN kna1 AS p ON k~kunnr = p~kunnr

  WHERE k~vbeln IN s_vbeln.

IF  sy-subrc = 0.
  SORT it_final BY kunnr.
ELSE.
  MESSAGE 'Data not found' TYPE 'I'.
ENDIF.

CLEAR wa_final.
LOOP AT it_final INTO wa_final.
  wa_final-c_index = sy-tabix.
  MODIFY it_final FROM wa_final INDEX sy-tabix TRANSPORTING c_index.
ENDLOOP.

*---------------------------------------------

DATA: WA_LAYOUT TYPE SLIS_LAYOUT_ALV.
WA_LAYOUT-colwidth_optimize = 'X'.
WA_LAYOUT-zebra             = 'X'.


*------------------------------------------*
wa_fcat-col_pos = 0.
wa_fcat-fieldname = 'C_INDEX' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'SERIAL NO'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

*------------------------------------------*
wa_fcat-col_pos = 1.
wa_fcat-fieldname = 'VBELN' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Sales Document'.
wa_fcat-no_zero  = 'X'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.


wa_fcat-col_pos = 4.
wa_fcat-fieldname = 'VTWERG' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Distribution Channel'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 5.
wa_fcat-fieldname = 'KUNNR' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Sold-to Party'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.



wa_fcat-col_pos = 2.
wa_fcat-fieldname = 'ERNAM' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Name of Person Responsible for Creating the Object'.

APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 3.
wa_fcat-fieldname = 'VKORG' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Sales Organization'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.



wa_fcat-col_pos = 6.
wa_fcat-fieldname = 'LAND1' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Country/Region Key'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.


wa_fcat-col_pos = 7.
wa_fcat-fieldname = 'NAME1' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Name1'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.



CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK  = ' '
*   I_BYPASSING_BUFFER = ' '
*   I_BUFFER_ACTIVE    = ' '
    i_callback_program = sy-repid
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
   I_CALLBACK_TOP_OF_PAGE            = 'TOP'
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME   =
*   I_BACKGROUND_ID    = ' '
*   I_GRID_TITLE       =
*   I_GRID_SETTINGS    =
   IS_LAYOUT          = WA_LAYOUT
    it_fieldcat        = it_fcat
*   IT_EXCLUDING       =
*   IT_SPECIAL_GROUPS  =
*   IT_SORT            =
*   IT_FILTER          =
*   IS_SEL_HIDE        =
*   I_DEFAULT          = 'X'
*   I_SAVE             = ' '
*   IS_VARIANT         =
*   IT_EVENTS          =
*   IT_EVENT_EXIT      =
*   IS_PRINT           =
*   IS_REPREP_ID       =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE  = 0
*   I_HTML_HEIGHT_TOP  = 0
*   I_HTML_HEIGHT_END  = 0
*   IT_ALV_GRAPHICS    =
*   IT_HYPERLINK       =
*   IT_ADD_FIELDCAT    =
*   IT_EXCEPT_QINFO    =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab           = it_final
* EXCEPTIONS
*   PROGRAM_ERROR      = 1
*   OTHERS             = 2
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

FORM TOP.
DATA: HEADER TYPE SLIS_T_LISTHEADER,
      WA     TYPE SLIS_LISTHEADER.

WA-typ = 'H'.
WA-INFO = 'Basic Material Report'.
APPEND WA TO HEADER.
CLEAR WA.

WA-typ = 'S'.
write sy-datum to WA-INFO.
APPEND WA TO HEADER.
CLEAR WA.

WA-typ = 'A'.
WA-INFO = sy-uname.
APPEND WA TO HEADER.
CLEAR WA.

CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
  EXPORTING
    it_list_commentary       = header
   I_LOGO                   = 'ENJOYSAP_LOGO'
*   I_END_OF_LIST_GRID       =
*   I_ALV_FORM               =
          .

  ENDFORM.
