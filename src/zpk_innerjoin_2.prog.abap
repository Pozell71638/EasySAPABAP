*&---------------------------------------------------------------------*
*& Report ZPK_INNERJOIN_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_innerjoin_2.
**EKKO&EKPO
*
*
*TYPES: BEGIN OF ty_final,
*         ebeln    TYPE ekko-ebeln,
*         bukrs    TYPE ekko-bukrs,
*         bstyp    TYPE ekko-bstyp,
*         ebelp    TYPE ekpo-ebelp,
*         uniqueid TYPE ekpo-uniqueid,
*         loekz    TYPE ekpo-loekz,
*       END OF ty_final.
*
*DATA: it_final TYPE STANDARD TABLE OF ty_final,
*      wa_final TYPE ty_final.
*
*DATA: var TYPE ekko-ebeln.
*
*SELECT-OPTIONS: s_ebeln FOR var.
*
*SELECT ebeln
*       bukrs
*       bstyp
**       ebelp
**      uniqueid
**       loekz
*  FROM ekko INTO TABLE it_final
*  WHERE ebeln IN s_ebeln.
*
*IF sy-subrc = 0.
*  SORT it_final BY ebeln.
*ELSE.
*  MESSAGE 'data not found' TYPE 'I'.
*ENDIF.
*
*LOOP AT it_final INTO wa_final.
*  WRITE:/ wa_final-ebeln,
*          wa_final-bukrs,
*          wa_final-bstyp,
*          wa_final-ebelp.
*ENDLOOP.
************************************************************************
*                                                                      *
************************************************************************
*LIKP&LIPS




TYPES: BEGIN OF ty_final,
         vbeln TYPE likp-vbeln,
         ernam TYPE likp-ernam,
         erzet TYPE likp-erzet,
         erdat TYPE likp-erdat,
         posnr TYPE lips-posnr,
         pstyv TYPE lips-pstyv,
       END OF ty_final.

DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: var TYPE likp-vbeln.

SELECT-OPTIONS: s_vbeln FOR var.

SELECT vbeln
       ernam
       erzet
       erdat
*       posnr
*     pstyv
  FROM likp INTO TABLE it_final
  WHERE vbeln IN s_vbeln.

IF sy-subrc = 0.
  SORT it_final BY vbeln.
ELSE.
  MESSAGE 'data not found' TYPE 'I'.
ENDIF.

LOOP AT it_final INTO wa_final.
  WRITE:/ wa_final-vbeln,
          wa_final-ernam,
          wa_final-posnr,
          wa_final-pstyv.
ENDLOOP.
