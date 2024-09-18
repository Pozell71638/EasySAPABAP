*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW17
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW17.

TYPES: BEGIN OF tY_kna1,
              kunnr TYPE kna1-kunnr,
              land1 TYPE kna1-land1,
              name1 TYPE kna1-name1,
              ort01 TYPE kna1-ort01,
            END OF tY_kna1.

DATA: IT_KNA1 TYPE STANDARD TABLE OF TY_KNA1,
      WA_KNA1 TYPE TY_KNA1,

      IT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
      WA_FCAT type slis_fieldcat_alv,

      VAR TYPE KNA1-KUNNR.

SELECT-OPTIONS: S_KUNNR FOR VAR.

SELECT kunnr
       land1
       name1
       ort01
  FROM KNA1 INTO TABLE IT_KNA1
  WHERE KUNNR IN S_KUNNR.

   IF sy-subrc = 0.
    sort it_kna1 by kunnr.
    else.
      MESSAGE: 'Data not found in table KNA1' TYPE 'I'.
  ENDIF.

    WA_FCAT-COL_POS = 1.
    WA_FCAT-FIELDNAME = 'KUNNR'.
    WA_FCAT-TABNAME = 'IT_KNA1'.
    WA_FCAT-SELTEXT_M = 'Customer Number'.
    WA_FCAT-KEY = 'X'.
    WA_FCAT-HOTSPOT = 'X'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

    WA_FCAT-COL_POS = 2.
    WA_FCAT-FIELDNAME = 'LAND1'.
    WA_FCAT-TABNAME = 'IT_KNA1'.
    WA_FCAT-SELTEXT_M = 'Country'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

     WA_FCAT-COL_POS = 3.
    WA_FCAT-FIELDNAME = 'NAME1'.
    WA_FCAT-TABNAME = 'IT_KNA1'.
    WA_FCAT-SELTEXT_M = 'Customer Name'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

     WA_FCAT-COL_POS = 4.
    WA_FCAT-FIELDNAME = 'ORT01'.
    WA_FCAT-TABNAME = 'IT_KNA1'.
    WA_FCAT-SELTEXT_M = 'City'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
     EXPORTING
*       I_INTERFACE_CHECK                 = ' '
*       I_BYPASSING_BUFFER                = ' '
*       I_BUFFER_ACTIVE                   = ' '
       I_CALLBACK_PROGRAM                = SY-REPID
*       I_CALLBACK_PF_STATUS_SET          = ' '
       I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
*       I_CALLBACK_TOP_OF_PAGE            = ' '
*       I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*       I_CALLBACK_HTML_END_OF_LIST       = ' '
*       I_STRUCTURE_NAME                  =
*       I_BACKGROUND_ID                   = ' '
*       I_GRID_TITLE                      =
*       I_GRID_SETTINGS                   =
*       IS_LAYOUT                         =
       IT_FIELDCAT                       = IT_FCAT
*       IT_EXCLUDING                      =
*       IT_SPECIAL_GROUPS                 =
*       IT_SORT                           =
*       IT_FILTER                         =
*       IS_SEL_HIDE                       =
*       I_DEFAULT                         = 'X'
*       I_SAVE                            = ' '
*       IS_VARIANT                        =
*       IT_EVENTS                         =
*       IT_EVENT_EXIT                     =
*       IS_PRINT                          =
*       IS_REPREP_ID                      =
*       I_SCREEN_START_COLUMN             = 0
*       I_SCREEN_START_LINE               = 0
*       I_SCREEN_END_COLUMN               = 0
*       I_SCREEN_END_LINE                 = 0
*       I_HTML_HEIGHT_TOP                 = 0
*       I_HTML_HEIGHT_END                 = 0
*       IT_ALV_GRAPHICS                   =
*       IT_HYPERLINK                      =
*       IT_ADD_FIELDCAT                   =
*       IT_EXCEPT_QINFO                   =
*       IR_SALV_FULLSCREEN_ADAPTER        =
*       O_PREVIOUS_SRAL_HANDLER           =
*     IMPORTING
*       E_EXIT_CAUSED_BY_CALLER           =
*       ES_EXIT_CAUSED_BY_USER            =
      TABLES
        t_outtab                          = IT_KNA1
*     EXCEPTIONS
*       PROGRAM_ERROR                     = 1
*       OTHERS                            = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


FORM USER_COMMAND USING COMMAND TYPE SY-UCOMM
                        SELFIELD TYPE SLIS_SELFIELD.

  CASE COMMAND.
    WHEN '&IC1'.
  READ TABLE IT_KNA1 INTO WA_KNA1 INDEX SELFIELD-TABINDEX.
    IF SY-SUBRC =  0.
       SET PARAMETER ID 'KUN' FIELD WA_KNA1-KUNNR.
      CALL TRANSACTION 'XD03' AND SKIP FIRST SCREEN.
    ENDIF.
      ENDCASE.

  ENDFORM.
