*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw15.


TYPE-POOLS: slis.
TYPES: BEGIN OF ty_spfli,
         carrid   TYPE spfli-carrid,
         connid   TYPE spfli-connid,
         cityfrom TYPE spfli-cityfrom,
         cityto   TYPE spfli-cityto,
       END OF ty_spfli.

TYPES: BEGIN OF ty_scarr,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         currcode TYPE scarr-currcode,
       END OF ty_scarr.


DATA: it_spfli TYPE STANDARD TABLE OF ty_spfli,
      it_scarr TYPE STANDARD TABLE OF ty_scarr,
      it_fcat  TYPE slis_t_fieldcat_alv,
      it_fcat1 TYPE slis_t_fieldcat_alv.


DATA: wa_spfli TYPE ty_spfli,
      wa_scarr TYPE ty_scarr,
      wa_fcat  TYPE slis_fieldcat_alv,
      var      TYPE spfli-carrid.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_carrid FOR var.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  SELECT  carrid
          connid
          cityfrom
          cityto
    FROM spfli INTO TABLE it_spfli
    WHERE carrid IN s_carrid.

  IF sy-subrc = 0.
    SORT it_spfli BY carrid.
  ELSE.
    MESSAGE 'NO DATA AVAILABLE FOR THIS Airline' TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

  Wa_FCAT-col_pos = 1.
  Wa_FCAT-fieldname = 'CARRID'.
  Wa_FCAT-tabname   = 'IT_SPFLI'.
  Wa_FCAT-seltext_m =  'Airline Code'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 2.
  Wa_FCAT-fieldname = 'CONNID'.
  Wa_FCAT-tabname   = 'IT_SPFLI'.
  Wa_FCAT-seltext_m =  'Flight Connection Number'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 3.
  Wa_FCAT-fieldname = 'CITYFROM'.
  Wa_FCAT-tabname   = 'IT_SPFLI'.
  Wa_FCAT-seltext_m =  'Departure city'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 4.
  Wa_FCAT-fieldname = 'CITYTO'.
  Wa_FCAT-tabname   = 'IT_SPFLI'.
  Wa_FCAT-seltext_m =  'Arrival city'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  DATA: wa_layout TYPE slis_layout_alv.

  wa_layout-colwidth_optimize = 'X'.
  wa_layout-zebra             = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      it_fieldcat             = it_fcat
      i_callback_top_of_page  = 'TOP'
      is_layout               = wa_layout
    TABLES
      t_outtab                = it_SPFLI.

FORM top.
  DATA:header TYPE slis_t_listheader,
       wa     TYPE slis_listheader.

  wa-typ = 'H'.
  wa-info = 'ALV BASIC REPORT'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'H'.
  wa-info = 'REPORT PREPARED BY PINAR'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  wa-info = sy-uname.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  WRITE sy-uzeit TO wa-info.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'S'.
  WRITE sy-datum TO wa-info.
*  WA-INFO = SY-DATUM.
  APPEND wa TO header.
  CLEAR wa.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = header
*     I_LOGO             =
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.

*---------------------------------------------------------
FORM user_command USING command LIKE sy-ucomm
                      selfield TYPE slis_selfield  .


  READ TABLE it_spfli INTO wa_spfli INDEX selfield-tabindex.
  IF command EQ '&IC1'.
    CLEAR: it_fcat1[].


    SELECT carrid
           carrname
           currcode

      FROM scarr INTO TABLE it_scarr
      WHERE carrid = wa_spfli-carrid.

    wa_fcat-col_pos = 1.
    wa_fcat-fieldname = 'CARRID'.
    wa_fcat-tabname  = 'IT_SCARR'.
    wa_fcat-seltext_m = 'Airline Code'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

    wa_fcat-col_pos = 2.
    wa_fcat-fieldname = 'CARRNAME'.
    wa_fcat-tabname  = 'IT_SCARR'.
    wa_fcat-seltext_m = 'Airline name'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

    wa_fcat-col_pos = 3.
    wa_fcat-fieldname = 'CURRCODE'.
    wa_fcat-tabname  = 'IT_SCARR'.
    wa_fcat-seltext_m = 'Local currency of airline'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.


*
    DATA: wa_layout1 TYPE slis_layout_alv.

    wa_layout1-colwidth_optimize = 'X'.
    wa_layout1-zebra             = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program     = sy-repid
        it_fieldcat            = iT_FCAT1
        i_callback_top_of_page = 'TOP2'
        is_layout              = wa_layout1
      TABLES
        t_outtab               = iT_SCARR.

  ENDIF.
ENDFORM.
*
*
*
FORM top2.
  DATA:header TYPE slis_t_listheader,
       wa     TYPE slis_listheader.

  wa-typ = 'H'.
  wa-info = 'ALV BASIC REPORT'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'H'.
  wa-info = 'REPORT PREPARED BY PINAR'.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  wa-info = sy-uname.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'A'.
  WRITE sy-uzeit TO wa-info.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'S'.
*  WRITE SY-DATUM TO WA-INFO.
  wa-info = sy-datum.
  APPEND wa TO header.
  CLEAR wa.

  wa-typ = 'S'.
  WRITE sy-datum TO wa-info.
*  WA-INFO = SY-DATUM.
  APPEND wa TO header.
  CLEAR wa.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = header
*     I_LOGO             =
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .


ENDFORM.
