*&---------------------------------------------------------------------*

*& Report ZPK_ALV_CW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw.
TYPE-POOLS:slis.
************************************************************************
*                                                                      *
************************************************************************
TYPES: BEGIN OF ts_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
       END OF ts_vbap.

DATA:it_vbap TYPE STANDARD TABLE OF ts_vbap,
     wa_vbap TYPE ts_vbap.

DATA: var TYPE vbap-vbeln.

DATA:it_fcat TYPE  slis_t_fieldcat_alv,
     wa_fcat TYPE slis_fieldcat_alv.

SELECT-OPTIONS:s_vbeln FOR var.
SELECT vbeln
       posnr
       matnr
FROM vbap INTO TABLE it_vbap WHERE vbeln IN s_vbeln.

sort it_vbap by vbeln.

*--------------------------------------------------------------
wa_fcat-col_pos   = 1.
wa_fcat-fieldname = 'VBELN'.
wa_fcat-tabname   = 'IT_VBAP'.
wa_fcat-seltext_m = 'SALES DOCUMENT' .
WA_FCAT-no_zero    = 'X'.
append wa_fcat to it_fcat.
CLEAR WA_FCAT.

wa_fcat-col_pos   = 2.
wa_fcat-fieldname = 'POSNR'.
wa_fcat-tabname   = 'IT_VBAP'.
wa_fcat-seltext_m = 'Sales Document Item' .

append wa_fcat to it_fcat.
CLEAR WA_FCAT.

wa_fcat-col_pos   = 3.
wa_fcat-fieldname = 'MATNR'.
wa_fcat-tabname   = 'IT_VBAP'.
wa_fcat-seltext_m = 'MATERIAL NUMBER' .
WA_FCAT-no_zero    = 'X'.
append wa_fcat to it_fcat.
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
    t_outtab                          = IT_VBAP
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
