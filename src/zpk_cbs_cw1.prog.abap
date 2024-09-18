*&---------------------------------------------------------------------*
*& Report ZPK_CBS_CW1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_cbs_cw1.

data: it_spfli type STANDARD TABLE OF spfli,
      wa_spfli type spfli.
data:var type spfli-CARRID.
SELECT-OPTIONS: s_carr for var.
select * from spfli into table it_spfli where carrid in s_carr.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  LOOP AT it_spfli into wa_spfli.
at FIRST. " first control break statement " like top-of-page
write:/   'Airline Code' color 5,
       14 'Connection No.' color 5,
       29 'Departure City' color 5,
       44 'Arrival City' color 5,
       58 'Distace'  color 5.
       uline.
endat.

at new Carrid.
  write:/14 wa_spfli-carrid, 'New Airline'.
  uline.
  endat.
  write: /14 wa_spfli-connid,
          29 wa_spfli-cityfrom,
          44 wa_spfli-cityto,
          58 wa_spfli-distance.

  at end of carrid.
    uline.
    sum.
    write:/ wa_spfli-carrid,
          58 wa_spfli-distance.
    uline.
    endat.

    at last.
      sum.
      write:/ 'total', 58 wa_spfli-distance.
      write:/'End-of-Loop'.

      endat.

  ENDLOOP.
