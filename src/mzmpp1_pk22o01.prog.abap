*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK22O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_2026 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2026 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_2027 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2027 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

  CASE sy-ucomm.
    WHEN 'TAB1' .
      SELECT single matnr mtart mbrsh matkl meins
     FROM mara
     INTO (mara-matnr, mara-mtart, mara-mbrsh, mara-matkl, mara-meins)
     WHERE matnr = mara-matnr.

  IF sy-subrc NE 0.
    MESSAGE: 'DATA NOT FOUND IN TABLE MARA' TYPE  'I'.
  ENDIF.
  endcase.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_2028 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2028 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.
    CASE sy-ucomm.
    WHEN 'TAB2' .
      SELECT SINGLE matnr werks pstat
     FROM marc
     INTO (marc-matnr, marc-werks, marc-pstat)
     WHERE matnr = mara-matnr.

*       SELECT SINGLE matnr werks pstat
*      INTO (ls_marc-matnr, ls_marc-werks, ls_mara-pstat)
*      FROM marc
*      WHERE matnr = marc-matnr.


  IF sy-subrc NE 0.
    MESSAGE: 'DATA NOT FOUND IN TABLE MARC' TYPE  'I'.
  ENDIF.
endcase.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_2029 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_2029 OUTPUT.
* SET PF-STATUS 'xxxxxxxx'.
* SET TITLEBAR 'xxx'.

   CASE sy-ucomm.
    WHEN 'TAB3' .
      SELECT SINGLE matnr werks pstat
     FROM mard
     INTO (mard-matnr, mard-werks, MARD-PSTAT)
     WHERE matnr = mara-matnr.


    IF sy-subrc NE 0.
      MESSAGE: 'DATA NOT FOUND IN TABLE MARC' TYPE  'I'.
    ENDIF.
ENDCASE.
ENDMODULE.
