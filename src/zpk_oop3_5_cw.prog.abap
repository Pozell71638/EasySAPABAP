*&---------------------------------------------------------------------*
*& Report ZPK_OOP3_5_CW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_oop3_5_cw.



TYPES: BEGIN OF ty_final,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         meins TYPE mara-meins,
         spras TYPE makt-spras,
         maktx TYPE makt-maktx,
       END OF ty_final.
DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.


SELECT-OPTIONS: s_matnr FOR wa_final-matnr.

CLASS parent DEFINITION.
  PUBLIC SECTION.
    METHODS: display.
ENDCLASS.

CLASS parent IMPLEMENTATION.
  METHOD display.
    SELECT a~matnr,
       a~mtart,
       a~meins,
      b~spras,
       b~maktx
      INTO TABLE @it_final
      FROM mara  as a INNER JOIN makt as b ON a~matnr = b~matnr
      WHERE a~matnr IN @s_matnr.

    IF sy-subrc <> 0.
      MESSAGE 'Data not found' TYPE 'I'.
    ENDIF.

    LOOP AT it_final INTO wa_final.
      WRITE:/ wa_final-matnr,
              wa_final-mtart,
              wa_final-meins,
              wa_final-spras,
              wa_final-maktx.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA: obj TYPE REF TO parent.
  CREATE OBJECT obj.

  CALL METHOD obj->display.
