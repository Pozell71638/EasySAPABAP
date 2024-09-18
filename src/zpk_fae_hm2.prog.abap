*&---------------------------------------------------------------------*
*& Report ZPK_FAE_HM2
*&---------------------------------------------------------------------*
*&tables: EKKO, EKPO, LAF1.
*LFA1----(LIFNR)----EKKO ---- (EBELN)----- EKPO

*SELECT-OPTIONS ON LFA1-LIFNR

*Fields to be selected :- LFA1-LIFNR,NAME1, ORT01
*     EKKO- EBELN,bukrs,aedat LIFNR,
*    EKPO- EBELN , EBELP, MATNR,

*FIRST LOOP ON ekko .
*FIRST rEAD TABLE ON lfa1 WITH KEY ON wa_ekko-lifnr
*SECOND READ TABLE ON EKPO WITH KEY ON WA_EKKO-EBELN
*ENDLOOP.
*&---------------------------------------------------------------------*
REPORT zpk_fae_hm2.

TYPES: BEGIN OF ts_lfa1,
         lifnr TYPE lfa1-lifnr,
         name1 TYPE lfa1-name1,
         ort01 TYPE lfa1-ort01,
       END OF ts_lfa1.


TYPES: BEGIN OF ts_ekpo,
         ebeln TYPE ekpo-ebeln,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,
       END OF ts_ekpo.


TYPES: BEGIN OF ts_ekko,
         ebeln TYPE ekko-ebeln,
         bukrs TYPE ekko-bukrs,
         aedat TYPE ekko-aedat,
         lifnr TYPE ekko-lifnr,
       END OF ts_ekko.

TYPES: BEGIN OF ty_final,

         lifnr TYPE lfa1-lifnr,
         name1 TYPE lfa1-name1,
         ort01 TYPE lfa1-ort01,
         ebeln TYPE ekko-ebeln,
         bukrs TYPE ekko-bukrs,
         aedat TYPE ekko-aedat,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,

       END OF ty_final.

DATA: it_lfa1  TYPE STANDARD TABLE OF ts_lfa1,
      it_ekpo  TYPE STANDARD TABLE OF ts_ekpo,
      it_ekko  TYPE STANDARD TABLE OF ts_ekko,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_lfa1  TYPE ts_lfa1,
      wa_ekpo  TYPE ts_ekpo,
      wa_ekko  TYPE ts_ekko,
      wa_final TYPE ty_final.



DATA:var TYPE lfa1-lifnr.

SELECT-OPTIONS: s_lifnr FOR var.



SELECT lifnr name1 ort01

FROM lfa1 INTO TABLE it_lfa1
  WHERE lifnr IN s_lifnr.

IF sy-subrc = 0.
  SORT it_lfa1 BY lifnr.
ELSE.
  MESSAGE 'Data not found in table LFA1' TYPE 'I'.
ENDIF.
**********************************

IF it_lfa1 IS NOT INITIAL.


  SELECT ebeln bukrs aedat lifnr

  FROM ekko INTO TABLE it_ekko   FOR ALL ENTRIES IN it_lfa1    WHERE lifnr = it_lfa1-lifnr.
ENDIF.

IF sy-subrc = 0.
  SORT it_ekko BY ebeln.
ELSE.
  MESSAGE 'Data not found in table EKKO' TYPE 'I'.
ENDIF.

***********************************



*IF it_ekko IS NOT INITIAL.
*
*  SELECT ebeln ebelp matnr
*
*    FROM ekpo INTO TABLE it_ekpo    FOR ALL ENTRIES IN it_ekko    WHERE ebeln = it_ekko-ebeln.
*ENDIF.
*IF sy-subrc = 0.
*  SORT it_ekpo BY ebeln.
*ELSE.
*  MESSAGE 'Data not found in table EKPO' TYPE 'I'.
*ENDIF.

***********************************


*LOOP AT it_lfa1 INTO wa_lfa1.
*  wa_final-lifnr = wa_lfa1-lifnr.
*  wa_final-name1 = wa_lfa1-name1.
*  wa_final-ort01 = wa_lfa1-ort01.

*  READ TABLE it_ekko INTO wa_ekko WITH KEY wa_lfa1-lifnr BINARY SEARCH.
*  wa_final-ebeln = wa_ekko-ebeln.
*  wa_final-bukrs = wa_ekko-bukrs.
*  wa_final-aedat = wa_ekko-aedat.



loop at it_ekko into wa_ekko.
wa_final-ebeln = wa_ekko-ebeln.
wa_final-bukrs = wa_ekko-bukrs.
wa_final-aedat = wa_ekko-aedat.
wa_final-lifnr = wa_ekko-lifnr.

READ TABLE it_lfa1 into wa_lfa1 with key wa_ekko-lifnr BINARY SEARCH.
wa_final-name1 = wa_lfa1-name1.
wa_final-ort01 = wa_lfa1-ort01.

* READ TABLE it_ekpo INTO wa_ekpo WITH KEY wa_ekko-ebeln BINARY SEARCH.
*  wa_final-ebelp = wa_ekpo-ebelp.
*  wa_final-matnr = wa_ekpo-matnr.




  APPEND wa_final TO it_final.
  CLEAR: wa_final, wa_lfa1, wa_ekko, wa_ekpo.
ENDLOOP.


LOOP AT it_final INTO wa_final.
  WRITE:/ wa_final-lifnr COLOR 1,
          wa_final-name1 COLOR 2,
          wa_final-ort01 COLOR 3,
          wa_final-ebeln  HOTSPOT ON COLOR 4,
          wa_final-bukrs COLOR 5,
          wa_final-aedat COLOR 6.
hide: wa_final-ebeln.

ENDLOOP.

AT LINE-SELECTION.
  IF  sy-lsind = 1.

select ebeln
       ebelp
       matnr
  from ekpo into table it_ekpo
  where ebeln = wa_final-ebeln.

  IF sy-subrc = 0 .
    sort it_ekpo by ebeln.
    else.
      message: 'Data not found in Table Ekpo' type 'I'.

  ENDIF.

LOOP AT it_ekpo INTO wa_ekpo.
  write:/ wa_ekpo-ebeln,
          wa_ekpo-ebelp,
          wa_ekpo-matnr.

ENDLOOP.
  ENDIF.
