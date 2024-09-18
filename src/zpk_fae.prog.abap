*&---------------------------------------------------------------------*
*& Report ZPK_FAE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_FAE.
TYPES: BEGIN OF ts_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
       END OF ts_mara.

TYPES: BEGIN OF ts_marc,
         matnr TYPE marc-matnr,
         werks TYPE marc-werks,
         pstat TYPE marc-pstat,
       END OF ts_marc.

TYPES: BEGIN OF ts_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
       END OF ts_mard.

TYPES: BEGIN OF ty_final,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         werks TYPE marc-werks,
         pstat TYPE marc-pstat,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
       END OF ty_final.

DATA: it_mara  TYPE STANDARD TABLE OF ts_mara,
      it_marc  TYPE STANDARD TABLE OF ts_marc,
      it_mard  TYPE STANDARD TABLE OF ts_mard,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_mara  TYPE ts_mara,
      wa_marc  TYPE ts_marc,
      wa_mard  TYPE ts_mard,
      wa_final TYPE ty_final.

data:var type mara-matnr.

SELECT-OPTIONS: s_matnr FOR var.

SELECT matnr mtart mbrsh
  FROM mara INTO TABLE it_mara
  WHERE matnr IN s_matnr.

IF sy-subrc = 0.
  SORT it_mara BY matnr.
ELSE.
  MESSAGE 'Data not found in table Mara' TYPE 'I'.
ENDIF.

IF it_mara IS NOT INITIAL.
  SELECT matnr werks pstat
    FROM marc INTO TABLE it_marc
    FOR ALL ENTRIES IN it_mara
    WHERE matnr = it_mara-matnr.
ENDIF.

IF sy-subrc = 0.
  SORT it_marc BY matnr.
ELSE.
  MESSAGE 'Data not found in table Marc' TYPE 'I'.
ENDIF.

IF it_marc IS NOT INITIAL.

  SELECT matnr
         werks
         lgort
         labst
    FROM mard INTO TABLE it_mard
    FOR ALL ENTRIES IN it_marc
    WHERE matnr = it_marc-matnr.
ENDIF.
IF sy-subrc = 0.
  SORT it_mard BY matnr.
ELSE.
  MESSAGE 'Data not found in table Mard' TYPE 'I'.
ENDIF.

LOOP AT it_mara into wa_mara.
wa_final-matnr = wa_mara-matnr.
wa_final-mtart = wa_mara-mtart.
wa_final-mbrsh = wa_mara-mbrsh.

READ TABLE it_marc into wa_marc with key wa_mara-matnr BINARY SEARCH.
wa_final-werks = wa_marc-werks.
 wa_final-pstat = wa_marc-pstat.

 READ TABLE it_mard into wa_mard with key wa_marc-matnr BINARY SEARCH.
 wa_final-lgort = wa_mard-lgort.
 wa_final-labst = wa_mard-labst.

 append wa_final to it_final.
 clear: wa_final, wa_mara, wa_marc, wa_mard.
 ENDLOOP.


LOOP AT it_final INTO wa_final.
write:/ wa_final-matnr,
        wa_final-mtart,
        wa_final-mbrsh,
        wa_final-werks,
        wa_final-pstat,
        wa_final-lgort,
        wa_final-labst.
        ENDLOOP.
