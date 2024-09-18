*&---------------------------------------------------------------------*
*& Report ZPK_FAE_CW3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_fae_cw3.

************************************************************************
*   VBAK-VBELN, VKORG,VTWEG SPART - FIRST TABLE
*vbap ;vbeln,posnr,matnr, arktx, SECOND TABLE

*mara ;matnr,matkl, mbrsh,THIRD table


*select options VBAK-VBELN,

*hide:matnr value

*+VBAP-VBELN( JOING FIELD BETWEEN VBAK & VBAP), POSNR,MATNR
*+MARA- MATNR, MATKL,MBRSH (THIRD TABLE INTERACTIVE PART)

*FIRST LOOP VBAP
*READ TABLE VBAK                                                                   *
************************************************************************

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


TYPES: BEGIN OF ts_mara,
         matnr TYPE mara-matnr,
         mbrsh TYPE mara-mbrsh,
         matkl TYPE mara-matkl,
       END OF ts_mara.


TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         kunnr TYPE vbak-kunnr,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ty_final.


DATA: it_vbak  TYPE STANDARD TABLE OF ts_vbak,
      it_vbap  TYPE STANDARD TABLE OF ts_vbap,
      it_mara  TYPE STANDARD TABLE OF ts_mara,
      it_final TYPE STANDARD TABLE OF ty_final,

      wa_final TYPE ty_final,
      wa_vbak  TYPE ts_vbak,
      wa_vbap  TYPE ts_vbap,
      wa_mara  TYPE ts_mara.

DATA: var TYPE vbak-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.






*SELECT a~vbeln
*       a~vkorg
*       a~vtweg
*       a~spart
*       a~kunnr
*       b~posnr
*       b~matnr
*       b~arktx
*  INTO TABLE it_vbak
*  FROM vbak as a INNER JOIN vbap as b on a~vbeln = b~vbeln
*  WHERE vbeln IN s_vbeln.
*
*IF sy-subrc = 0.
*  SORT it_vbak BY vbeln.
*ELSE.
*  MESSAGE 'Data not fount in table vbak' TYPE 'I'.
*ENDIF.

SELECT vbeln
       vkorg
       vtweg
       spart
       kunnr
  FROM vbak INTO TABLE it_vbak
  WHERE vbeln IN s_vbeln.

IF sy-subrc = 0.
  SORT it_vbak BY vbeln.
ELSE.
  MESSAGE 'Data not fount in table vbak' TYPE 'I'.
ENDIF.


IF it_vbak IS NOT INITIAL.
  SELECT vbeln
         posnr
         matnr
         arktx
    FROM vbap INTO TABLE it_vbap
    FOR ALL ENTRIES IN it_vbak
    WHERE vbeln = it_vbak-vbeln.
ENDIF.

IF sy-subrc = 0.
  SORT it_vbap BY vbeln.
ELSE.
  MESSAGE 'Data not fount in table vbap' TYPE 'I'.
ENDIF.


LOOP AT it_vbap INTO wa_vbap.
   wa_final-vbeln = wa_vbap-vbeln.
  wa_final-posnr = wa_vbap-posnr.
  wa_final-matnr = wa_vbap-matnr.
  wa_final-arktx = wa_vbap-arktx.
  READ TABLE it_vbak INTO wa_vbak WITH KEY wa_vbap-vbeln.

 wa_final-vbeln = wa_vbak-vbeln.
  wa_final-vkorg = wa_vbak-vkorg.
  wa_final-vtweg = wa_vbak-vtweg.
  wa_final-spart = wa_vbak-spart.
  wa_final-kunnr = wa_vbak-kunnr.
  APPEND wa_final TO it_final.
  CLEAR:wa_final,
        wa_vbak.
ENDLOOP.

LOOP AT it_final INTO wa_final.
  WRITE:/ wa_final-vbeln COLOR 1,
          wa_final-vkorg COLOR 2,
          wa_final-vtweg COLOR 3 ,
          wa_final-spart COLOR 5,
          wa_final-kunnr COLOR 6,
          wa_final-posnr COLOR 7,
          wa_final-matnr COLOR 1,
         wa_final-arktx COLOR 2.
  HIDE: wa_final-matnr.
ENDLOOP.

************************
*   we have triggered a detail list with the help of event  AT LINE-SELECTION.
************************

AT LINE-SELECTION.
  IF  sy-lsind = 1.

    SELECT matnr
           mbrsh
           matkl
      FROM mara INTO TABLE it_mara
      WHERE matnr = wa_final-matnr.

    IF sy-subrc = 0 .
      SORT it_mara BY matnr.
    ELSE.
      MESSAGE: 'Data not found in Table MARA' TYPE 'I'.

    ENDIF.

    LOOP AT it_mara INTO wa_mara.
      WRITE:/ wa_mara-matnr,
              wa_mara-mbrsh,
              wa_mara-matkl.

    ENDLOOP.
  ENDIF.
