*&---------------------------------------------------------------------*
*& Report ZPK_OOP4_3_CW_FAE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP4_3_CW_FAE.

*second alv report will be on table ekko and ekpo joining technique will be for all entries
*common key for joining the for all entries is ebeln

*
*TYPES: BEGIN OF ts_lfa1,
*         lifnr TYPE lfa1-lifnr,
*         name1 TYPE lfa1-name1,
*         ort01 TYPE lfa1-ort01,
*       END OF ts_lfa1.

TYPES: BEGIN OF ts_ekko,
         ebeln TYPE ekko-ebeln,
         bukrs TYPE ekko-bukrs,
         aedat TYPE ekko-aedat,
         lifnr TYPE ekko-lifnr,
       END OF ts_ekko.

TYPES: BEGIN OF ts_ekpo,
         ebeln TYPE ekpo-ebeln,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,
       END OF ts_ekpo.

types: BEGIN OF ty_final,
         ebeln TYPE ekko-ebeln,
         bukrs TYPE ekko-bukrs,
         aedat TYPE ekko-aedat,
         lifnr TYPE ekko-lifnr,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,
         end of ty_final.


data:  it_final TYPE STANDARD TABLE OF ty_final,
       it_ekko type STANDARD TABLE OF ts_ekko,
*       it_lfa1 type STANDARD TABLE OF ts_lfa1,
       it_ekpo type STANDARD TABLE OF ts_ekpo,

       wa_final type ty_final,
       wa_ekpo type ts_ekpo,
       wa_ekko type ts_ekko.
*       wa_lfa1 type ts_lfa1.

data: var type ekko-ebeln.

select-OPTIONS: s_ebeln for var.

select ebeln,
       bukrs,
       aedat,
       lifnr
  from ekko into table @it_ekko
  where ebeln in @s_ebeln.

  IF sy-subrc = 0.
sort it_ekko by ebeln.
else.
   message 'Data not fount in table Lfa1' type 'I'.
  ENDIF.

 IF it_ekko is not initial.
select ebeln
       bukrs
       aedat
       lifnr
  from ekko into TABLE it_ekko
  for all ENTRIES IN it_ekko
  where lifnr = it_ekko-ebeln.
  endif.

    IF sy-subrc = 0.
sort it_ekko by ebeln.
else.
   message 'Data not fount in table Lfa1' type 'I'.
  ENDIF.


loop at it_ekko into wa_ekko.
wa_final-ebeln = wa_ekko-ebeln.
wa_final-bukrs = wa_ekko-bukrs.
wa_final-aedat = wa_ekko-aedat.
wa_final-lifnr = wa_ekko-lifnr.

READ TABLE it_ekpo into wa_ekpo with key wa_ekko-ebeln.
wa_final-ebelp = wa_ekpo-ebelp.
wa_final-matnr = wa_ekpo-matnr.



append wa_final to it_final.
clear:wa_final,
      wa_ekko.
ENDLOOP.

LOOP AT it_final into wa_final.
  write:/ wa_final-ebeln color 1,
          wa_final-bukrs color 2,
          wa_final-aedat color 3 ,
          wa_final-lifnr color 5,
          wa_final-ebelp color 6,
          wa_final-matnr color 4.
*  hide: wa_final-ebeln.
ENDLOOP.

************************
*   we have triggered a detail list with the help of event  AT LINE-SELECTION.
************************

*AT LINE-SELECTION.
*  IF  sy-lsind = 1.
*
*select ebeln
*       ebelp
*       matnr
*  from ekpo into table it_ekpo
*  where ebeln = wa_final-ebeln.
*
*  IF sy-subrc = 0 .
*    sort it_ekpo by ebeln.
*    else.
*      message: 'Data not found in Table Ekpo' type 'I'.
*
*  ENDIF.
*
*LOOP AT it_ekpo INTO wa_ekpo.
*  write:/ wa_ekpo-ebeln,
*          wa_ekpo-ebelp,
*          wa_ekpo-matnr.
*
*ENDLOOP.
*  ENDIF.
