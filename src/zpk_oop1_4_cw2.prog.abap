*&---------------------------------------------------------------------*
*& Report ZPK_OOP1_4_CW2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_oop1_4_cw2.





TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         kunnr TYPE vbak-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,


       END OF ty_final.

DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: var TYPE vbak-kunnr.

SELECT-OPTIONS: s_kunnr FOR var.
SELECT a~vbeln,
       a~erdat,
       a~kunnr,
       b~land1,
       b~name1

  INTO TABLE @it_final
  FROM vbak AS a INNER JOIN kna1 AS b ON a~kunnr = b~kunnr
  WHERE a~kunnr IN @s_kunnr.



IF sy-subrc = 0.
  SORT it_final BY kunnr.
ELSE.
  MESSAGE 'data not found' TYPE 'I'.
ENDIF.

perform display.

*&---------------------------------------------------------------------*
*& Form display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display .

  LOOP AT it_final INTO wa_final.
    WRITE:/ wa_final-vbeln,
            wa_final-erdat,
            wa_final-kunnr,
            wa_final-land1,
            wa_final-name1.
  ENDLOOP.
ENDFORM.
