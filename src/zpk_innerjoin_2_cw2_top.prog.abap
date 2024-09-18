*&---------------------------------------------------------------------*
*& Include          ZPK_INNERJOIN_2_CW2_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_final,
         carrid   TYPE sbook-carrid,
         connid   TYPE sbook-connid,
         fldate   TYPE sbook-fldate,
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
         id       TYPE scustom-id,
         name     TYPE scustom-name,
         form     TYPE scustom-form,
         street   TYPE scustom-street,
       END OF ty_final.

DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: var TYPE sbook-customid.
