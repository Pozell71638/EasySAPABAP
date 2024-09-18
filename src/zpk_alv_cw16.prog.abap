*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW16.

types : BEGIN OF TY_MARA,
       MATNR TYPE MARA-MATNR,
        MTART TYPE MARA-MTART,
        MBRSH TYPE MARA-MBRSH,
        MEINS TYPE MARA-MEINS,
       END OF TY_MARA.

 DATA: IT_MARA TYPE standard TABLE OF TY_MARA,
       WA_MARA TYPE TY_MARA.

 DATA: IT_FIELDCAT  TYPE  SLIS_T_FIELDCAT_ALV,
       WA_FIELDCAT  type slis_fieldcat_alv.

data: var type mara-matnr.

 select-options: s_matnr for var.

 START-OF-SELECTION.

  SELECT MATNR MTART MBRSH MEINS
  FROM MARA INTO TABLE IT_MARA
  where matnr in s_matnr.

sort it_mara by matnr.

    WA_FIELDCAT-COL_POS = 1.
    WA_FIELDCAT-FIELDNAME = 'MATNR'.
    WA_FIELDCAT-TABNAME = 'IT_MARA'.
    WA_FIELDCAT-SELTEXT_M = ' MATERIAL NO '.
    WA_FIELDCAT-KEY = 'X'.
    WA_FIELDCAT-HOTSPOT = 'X'.

    APPEND WA_FIELDCAT TO IT_FIELDCAT.
    CLEAR WA_FIELDCAT.

    WA_FIELDCAT-COL_POS = 2.
    WA_FIELDCAT-FIELDNAME = 'MTART'.
    WA_FIELDCAT-TABNAME = 'IT_MARA'.
    WA_FIELDCAT-SELTEXT_M = ' MATERIAL TYPE '.

    APPEND WA_FIELDCAT TO IT_FIELDCAT.
    CLEAR WA_FIELDCAT.

     WA_FIELDCAT-COL_POS = 3.
    WA_FIELDCAT-FIELDNAME = 'MBRSH'.
    WA_FIELDCAT-TABNAME = 'IT_MARA'.
    WA_FIELDCAT-SELTEXT_M = ' INDUSTRY SEC '.

    APPEND WA_FIELDCAT TO IT_FIELDCAT.
    CLEAR WA_FIELDCAT.

     WA_FIELDCAT-COL_POS = 4.
    WA_FIELDCAT-FIELDNAME = 'MEINS'.
    WA_FIELDCAT-TABNAME = 'IT_MARA'.
    WA_FIELDCAT-SELTEXT_M = ' BASE OF UNIT'.

    APPEND WA_FIELDCAT TO IT_FIELDCAT.
    CLEAR WA_FIELDCAT.

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
       IT_FIELDCAT                       = IT_FIELDCAT
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
*     IMPORTING
*       E_EXIT_CAUSED_BY_CALLER           =
*       ES_EXIT_CAUSED_BY_USER            =
      TABLES
        T_OUTTAB                          = IT_MARA
     EXCEPTIONS
       PROGRAM_ERROR                     = 1
       OTHERS                            = 2
              .

 form USER_COMMAND USING command LIKE SY-UCOMM
                    SELFIELD TYPE SLIS_SELFIELD.

      CASE  COMMand.
       WHEN '&IC1'.
    READ TABLE IT_MARA INTO WA_MARA INDEX SELFIELD-TABINDEX.
    IF SY-SUBRC =  0.
      SET PARAMETER ID 'MAT' FIELD WA_MARA-MATNR.
      CALL TRANSACTION 'MM02' AND SKIP FIRST SCREEN.
    ENDIF.
      ENDCASE.
      ENDFORM.
