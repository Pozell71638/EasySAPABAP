*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw14.

*-----------------------------------------------------------
TYPE-POOLS: slis.
TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         matwa TYPE vbap-matwa,
       END OF ty_vbap.
TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         ersda TYPE mara-ersda,
         ernam TYPE mara-ernam,
         laeda TYPE mara-laeda,
       END OF ty_mara.
DATA: it_vbap  TYPE STANDARD TABLE OF ty_vbap,
      it_mara  TYPE STANDARD TABLE OF ty_mara,
      it_fcat  TYPE slis_t_fieldcat_alv,
      it_fcat1 TYPE slis_t_fieldcat_alv.


DATA: wa_vbap TYPE ty_vbap,
      wa_mara TYPE ty_mara,
      wa_fcat TYPE slis_fieldcat_alv,

      var     TYPE vbap-matnr.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR var.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  SELECT  vbeln
          posnr
          matnr
          matwa

    FROM vbap INTO TABLE it_vbap
    WHERE matnr IN s_matnr.

  IF sy-subrc = 0.
    SORT it_vbap BY matnr.
  ELSE.
    MESSAGE 'NO DATA AVAILABLE FOR THIS Airline' TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

  Wa_FCAT-col_pos = 1.
  Wa_FCAT-fieldname = 'VBELN'.
  Wa_FCAT-tabname   = 'IT_VBAP'.
  Wa_FCAT-seltext_m =  'Sales Document'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 2.
  Wa_FCAT-fieldname = 'POSNR'.
  Wa_FCAT-tabname   = 'IT_VBAP'.
  Wa_FCAT-seltext_m =  'Sales Document Item'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 3.
  Wa_FCAT-fieldname = 'MATNR'.
  Wa_FCAT-tabname   = 'IT_VBAP'.
  Wa_FCAT-seltext_m =  'Material Number'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  Wa_FCAT-col_pos = 4.
  Wa_FCAT-fieldname = 'MATWA'.
  Wa_FCAT-tabname   = 'IT_VBAP'.
  Wa_FCAT-seltext_m =  'Material Entered'.
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
      t_outtab                = it_vbap.

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
      it_list_commentary       = HEADER
*     I_LOGO                   =
*     I_END_OF_LIST_GRID       =
*     I_ALV_FORM               =
            .
ENDFORM.
*----------------------------------------------------------


FORM user_command USING command LIKE sy-ucomm
                      selfield TYPE slis_selfield  .


  READ TABLE it_vbap INTO wa_vbap INDEX selfield-tabindex.
  IF command EQ '&IC1'.
    CLEAR: it_fcat1[].


    SELECT matnr
           ersda
           ernam
           laeda
      FROM mara INTO TABLE it_mara
      WHERE matnr = wa_VBAP-matnr.

    wa_fcat-col_pos = 1.
    wa_fcat-fieldname = 'MATNR'.
    wa_fcat-tabname  = 'IT_MARA'.
    wa_fcat-seltext_m = 'Material Number'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

    wa_fcat-col_pos = 2.
    wa_fcat-fieldname = 'ERSDA'.
    wa_fcat-tabname  = 'IT_MARA'.
    wa_fcat-seltext_m = 'Created On'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

    wa_fcat-col_pos = 3.
    wa_fcat-fieldname = 'ERNAM'.
    wa_fcat-tabname  = 'IT_MARA'.
    wa_fcat-seltext_m = 'Name of Person Responsible for Creating the Object'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

    wa_fcat-col_pos = 4.
    wa_fcat-fieldname = 'LAEDA'.
    wa_fcat-tabname  = 'IT_MARA'.
    wa_fcat-seltext_m = 'Date of Last Change'.
    APPEND wa_fcat TO it_fcat1.
    CLEAR  wa_fcat.

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
        t_outtab               = iT_MARA.

  ENDIF.
ENDFORM.



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
      it_list_commentary       = HEADER
*     I_LOGO                   =
*     I_END_OF_LIST_GRID       =
*     I_ALV_FORM               =
            .


ENDFORM.
