*&---------------------------------------------------------------------*
*& Report ZPK_BLOCK_CW4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_block_cw4.

**************************************************************
TYPE-POOLS: slis.
TYPES: BEGIN OF ty_vbrk,
         vbeln TYPE vbrk-vbeln,
         waerk TYPE vbrk-waerk,
         vkorg TYPE vbrk-vkorg,
         vtweg TYPE vbrk-vtweg,
         fkdat TYPE vbrk-fkdat,
       END OF ty_vbrk.

TYPES: BEGIN OF ty_vbrp,
         vbeln TYPE vbrp-vbeln,
         posnr TYPE vbrp-posnr,
         meins TYPE vbrp-meins,
         ntgew TYPE vbrp-ntgew,
       END OF ty_vbrp.

DATA: it_vbrk TYPE STANDARD TABLE OF ty_vbrk,
      wa_vbrk TYPE ty_vbrk,

      it_vbrp TYPE STANDARD TABLE OF ty_vbrp,
      wa_vbrp TYPE ty_vbrp.

DATA: it_fcat_vbrk TYPE slis_t_fieldcat_alv, "FOR MARA TABLE
      wa_fcat_vbrk TYPE slis_fieldcat_alv,

      it_fcat_vbrp TYPE slis_t_fieldcat_alv, "FOR MAKT TABLE
      wa_fcat_vbrp TYPE slis_fieldcat_alv,

      it_events    TYPE slis_t_event,
      wa_layout    TYPE slis_layout_alv.

DATA: var TYPE vbrk-vbeln.

SELECT-OPTIONS: s_vbeln for var.

 SELECT vbeln
        waerk
        vkorg
        vtweg
        fkdat
  FROM VBRK INTO TABLE IT_VBRK WHERE VBELN in S_VBELN.

  IF IT_VBRK IS NOT INITIAL.
    SELECT  vbeln
            posnr
            meins
            ntgew

      FROM VBRP INTO TABLE IT_VBRP "UP TO 10 ROWS
      FOR ALL ENTRIES IN IT_VBRK WHERE VBELN = IT_VBRK-VBELN.
  ENDIF.


"FOR VBRK TABLE
WA_FCAT_VBRK-COL_POS = '1'.
WA_FCAT_VBRK-FIELDNAME = 'VBELN'.
WA_FCAT_VBRK-TABNAME = 'IT_VBRK'.
WA_FCAT_VBRK-ref_tabname = 'VBRK'.
WA_FCAT_VBRK-REF_FIELDNAME = 'VBELN'.
APPEND WA_FCAT_VBRK TO IT_FCAT_VBRK.
CLEAR WA_FCAT_VBRK.

WA_FCAT_VBRK-COL_POS = '2'.
WA_FCAT_VBRK-FIELDNAME = 'WAERK'.
WA_FCAT_VBRK-TABNAME = 'IT_VBRK'.
WA_FCAT_VBRK-ref_tabname = 'VBRK'.
WA_FCAT_VBRK-REF_FIELDNAME = 'WAERK'.
APPEND WA_FCAT_VBRK TO IT_FCAT_VBRK.
CLEAR WA_FCAT_VBRK.

WA_FCAT_VBRK-COL_POS = '3'.
WA_FCAT_VBRK-FIELDNAME = 'VKORG'.
WA_FCAT_VBRK-TABNAME = 'IT_VBRK'.
WA_FCAT_VBRK-ref_tabname = 'VBRK'.
WA_FCAT_VBRK-REF_FIELDNAME = 'VKORG'.
APPEND WA_FCAT_VBRK TO IT_FCAT_VBRK.
CLEAR WA_FCAT_VBRK.


WA_FCAT_VBRK-COL_POS = '4'.
WA_FCAT_VBRK-FIELDNAME = 'VTWEG'.
WA_FCAT_VBRK-TABNAME = 'IT_VBRK'.
WA_FCAT_VBRK-ref_tabname = 'VBRK'.
WA_FCAT_VBRK-REF_FIELDNAME = 'VTWEG'.
APPEND WA_FCAT_VBRK TO IT_FCAT_VBRK.
CLEAR WA_FCAT_VBRK.


WA_FCAT_VBRK-COL_POS = '5'.
WA_FCAT_VBRK-FIELDNAME = 'FKDAT'.
WA_FCAT_VBRK-TABNAME = 'IT_VBRK'.
WA_FCAT_VBRK-ref_tabname = 'VBRK'.
WA_FCAT_VBRK-REF_FIELDNAME = 'FKDAT'.
APPEND WA_FCAT_VBRK TO IT_FCAT_VBRK.
CLEAR WA_FCAT_VBRK.


"FOR VBRP TABLE
WA_FCAT_VBRP-COL_POS = '1'.
WA_FCAT_VBRP-FIELDNAME = 'VBELN'.
WA_FCAT_VBRP-TABNAME = 'IT_VBRP'.
WA_FCAT_VBRP-REF_TABNAME = 'VBRP'.
WA_FCAT_VBRP-REF_FIELDNAME = 'VBELN'.
APPEND WA_FCAT_VBRP TO IT_FCAT_VBRP.
CLEAR WA_FCAT_VBRP.
*
WA_FCAT_VBRP-COL_POS = '2'.
WA_FCAT_VBRP-FIELDNAME = 'POSNR'.
WA_FCAT_VBRP-TABNAME = 'IT_VBRP'.
WA_FCAT_VBRP-REF_TABNAME = 'VBRP'.
WA_FCAT_VBRP-REF_FIELDNAME = 'POSNR'.
APPEND WA_FCAT_VBRP TO IT_FCAT_VBRP.
CLEAR WA_FCAT_VBRP.

WA_FCAT_VBRP-COL_POS = '3'.
WA_FCAT_VBRP-FIELDNAME = 'MEINS'.
WA_FCAT_VBRP-TABNAME = 'IT_VBRP'.
WA_FCAT_VBRP-REF_TABNAME = 'VBRP'.
WA_FCAT_VBRP-REF_FIELDNAME = 'MEINS'.
APPEND WA_FCAT_VBRP TO IT_FCAT_VBRP.
CLEAR WA_FCAT_VBRP.

WA_FCAT_VBRP-COL_POS = '4'.
WA_FCAT_VBRP-FIELDNAME = 'NTGEW'.
WA_FCAT_VBRP-TABNAME = 'IT_VBRP'.
WA_FCAT_VBRP-REF_TABNAME = 'VBRP'.
WA_FCAT_VBRP-REF_FIELDNAME = 'NTGEW'.
APPEND WA_FCAT_VBRP TO IT_FCAT_VBRP.
CLEAR WA_FCAT_VBRP.

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
    IT_FIELDCAT                      = IT_FCAT_VBRK
    I_TABNAME                        = 'VBRK'
    IT_EVENTS                        = IT_EVENTS
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    T_OUTTAB                         = IT_VBRK
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



CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
  EXPORTING
    is_layout                        = WA_LAYOUT
    it_fieldcat                      = IT_FCAT_VBRP
    i_tabname                        = 'VBRP'
    it_events                        = IT_EVENTS
*   IT_SORT                          =
*   I_TEXT                           = ' '
  TABLES
    t_outtab                         = IT_VBRP
* EXCEPTIONS
*   PROGRAM_ERROR                    = 1
*   MAXIMUM_OF_APPENDS_REACHED       = 2
*   OTHERS                           = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

"""""""""""""""""""""""""""""""""""""""
CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'.

FORM TOP_PAGE.
wRITE:/ 'THIS IS BLOCKED ALV REPORT PROGRAM BASED ON 2 BLOCK' COLOR 5.
ENDFORM.
