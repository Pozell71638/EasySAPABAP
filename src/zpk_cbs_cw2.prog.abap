*&---------------------------------------------------------------------*
*& Report ZPK_CBS_CW2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_cbs_cw2.
*TABLE: LIPS
*FIELDS


*VBELN, POSNR, MATNR, LFIMG(QUANTITY FIELD FOR CALCULATION)

DATA: it_lips TYPE STANDARD TABLE OF lips,
      wa_lips TYPE lips.
DATA:var TYPE lips-vbeln.
SELECT-OPTIONS: s_vbeln FOR var.
SELECT * FROM lips INTO TABLE it_lips WHERE vbeln IN s_vbeln.

LOOP AT it_lips INTO wa_lips.
  AT FIRST. " first control break statement " like top-of-page
    WRITE:/   'Delivery' COLOR 5,
           14 'Delivery Item' COLOR 5,
           29 'Material Number' COLOR 5,
           44 'Actual quantity delivered (in sales unit)' COLOR 5.

    uline.
  ENDAT.


  AT NEW vbeln.
    WRITE:/14 wa_lips-vbeln, 'Delivery'.
    ULINE.
  ENDAT.


  WRITE: /14 wa_lips-posnr,
          29 wa_lips-matnr,
          44 wa_lips-lfimg.


  AT END OF vbeln.




    ULINE.
    SUM.
    WRITE:/ wa_lips-vbeln,
          44 wa_lips-lfimg.
    ULINE.
  ENDAT.

  AT LAST.
    SUM.
    WRITE:/ 'total', 44 wa_lips-lfimg.
    WRITE:/'End-of-Loop'.

  ENDAT.

ENDLOOP.
