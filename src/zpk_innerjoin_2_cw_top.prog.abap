*&---------------------------------------------------------------------*
*& Include          ZPK_INNERJOIN_2_CW_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_final,
         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         currcode TYPE scarr-currcode,
         url      TYPE scarr-url,
         connid   TYPE sbook-connid,
         fldate   TYPE sbook-fldate,
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
       END OF ty_final.

DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: var TYPE scarr-carrid.
