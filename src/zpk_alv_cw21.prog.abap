*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW21.
*TYPE-POOLS: SLIS.
*
*TYPES: BEGIN OF TY_MARA,
*        MATNR TYPE MARA-MATNR,
*        MTART TYPE MARA-MTART,
*        MBRSH TYPE MARA-MBRSH,
*        MATKL TYPE MARA-MATKL,
*        MEINS TYPE MARA-MEINS,
*      END OF TY_MARA.
*
*TYPES: BEGIN OF TY_MAKT,
*        MATNR TYPE MAKT-MATNR,
*        SPRAS TYPE MAKT-SPRAS,
*        MAKTX TYPE MAKT-MAKTX,
*      END OF TY_MAKT.
*
*DATA: IT_MARA TYPE STANDARD TABLE OF TY_MARA,
*      WA_MARA TYPE TY_MARA,
*
*      IT_MAKT TYPE STANDARD TABLE OF TY_MAKT,
*      WA_MAKT TYPE TY_MAKT.
*
*DATA: IT_FCAT_MARA TYPE SLIS_T_FIELDCAT_ALV, "FOR MARA TABLE
*      WA_FCAT_MARA TYPE SLIS_FIELDCAT_ALV,
*
*      IT_FCAT_MAKT TYPE SLIS_T_FIELDCAT_ALV, "FOR MAKT TABLE
*      WA_FCAT_MAKT TYPE SLIS_FIELDCAT_ALV,
*
*      IT_EVENTS TYPE SLIS_T_EVENT,
*      WA_LAYOUT TYPE SLIS_LAYOUT_ALV.
*
*data: var type mara-matnr.
*
*SELECT-OPTIONS: s_matnr for var.
*
* SELECT MATNR
*       MTART
*       MBRSH
*       MATKL
*       MEINS
*  FROM MARA INTO TABLE IT_MARA WHERE matnr in s_matnr.
*
*  IF IT_MARA IS NOT INITIAL.
*    SELECT MATNR
*           SPRAS
*           MAKTX
*      FROM MAKT INTO TABLE IT_MAKT "UP TO 10 ROWS
*      FOR ALL ENTRIES IN IT_MARa WHERE MATNR = IT_MARA-MATNR.
*  ENDIF.
*
*
*"FOR MARA TABLE
*WA_FCAT_MARA-COL_POS = '1'.
*WA_FCAT_MARA-FIELDNAME = 'MATNR'.
*WA_FCAT_MARA-TABNAME = 'IT_MARA'.
*WA_FCAT_MARA-ref_tabname = 'MARA'.
*WA_FCAT_MARA-REF_FIELDNAME = 'MATNR'.
*APPEND WA_FCAT_MARA TO IT_FCAT_MARA.
*CLEAR WA_FCAT_MARA.
*
*WA_FCAT_MARA-COL_POS = '2'.
*WA_FCAT_MARA-FIELDNAME = 'MTART'.
*WA_FCAT_MARA-TABNAME = 'IT_MARA'.
*WA_FCAT_MARA-ref_tabname = 'MARA'.
*WA_FCAT_MARA-REF_FIELDNAME = 'MTART'.
*APPEND WA_FCAT_MARA TO IT_FCAT_MARA.
*CLEAR WA_FCAT_MARA.
*
*WA_FCAT_MARA-COL_POS = '3'.
*WA_FCAT_MARA-FIELDNAME = 'MEINS'.
*WA_FCAT_MARA-TABNAME = 'IT_MARA'.
*WA_FCAT_MARA-ref_tabname = 'MARA'.
*WA_FCAT_MARA-REF_FIELDNAME = 'MEINS'.
*APPEND WA_FCAT_MARA TO IT_FCAT_MARA.
*CLEAR WA_FCAT_MARA.
*
*
*"FOR MAKT TABLE
*WA_FCAT_MAKT-COL_POS = '1'.
*WA_FCAT_MAKT-FIELDNAME = 'MATNR'.
*WA_FCAT_MAKT-TABNAME = 'IT_MAKT'.
*WA_FCAT_MAKT-REF_TABNAME = 'MAKT'.
*WA_FCAT_MAKT-REF_FIELDNAME = 'MATNR'.
*APPEND WA_FCAT_MAKT TO IT_FCAT_MAKT.
*CLEAR WA_FCAT_MAKT.
*
*WA_FCAT_MAKT-COL_POS = '2'.
*WA_FCAT_MAKT-FIELDNAME = 'SPRAS'.
*WA_FCAT_MAKT-TABNAME = 'IT_MAKT'.
*WA_FCAT_MAKT-REF_TABNAME = 'MAKT'.
*WA_FCAT_MAKT-REF_FIELDNAME = 'SPRAS'.
*APPEND WA_FCAT_MAKT TO IT_FCAT_MAKT.
*CLEAR WA_FCAT_MAKT.
*
*WA_FCAT_MAKT-COL_POS = '3'.
*WA_FCAT_MAKT-FIELDNAME = 'MAKTX'.
*WA_FCAT_MAKT-TABNAME = 'IT_MAKT'.
*WA_FCAT_MAKT-REF_TABNAME = 'MAKT'.
*WA_FCAT_MAKT-REF_FIELDNAME = 'MAKTX'.
*APPEND WA_FCAT_MAKT TO IT_FCAT_MAKT.
*CLEAR WA_FCAT_MAKT.
*
*CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
*  EXPORTING
*    I_CALLBACK_PROGRAM             = SY-REPID.
**   I_CALLBACK_PF_STATUS_SET       = ' '
**   I_CALLBACK_USER_COMMAND        = ' '
**   IT_EXCLUDING                   =
*.
*
*CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
*  EXPORTING
*    IS_LAYOUT                        = WA_LAYOUT
*    IT_FIELDCAT                      = IT_FCAT_MARA
*    I_TABNAME                        = 'IT_MARA'
*    IT_EVENTS                        = IT_EVENTS
**   IT_SORT                          =
**   I_TEXT                           = ' '
*  TABLES
*    T_OUTTAB                         = IT_MARA
** EXCEPTIONS
**   PROGRAM_ERROR                    = 1
**   MAXIMUM_OF_APPENDS_REACHED       = 2
**   OTHERS                           = 3
*          .
*IF SY-SUBRC <> 0.
** Implement suitable error handling here
*ENDIF.
*
*CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
*  EXPORTING
*    IS_LAYOUT                        = WA_LAYOUT
*    IT_FIELDCAT                      = IT_FCAT_MAKT
*    I_TABNAME                        = 'IT_MAKT'
*    IT_EVENTS                        = IT_EVENTS
**   IT_SORT                          =
**   I_TEXT                           = ' '
*  TABLES
*    T_OUTTAB                         = IT_MAKT
** EXCEPTIONS
**   PROGRAM_ERROR                    = 1
**   MAXIMUM_OF_APPENDS_REACHED       = 2
**   OTHERS                           = 3
*          .
*IF SY-SUBRC <> 0.
** Implement suitable error handling here
*ENDIF.
*
*CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
** EXPORTING
**   I_INTERFACE_CHECK             = ' '
**   IS_PRINT                      =
**   I_SCREEN_START_COLUMN         = 0
**   I_SCREEN_START_LINE           = 0
**   I_SCREEN_END_COLUMN           = 0
**   I_SCREEN_END_LINE             = 0
** IMPORTING
**   E_EXIT_CAUSED_BY_CALLER       =
**   ES_EXIT_CAUSED_BY_USER        =
** EXCEPTIONS
**   PROGRAM_ERROR                 = 1
**   OTHERS                        = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

****************************************************
TYPE-POOLS: SLIS.

TYPES: BEGIN OF ty_ekko,
        ebeln TYPE ekko-ebeln,
        bukrs TYPE ekko-bukrs,
        bstyp TYPE ekko-bstyp,
      END OF ty_ekko.

      TYPES: BEGIN OF ty_ekpo,
              ebeln    TYPE ekpo-ebeln,
              ebelp    TYPE ekpo-ebelp,
              uniqueid TYPE ekpo-uniqueid,
            END OF ty_ekpo.






DATA: IT_EKKO TYPE STANDARD TABLE OF TY_EKKO,
      WA_EKKO TYPE TY_EKKO,

      IT_EKPO TYPE STANDARD TABLE OF TY_EKPO,
      WA_EKPO TYPE TY_EKPO.

DATA: IT_FCAT_EKKO TYPE SLIS_T_FIELDCAT_ALV, "FOR EKPO TABLE
      WA_FCAT_EKKO TYPE SLIS_FIELDCAT_ALV,

      IT_FCAT_EKPO TYPE SLIS_T_FIELDCAT_ALV, "FOR EKPO TABLE
      WA_FCAT_EKPO TYPE SLIS_FIELDCAT_ALV,

      IT_EVENTS TYPE SLIS_T_EVENT,
      WA_LAYOUT TYPE SLIS_LAYOUT_ALV.


data: var type ekko-ebeln.

SELECT-OPTIONS: s_ebeln for var.

 SELECT ebeln
        bukrs
        bstyp


  FROM EKKO INTO TABLE IT_EKKO UP TO 10 ROWS WHERE ebeln in s_ebeln.


  IF IT_EKKO IS NOT INITIAL.
    SELECT ebeln
           ebelp
           uniqueid
      FROM EKPO INTO TABLE IT_EKPO UP TO 10 ROWS
      FOR ALL ENTRIES IN IT_EKKO WHERE EBELN = IT_EKKO-EBELN.
  ENDIF.

  "FOR EKKO TABLE
WA_FCAT_EKKO-COL_POS = '1'.
WA_FCAT_EKKO-FIELDNAME = 'EBELN'.
WA_FCAT_EKKO-TABNAME = 'IT_EKKO'.
WA_FCAT_EKKO-ref_tabname = 'EKKO'.
WA_FCAT_EKKO-REF_FIELDNAME = 'EBELN'.
APPEND WA_FCAT_EKKO TO IT_FCAT_EKKO.
CLEAR WA_FCAT_EKKO.

WA_FCAT_EKKO-COL_POS = '2'.
WA_FCAT_EKKO-FIELDNAME = 'BUKRS'.
WA_FCAT_EKKO-TABNAME = 'IT_EKKO'.
WA_FCAT_EKKO-ref_tabname = 'EKKO'.
WA_FCAT_EKKO-REF_FIELDNAME = 'BUKRS'.
APPEND WA_FCAT_EKKO TO IT_FCAT_EKKO.
CLEAR WA_FCAT_EKKO.

WA_FCAT_EKKO-COL_POS = '3'.
WA_FCAT_EKKO-FIELDNAME = 'BSTYP'.
WA_FCAT_EKKO-TABNAME = 'IT_EKPO'.
WA_FCAT_EKKO-ref_tabname = 'EKPO'.
WA_FCAT_EKKO-REF_FIELDNAME = 'BSTYP'.
APPEND WA_FCAT_EKKO TO IT_FCAT_EKKO.
CLEAR WA_FCAT_EKKO.




"FOR EKPO TABLE
WA_FCAT_EKPO-COL_POS = '1'.
WA_FCAT_EKPO-FIELDNAME = 'EBELN'.
WA_FCAT_EKPO-TABNAME = 'IT_EKPO'.
WA_FCAT_EKPO-REF_TABNAME = 'EKPO'.
WA_FCAT_EKPO-REF_FIELDNAME = 'EBELN'.
APPEND WA_FCAT_EKPO TO IT_FCAT_EKPO.
CLEAR WA_FCAT_EKPO.

WA_FCAT_EKPO-COL_POS = '2'.
WA_FCAT_EKPO-FIELDNAME = 'EBELP'.
WA_FCAT_EKPO-TABNAME = 'IT_EKPO'.
WA_FCAT_EKPO-REF_TABNAME = 'EKPO'.
WA_FCAT_EKPO-REF_FIELDNAME = 'EBELP'.
APPEND WA_FCAT_EKPO TO IT_FCAT_EKPO.
CLEAR WA_FCAT_EKPO.

WA_FCAT_EKPO-COL_POS = '3'.
WA_FCAT_EKPO-FIELDNAME = 'UNIQUEID'.
WA_FCAT_EKPO-TABNAME = 'IT_EKPO'.
WA_FCAT_EKPO-REF_TABNAME = 'EKPO'.
WA_FCAT_EKPO-REF_FIELDNAME = 'UNIQUEID'.
APPEND WA_FCAT_EKPO TO IT_FCAT_EKPO.
CLEAR WA_FCAT_EKPO.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
  EXPORTING
    I_CALLBACK_PROGRAM             = SY-REPID.
*   I_CALLBACK_PF_STATUS_SET       = ' '
*   I_CALLBACK_USER_COMMAND        = ' '
*   IT_EXCLUDING                   =
.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    IS_LAYOUT                        = WA_LAYOUT
    IT_FIELDCAT                      = IT_FCAT_EKKO
    I_TABNAME                        = 'IT_EKKO'
    IT_EVENTS                        = IT_EVENTS
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    T_OUTTAB                         = IT_EKKO
* EXCEPTIONS
*   PROGRAM_ERROR                    = 1
*   MAXIMUM_OF_APPENDS_REACHED       = 2
*   OTHERS                           = 3
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    IS_LAYOUT                        = WA_LAYOUT
    IT_FIELDCAT                      = IT_FCAT_EKPO
    I_TABNAME                        = 'IT_EKPO'
    IT_EVENTS                        = IT_EVENTS
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    T_OUTTAB                         = IT_EKPO
* EXCEPTIONS
*   PROGRAM_ERROR                    = 1
*   MAXIMUM_OF_APPENDS_REACHED       = 2
*   OTHERS                           = 3
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
* EXPORTING
*   I_INTERFACE_CHECK             = ' '
*   IS_PRINT                      =
*   I_SCREEN_START_COLUMN         = 0
*   I_SCREEN_START_LINE           = 0
*   I_SCREEN_END_COLUMN           = 0
*   I_SCREEN_END_LINE             = 0
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER       =
*   ES_EXIT_CAUSED_BY_USER        =
* EXCEPTIONS
*   PROGRAM_ERROR                 = 1
*   OTHERS                        = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
