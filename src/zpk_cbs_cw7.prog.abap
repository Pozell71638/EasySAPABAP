*&---------------------------------------------------------------------*
*& Report ZPK_CBS_CW7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CBS_CW7.

*DATA: it_spfli TYPE STANDARD TABLE OF spfli,
*      wa_spfli TYPE spfli.
*DATA:var TYPE spfli-carrid.
*SELECT-OPTIONS: s_carr FOR var.
*SELECT * FROM spfli INTO TABLE it_spfli WHERE carrid IN s_carr.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*LOOP AT it_spfli INTO wa_spfli.
*  AT FIRST. " first control break statement " like top-of-page
*    WRITE:/   'Airline Code' COLOR 5,
*           14 'Connection No.' COLOR 5,
*           29 'Departure City' COLOR 5,
*           44 'Arrival City' COLOR 5,
*           58 'Distace'  COLOR 5.
*    ULINE.
*  ENDAT.
***********************************************************************
*  AT NEW Carrid.
*    WRITE:/14 wa_spfli-carrid, 'New Airline'.
*    ULINE.
*  ENDAT.
*
*
*  WRITE: /14 wa_spfli-connid,
*          29 wa_spfli-cityfrom,
*          44 wa_spfli-cityto,
*          58 wa_spfli-distance.
*************************************************************************
*  AT END OF carrid.
*
*
*
*
*    ULINE.
*    SUM.
*    WRITE:/ wa_spfli-carrid,
*          58 wa_spfli-distance.
*    ULINE.
*  ENDAT.
*
*************************************************************************
*  AT LAST.
*    SUM.
*    WRITE:/ 'total', 58 wa_spfli-distance.
*    WRITE:/'End-of-Loop'.
*
*  ENDAT.
*
*ENDLOOP.
************************************************************************
DATA: it_sflight TYPE STANDARD TABLE OF sflight,
      wa_sflight TYPE sflight.
DATA:var TYPE sflight-carrid.
SELECT-OPTIONS: s_carr FOR var.
SELECT * FROM sflight INTO TABLE it_sflight WHERE carrid IN s_carr.

LOOP AT it_sflight INTO wa_sflight.
  AT FIRST. " first control break statement " like top-of-page
    WRITE:/   'Airline Code' COLOR 5,
           14 'Connection No.' COLOR 5,
           29 'Flight Date' COLOR 5,
           44 'Airfare' COLOR 5,
           58 'Occupied seats in economy class'  COLOR 5.
    ULINE.
  ENDAT.
************************************************************************
    AT NEW Carrid.
    WRITE:/14 wa_sflight-carrid, 'New Airline'.
    ULINE.
  ENDAT.


  WRITE: /14 wa_sflight-connid,
          29 wa_sflight-fldate,
          44 wa_sflight-price,
          58 wa_sflight-seatsocc.


************************************************************************
   AT END OF carrid.




    ULINE.
    SUM.
    WRITE:/ wa_sflight-carrid,
          58 wa_sflight-seatsocc.
    ULINE.
  ENDAT.



************************************************************************

   AT LAST.
    SUM.
    WRITE:/ 'total', 58 wa_sflight-seatsocc.
    WRITE:/'End-of-Loop'.

  ENDAT.

ENDLOOP.
