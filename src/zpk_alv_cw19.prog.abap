*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW19
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw19.
TYPE-POOLS: slis.
****************************************************
*Create an interavtive report which will be displayed three different outputs.
*First output will be based on the INNER JOIN between tables VBAP and VBAK.
*Second output will be based on the material number SELECTED ON THE FIRST OUTPUT and details of the second ouput will be from MARA table.
*Third output will be that TCODE MM03,it is dislayed when material number of the second output is clicked.
*
*Display the headings on the first two outputs.

*****************************************************

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ty_vbap.

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,
       END OF ty_vbak.

TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         ersda TYPE mara-ersda,
         ernam TYPE mara-ernam,
         laeda TYPE mara-laeda,
       END OF ty_mara.

TYPES:BEGIN OF ty_final,
        vbeln TYPE vbap-vbeln,
        posnr TYPE vbap-posnr,
        matnr TYPE vbap-matnr,
        arktx TYPE vbap-arktx,
        erdat TYPE vbak-erdat,
        erzet TYPE vbak-erzet,
        ernam TYPE vbak-ernam,

      END OF ty_final.





DATA: t_vbap   TYPE STANDARD TABLE OF ty_vbap,
      t_vbak   TYPE STANDARD TABLE OF ty_vbak,
      t_mara   TYPE STANDARD TABLE OF ty_mara,
      it_final TYPE STANDARD TABLE OF ty_final,
      t_fcat   TYPE slis_t_fieldcat_alv,
      t_fcat1  TYPE slis_t_fieldcat_alv,
      t_fcat2  TYPE slis_t_fieldcat_alv.

DATA: w_vbap   TYPE ty_vbap,
      w_vbak   TYPE ty_vbak,
      w_mara   TYPE ty_mara,
      wa_final TYPE ty_final,
      w_fcat   TYPE slis_fieldcat_alv.
DATA: var TYPE vbap-vbeln.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR var.
SELECTION-SCREEN END OF BLOCK b1.

SELECT
      k~vbeln
      k~posnr
      k~matnr
      k~arktx
      p~erdat
      p~erzet
      p~ernam

  INTO TABLE it_final
  FROM vbap AS k INNER JOIN vbak AS p ON k~vbeln = p~vbeln

  WHERE k~vbeln IN s_vbeln.

IF  sy-subrc = 0.
  SORT it_final BY vbeln.
ELSE.
  MESSAGE 'Data not found' TYPE 'I'.
ENDIF.

w_fcat-col_pos = 1.
w_fcat-fieldname = 'VBELN'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Sales Document'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.

w_fcat-col_pos = 2.
w_fcat-fieldname = 'POSNR'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Sales Document Item'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.

w_fcat-col_pos = 3.
w_fcat-fieldname = 'MATNR'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Material Number'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.


w_fcat-col_pos = 4.
w_fcat-fieldname = 'ARKTX'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Short text for sales order item'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.


w_fcat-col_pos = 5.
w_fcat-fieldname = 'ERDAT'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Date on which the record was created'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.

w_fcat-col_pos = 6.
w_fcat-fieldname = 'ERZET'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Entry time'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.


w_fcat-col_pos = 7.
w_fcat-fieldname = 'ERNAM'.
w_fcat-tabname   = 'IT_FINAL'.
w_fcat-seltext_m =  'Name of Person Responsible for Creating the Object'.
APPEND w_fcat TO t_fcat.
CLEAR w_fcat.


DATA: wa_layout1 TYPE slis_layout_alv.
wa_layout1-colwidth_optimize = 'X'.
wa_layout1-zebra             = 'X'.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program      = sy-repid
    i_callback_user_command = 'USER_COMMAND'
    it_fieldcat             = t_fcat
    is_layout               = wa_layout1
    i_callback_top_of_page  = 'TOP'
  TABLES
    t_outtab                = it_final.


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
      i_logo             = 'ENJOYSAP_LOGO'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.


FORM user_command USING command LIKE sy-ucomm
                        selfield TYPE slis_selfield.

  READ TABLE it_final INTO wa_final INDEX selfield-tabindex.

  IF command = '&IC1'.
    CLEAR: t_fcat1[].

    SELECT matnr
            ersda
            ernam
            laeda

    FROM mara
    INTO TABLE t_mara
    WHERE matnr = wa_final-matnr.

    w_fcat-fieldname = 'MATNR'.
    w_fcat-tabname  = 'T_MARA'.
    w_fcat-seltext_m = 'MATERIAL NO'.
    w_fcat-col_pos = 1.
    APPEND w_fcat TO t_fcat1.
    CLEAR w_fcat.

    w_fcat-fieldname = 'ERSDA'.
    w_fcat-tabname  = 'T_MARA'.
    w_fcat-seltext_m = 'Created On'.
    w_fcat-col_pos = 2.
    APPEND w_fcat TO t_fcat1.
    CLEAR w_fcat.

    w_fcat-fieldname = 'ERNAM'.
    w_fcat-tabname  = 'T_MARA'.
    w_fcat-seltext_m = 'Name of Person Responsible for Creating the Object'.
    w_fcat-col_pos = 3.
    APPEND w_fcat TO t_fcat1.
    CLEAR w_fcat.

    w_fcat-fieldname = 'LAEDA'.
    w_fcat-tabname  = 'T_MARA'.
    w_fcat-seltext_m = 'Date of Last Change'.
    w_fcat-col_pos = 4.
    APPEND w_fcat TO t_fcat1.
    CLEAR w_fcat.

    DATA: wa_layout2 TYPE slis_layout_alv.
    wa_layout2-colwidth_optimize = 'X'.
    wa_layout2-zebra             = 'X'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program      = sy-repid
        i_callback_user_command = 'USER_COMMAND2'
        it_fieldcat             = t_fcat1
        is_layout               = wa_layout2
        I_CALLBACK_TOP_OF_PAGE             = 'TOP2'
      TABLES
        t_outtab                = t_mara.
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
      it_list_commentary = header
      i_logo             = 'ENJOYSAP_LOGO'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.

FORM user_command2 USING command TYPE sy-ucomm
                        selfield TYPE slis_selfield.

  CASE command.
    WHEN '&IC1'.
      READ TABLE t_mara INTO w_mara INDEX selfield-tabindex.
      IF sy-subrc =  0.
        SET PARAMETER ID 'MAT' FIELD w_mara-matnr.
        CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
      ENDIF.
  ENDCASE.

ENDFORM.
