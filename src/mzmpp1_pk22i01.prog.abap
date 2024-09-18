*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK22I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2026  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2026 INPUT.

  CASE sy-ucomm.
    WHEN 'TAB1'.
      pinar4-activetab = 'TAB1'.
    WHEN 'TAB2'.
      pinar4-activetab = 'TAB2'.
    WHEN 'TAB3'.
      pinar4-activetab = 'TAB3'.

  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2027  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2027 INPUT.
*
*  CASE sy-ucomm.
*    WHEN 'TAB1' .
*      SELECT matnr mtart mbrsh matkl meins
*     FROM mara
*     INTO (mara-matnr, mara-mtart, mara-mbrsh, mara-matkl, mara-meins)
*     WHERE matnr = mara-matnr.
*      ENDSELECT.
*  ENDCASE.
*  IF sy-subrc NE 0.
*    MESSAGE: 'DATA NOT FOUND IN TABLE MARA' TYPE  'I'.
*  ENDIF.

**   WRITE: / 'MARA Table Data:', /.
*
*    LOOP AT lt_mara INTO DATA(ls_mara).
*      WRITE: / 'Material ID:', ls_mara-matnr.
*
*    ENDLOOP.
*  ELSE.
*    WRITE: / 'No data found in table MARA.'.
*  ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2028  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2028 INPUT.
*  CASE sy-ucomm.
*    WHEN 'TAB2' .
*      SELECT SINGLE matnr werks pstat
*     FROM marc
*     INTO (marc-matnr, marc-werks, marc-pstat)
*     WHERE matnr = marc-matnr.
*
*ENDCASE.
*
**       SELECT SINGLE matnr werks pstat
**      INTO (ls_marc-matnr, ls_marc-werks, ls_mara-pstat)
**      FROM marc
**      WHERE matnr = marc-matnr.
*
*
*  IF sy-subrc NE 0.
*    MESSAGE: 'DATA NOT FOUND IN TABLE MARC' TYPE  'I'.
*  ENDIF.
*    WRITE: / 'MARC Table Data:', /.
*    LOOP AT lt_marc INTO DATA(ls_marc).
*      WRITE: / 'Material ID:', ls_marc-matnr.
*
*    ENDLOOP.
*    ELSE.
*      WRITE: / 'No data found in table MARC.'.
*    ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2029  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2029 INPUT.
  CASE sy-ucomm.
    WHEN 'TAB3' .
      SELECT SINGLE matnr werks lgort
     FROM mard
     INTO (mard-matnr, mard-werks, mard-lgort)
     WHERE matnr = mard-matnr.
*      ENDSELECT.
*          SELECT SINGLE matnr werks lgort
*      INTO (ls_mard-matnr, ls_mard-werks, ls_mard-lgort)
*      FROM mard
*      WHERE matnr = mard-matnr.



    ENDCASE.
    IF sy-subrc NE 0.
      MESSAGE: 'DATA NOT FOUND IN TABLE MARC' TYPE  'I'.
    ENDIF.
*    WRITE: / 'MARD Table Data:', /.
*    LOOP AT lt_mard INTO DATA(ls_mard).
*      WRITE: / 'Material ID:', ls_mard-matnr.
*
*    ENDLOOP.
*    ELSE.
*      WRITE: / 'No data found in table MARD.'.
*    ENDIF.

ENDMODULE.
