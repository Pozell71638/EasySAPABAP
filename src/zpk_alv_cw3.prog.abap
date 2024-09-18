*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw3.

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         netwr TYPE vbak-netwr,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ty_vbap.


TYPES: BEGIN OF ty_final,

         vbeln TYPE vbak-vbeln,
         netwr TYPE vbak-netwr,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
         c_index TYPE sy-tabix,
       END OF ty_final.


DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.
DATA: IT_FCAT TYPE slis_t_fieldcat_alv ,
      WA_FCAT type slis_fieldcat_alv.

DATA: var TYPE vbak-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.



DATA: it_vbak TYPE STANDARD TABLE OF ty_vbak,
      it_vbap TYPE STANDARD TABLE OF ty_vbap.

SELECT a~vbeln,
       a~netwr,
       a~vkorg,
       a~vtweg,
       a~spart,
       b~posnr,
       b~matnr,
       b~arktx
  INTO TABLE @it_final
  FROM vbak AS a INNER JOIN vbap AS b ON a~vbeln = b~vbeln
  WHERE a~vbeln IN @s_vbeln.

  IF  sy-subrc = 0.
  SORT it_final BY vbeln.
ELSE.
  MESSAGE 'Data not found' TYPE 'I'.
ENDIF.

clear wa_final.
LOOP AT it_final into wa_final.
wa_final-c_index = sy-tabix.
modify it_final from wa_final index sy-tabix TRANSPORTING c_index.
ENDLOOP.
*  LOOP AT IT_MARA INTO WA_MARA .
*WRITE:/ WA_MARA-MATNR,
*        WA_MARA-MTART,
*        WA_MARA-MBRSH.
*  ENDLOOP.


*------------------------------------------*
WA_FCAT-COL_POS = 0.
WA_FCAT-fieldname = 'C_INDEX' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'SERIAL NO'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

*------------------------------------------*
WA_FCAT-COL_POS = 1.
WA_FCAT-fieldname = 'VBELN' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Sales Document'.
WA_FCAT-no_zero  = 'X'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 2.
WA_FCAT-fieldname = 'NETWR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Net Value of the Sales Order in Document Currency'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 3.
WA_FCAT-fieldname = 'VKORG' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Sales Organization'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.
WA_FCAT-COL_POS = 4.
WA_FCAT-fieldname = 'VTWERG' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Distribution Channel'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.
WA_FCAT-COL_POS = 5.
WA_FCAT-fieldname = 'SPART' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Division'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.
WA_FCAT-COL_POS = 6.
WA_FCAT-fieldname = 'POSNR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Sales Document Item'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.
WA_FCAT-COL_POS = 7.
WA_FCAT-fieldname = 'MATNR' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Material Number'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 8.
WA_FCAT-fieldname = 'ARKTX' .
WA_FCAT-tabname = 'IT_FINAL'.
WA_FCAT-seltext_m = 'Short text for sales order item'.

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
