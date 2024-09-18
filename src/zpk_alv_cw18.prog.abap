*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW18
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW18.


*********************************************************
*VBAP- VBELN, POSNR, MATNR, ARKTX
*SELECT-OPTION ON VBELN
*&IC1 on VBELN , CALL TRANSACTION VA03

TYPES: BEGIN OF ty_vbap,
        vbeln TYPE vbap-vbeln,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        arktx TYPE vbap-arktx,
      END OF ty_vbap.


DATA: IT_VBAP TYPE STANDARD TABLE OF TY_VBAP,
      WA_VBAP TYPE TY_VBAP,

      IT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
      WA_FCAT type slis_fieldcat_alv,

      VAR TYPE VBAP-VBELN.

      SELECT-OPTIONS: S_VBELN FOR VAR.

      SELECT  vbeln
              posnr
              matnr
              arktx
  FROM VBAP INTO TABLE IT_VBAP
  WHERE VBELN IN S_VBELN.

   IF sy-subrc = 0.
    sort it_vbap by vbeln.
    else.
      MESSAGE: 'Data not found in table VBAP' TYPE 'I'.
  ENDIF.

     WA_FCAT-COL_POS = 1.
    WA_FCAT-FIELDNAME = 'VBELN'.
    WA_FCAT-TABNAME = 'IT_VBAP'.
    WA_FCAT-SELTEXT_M = 'Sales Document'.
    WA_FCAT-KEY = 'X'.
    WA_FCAT-HOTSPOT = 'X'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

    WA_FCAT-COL_POS = 2.
    WA_FCAT-FIELDNAME = 'POSNR'.
    WA_FCAT-TABNAME = 'IT_VBAP'.
    WA_FCAT-SELTEXT_M = 'Sales Document Item'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

     WA_FCAT-COL_POS = 3.
    WA_FCAT-FIELDNAME = 'MATNR'.
    WA_FCAT-TABNAME = 'IT_VBAP'.
    WA_FCAT-SELTEXT_M = 'Material Number'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.

     WA_FCAT-COL_POS = 4.
    WA_FCAT-FIELDNAME = 'ARKTX'.
    WA_FCAT-TABNAME = 'IT_VBAP'.
    WA_FCAT-SELTEXT_M = 'Short text for sales order item'.

    APPEND WA_FCAT TO IT_FCAT.
    CLEAR WA_FCAT.
*
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
        t_outtab                          = IT_VBAP
*     EXCEPTIONS
*       PROGRAM_ERROR                     = 1
*       OTHERS                            = 2
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
*
*
FORM USER_COMMAND USING COMMAND TYPE SY-UCOMM
                        SELFIELD TYPE SLIS_SELFIELD.

  CASE COMMAND.
    WHEN '&IC1'.
  READ TABLE IT_VBAP INTO WA_VBAP INDEX SELFIELD-TABINDEX.
    IF SY-SUBRC =  0.
       SET PARAMETER ID 'AUN' FIELD WA_VBAP-VBELN.
      CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
    ENDIF.
      ENDCASE.

  ENDFORM.
