*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw5.

TYPE-POOLS: slis.
TYPES: BEGIN OF ts_likp,
         vbeln TYPE likp-vbeln,
         ernam TYPE likp-ernam,
         vkorg TYPE likp-vkorg,
       END OF ts_likp.

TYPES: BEGIN OF ts_lips,
         vbeln TYPE lips-vbeln,
         posnr TYPE lips-posnr,
         matnr TYPE lips-matnr,
       END OF ts_lips.

TYPES: BEGIN OF ts_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         meins TYPE mara-meins,
       END OF ts_mara.

TYPES: BEGIN OF ty_final,
         vbeln   TYPE likp-vbeln,
         ernam   TYPE likp-ernam,
         vkorg   TYPE likp-vkorg,

         posnr   TYPE lips-posnr,
         matnr   TYPE lips-matnr,

         mtart   TYPE mara-mtart,
         mbrsh   TYPE mara-mbrsh,
         meins   TYPE mara-meins,
         c_index TYPE sy-tabix,
       END OF ty_final.

DATA: it_likp  TYPE STANDARD TABLE OF ts_likp,
      it_lips  TYPE STANDARD TABLE OF ts_lips,
      it_mara  TYPE STANDARD TABLE OF ts_mara,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_likp  TYPE ts_likp,
      wa_lips  TYPE ts_lips,
      wa_mara  TYPE ts_mara,
      wa_final TYPE ty_final.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat TYPE slis_fieldcat_alv.

***********************************************************
DATA:var TYPE lips-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT
      k~vbeln
      k~ernam
      k~vkorg
      p~posnr
      p~matnr
      m~mtart
      m~mbrsh
      m~meins
  INTO TABLE it_final
  FROM likp AS k INNER JOIN lips AS p ON k~vbeln = p~vbeln
                 INNER JOIN mara AS m ON p~matnr = m~matnr
  WHERE k~vbeln IN s_vbeln.

IF  sy-subrc = 0.
  SORT it_final BY vbeln.
ELSE.
  MESSAGE 'Data not found' TYPE 'I'.
ENDIF.




*SELECT vbeln ernam vkorg
*FROM likp INTO TABLE it_likp
*  WHERE vbeln IN s_vbeln.
*
*IF sy-subrc = 0.
*  SORT it_likp BY vbeln.
*ELSE.
*  MESSAGE 'Data not found in table LIKP' TYPE 'I'.
*ENDIF.
*
*
************************************************************
*IF it_likp IS NOT INITIAL.
*
*  SELECT  vbeln
*          posnr
*          matnr
*  FROM lips INTO TABLE it_lips    FOR ALL ENTRIES IN it_likp    WHERE vbeln = it_likp-vbeln.
*ENDIF.
*
*IF sy-subrc = 0.
*  SORT it_lips BY vbeln.
*ELSE.
*  MESSAGE 'Data not found in table LIPS' TYPE 'I'.
*ENDIF.
*
************************************************************
*
*IF it_lips IS NOT INITIAL.
*
*  SELECT matnr
*          mtart
*          mbrsh
*          meins
*    FROM mara INTO TABLE it_mara  FOR ALL ENTRIES IN it_lips   WHERE matnr = it_lips-matnr.
*ENDIF.
*IF sy-subrc = 0.
*  SORT it_mara BY matnr.
*ELSE.
*  MESSAGE 'Data not found in table MARA' TYPE 'I'.
*ENDIF.
***********************************************************
*LOOP AT it_lips INTO wa_lips.
*  wa_final-vbeln = wa_lips-vbeln.
*  wa_final-posnr = wa_lips-posnr.
*  wa_final-matnr = wa_lips-matnr.
*
*  READ TABLE it_likp INTO wa_likp WITH KEY wa_lips-vbeln BINARY SEARCH.
*  wa_final-vbeln = wa_likp-vbeln.
*  wa_final-ernam = wa_likp-ernam.
*  wa_final-vkorg = wa_likp-vkorg.
*
*  READ TABLE it_mara INTO wa_mara WITH KEY wa_lips-matnr BINARY SEARCH.
*  wa_final-matnr = wa_mara-matnr.
*  wa_final-mtart = wa_mara-mtart.
*  wa_final-mbrsh = wa_mara-mbrsh.
*  wa_final-meins = wa_mara-meins.
*
*  APPEND wa_final TO it_final.
*  CLEAR: wa_final, wa_lips, wa_likp, wa_mara.
*ENDLOOP.


*LOOP AT it_final INTO wa_final.
*  WRITE:/ wa_final-vbeln COLOR 1,
*          wa_final-posnr COLOR 2,
*          wa_final-matnr COLOR 3,
*          wa_final-ernam COLOR 4,
*          wa_final-vkorg COLOR 5,
*          wa_final-mtart COLOR 6,
*          wa_final-mbrsh COLOR 7,
*          wa_final-meins COLOR 1.
*ENDLOOP.

CLEAR wa_final.
LOOP AT it_final INTO wa_final.
  wa_final-c_index = sy-tabix.
  MODIFY it_final FROM wa_final INDEX sy-tabix TRANSPORTING c_index.
ENDLOOP.


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


wa_fcat-col_pos = 2.
wa_fcat-fieldname = 'POSNR' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Sales Document Item'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.
wa_fcat-col_pos = 3.
wa_fcat-fieldname = 'MATNR' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Material Number'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.



wa_fcat-col_pos = 4.
wa_fcat-fieldname = 'ERNAM' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Name of Person Responsible for Creating the Object'.

APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 5.
wa_fcat-fieldname = 'VKORG' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Sales Organization'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.



wa_fcat-col_pos = 6.
wa_fcat-fieldname = 'MTART' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Material type'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.


wa_fcat-col_pos = 7.
wa_fcat-fieldname = 'MBRSH' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Industry Sector'.
APPEND wa_fcat TO it_fcat.
CLEAR wa_fcat.

wa_fcat-col_pos = 8.
wa_fcat-fieldname = 'MEINS' .
wa_fcat-tabname = 'IT_FINAL'.
wa_fcat-seltext_m = 'Base Unit of Measure'.
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
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME   =
*   I_BACKGROUND_ID    = ' '
*   I_GRID_TITLE       =
*   I_GRID_SETTINGS    =
*   IS_LAYOUT          =
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
