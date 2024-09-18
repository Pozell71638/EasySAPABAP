*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW2
*&---------------------------------------------------------------------*
*&KNA1: KUNNR, LAND1, NAME1, ORT01
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW2.

TYPE-POOLS: SLIS.

TYPES: BEGIN OF ty_kna1,
        kunnr TYPE kna1-kunnr,
        land1 TYPE kna1-land1,
        name1 TYPE kna1-name1,
        ort01 TYPE kna1-ort01,
        c_index TYPE sy-tabix,
      END OF ty_kna1.



DATA: IT_KNA1 TYPE STANDARD TABLE OF TY_KNA1,
      WA_KNA1 TYPE TY_KNA1.

DATA: IT_FCAT TYPE slis_t_fieldcat_alv ,
      WA_FCAT type slis_fieldcat_alv.

DATA: VAR TYPE KNA1-KUNNR.

SELECT-OPTIONS: S_KUNNR FOR VAR.

SELECT kunnr
       land1
       name1
       ort01
 FROM KNA1 INTO TABLE IT_KNA1
  WHERE KUNNR IN S_KUNNR.

IF SY-SUBRC = 0.
  SORT  IT_KNA1 BY KUNNR.
  ELSE .
    MESSAGE 'DATA NOT FOUND' TYPE 'I'.

  ENDIF.

clear wa_kna1.
LOOP AT it_kna1 into wa_kna1.
wa_kna1-c_index = sy-tabix.
modify it_kna1 from wa_kna1 index sy-tabix TRANSPORTING c_index.
ENDLOOP.
*  LOOP AT IT_MARA INTO WA_MARA .
*WRITE:/ WA_MARA-MATNR,
*        WA_MARA-MTART,
*        WA_MARA-MBRSH.
*  ENDLOOP.


*------------------------------------------*
WA_FCAT-COL_POS = 0.
WA_FCAT-fieldname = 'C_INDEX' .
WA_FCAT-tabname = 'IT_KNA1'.
WA_FCAT-seltext_m = 'SERIAL NO'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

*------------------------------------------*
WA_FCAT-COL_POS = 1.
WA_FCAT-fieldname = 'KUNNR' .
WA_FCAT-tabname = 'IT_KNA1'.
WA_FCAT-seltext_m = 'CUSTOMER NUMBER'.
WA_FCAT-no_zero  = 'X'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 2.
WA_FCAT-fieldname = 'LAND1' .
WA_FCAT-tabname = 'IT_KNA1'.
WA_FCAT-seltext_m = 'COUNTRY/RELIGION KEY'.

APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-COL_POS = 3.
WA_FCAT-fieldname = 'NAME1' .
WA_FCAT-tabname = 'IT_KNA1'.
WA_FCAT-seltext_m = 'NAME1'.

WA_FCAT-COL_POS = 4.
WA_FCAT-fieldname = 'ORT1' .
WA_FCAT-tabname = 'IT_KNA1'.
WA_FCAT-seltext_m = 'CITY'.

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
    t_outtab                          = IT_KNA1
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
