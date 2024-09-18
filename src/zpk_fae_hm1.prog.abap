*&---------------------------------------------------------------------*
*& Report ZPK_FAE_HM1
*&---------------------------------------------------------------------*
*&Tables: VBAK, VBAP, KNA1
*KNA1--(KUNNR)--VBAK--(VBELN)-- VBAP

*select-options on vbak-vbeln

*fields to be selected ( vbak- vbeln, vkorg,vtweg, spart, KUNNR)
*                     ( vbap- vbeln, posnr, matnr, arktx )
*                     ( kna1- kunnr,LAND1, name1, ort01)

*FIRST LOOP ON VBAP
*FIRST READ TABLE ON VBAK with key on wa_vbap-vbeln
*Second Read Table on KNA1 with key on wa_vbak-kunnr
*endloop .
*&---------------------------------------------------------------------*
REPORT zpk_fae_hm1.
TYPES: BEGIN OF ts_vbak,
         vbeln TYPE vbak-vbeln,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         kunnr TYPE vbak-kunnr,
       END OF ts_vbak.


TYPES: BEGIN OF ts_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ts_vbap.


TYPES: BEGIN OF ts_kna1,
         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,
       END OF ts_kna1.

TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         kunnr TYPE vbak-kunnr,

         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,

         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,
       END OF ty_final.

DATA: it_vbak  TYPE STANDARD TABLE OF ts_vbak,
      it_vbap  TYPE STANDARD TABLE OF ts_vbap,
      it_kna1  TYPE STANDARD TABLE OF ts_kna1,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_vbak  TYPE ts_vbak,
      wa_vbap  TYPE ts_vbap,
      wa_kna1  TYPE ts_kna1,
      wa_final TYPE ty_final.



DATA:var TYPE vbak-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT vbeln vkorg vtweg spart kunnr
FROM vbak INTO TABLE it_vbak
  WHERE vbeln IN s_vbeln.

IF sy-subrc = 0.
  SORT it_vbak BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Mara' TYPE 'I'.
ENDIF.
************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT vbeln posnr matnr arktx

  FROM vbap INTO TABLE it_vbap    FOR ALL ENTRIES IN it_vbak    WHERE vbeln = it_vbak-vbeln.
ENDIF.

IF sy-subrc = 0.
  SORT it_vbap BY vbeln.
ELSE.
  MESSAGE 'Data not found in table Marc' TYPE 'I'.
ENDIF.

************************************************************************
*                                                                      *
************************************************************************


IF it_vbak IS NOT INITIAL.

  SELECT kunnr land1 name1 ort01

    FROM kna1 INTO TABLE it_kna1  FOR ALL ENTRIES IN it_vbak   WHERE kunnr = it_vbak-kunnr.
ENDIF.
IF sy-subrc = 0.
  SORT it_kna1 BY kunnr.
ELSE.
  MESSAGE 'Data not found in table Mard' TYPE 'I'.
ENDIF.



LOOP AT it_vbap INTO wa_vbap.
  wa_final-vbeln = wa_vbap-vbeln.
  wa_final-posnr = wa_vbap-posnr.
  wa_final-matnr = wa_vbap-matnr.
  wa_final-arktx  = wa_vbap-arktx.
  READ TABLE it_vbak INTO wa_vbak WITH KEY wa_vbap-vbeln BINARY SEARCH.

  wa_final-vkorg = wa_vbak-vkorg.
  wa_final-vtweg = wa_vbak-vtweg.
  wa_final-spart = wa_vbak-spart.
  wa_final-kunnr = wa_vbak-kunnr.
  READ TABLE it_kna1 INTO wa_kna1 WITH KEY wa_vbak-kunnr BINARY SEARCH.

  wa_final-land1 = wa_kna1-land1.
  wa_final-name1 = wa_kna1-name1.
  wa_final-ort01 = wa_kna1-ort01.


  APPEND wa_final TO it_final.
  CLEAR: wa_final, wa_vbak, wa_vbap, wa_kna1.
ENDLOOP.


LOOP AT it_final INTO wa_final.
  WRITE:/ wa_final-vbeln COLOR 1,
          wa_final-posnr COLOR 2,
          wa_final-matnr COLOR 3,
          wa_final-vtweg COLOR 4,
          wa_final-kunnr COLOR 5,
          wa_final-land1 COLOR 6,
          wa_final-name1 COLOR 7,
          wa_final-ort01 COLOR 1.
ENDLOOP.
