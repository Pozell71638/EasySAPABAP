*&---------------------------------------------------------------------*
*& Report ZPK_INTERACTIVE_CW1_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INTERACTIVE_CW1_1.

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         netwr TYPE vbak-netwr,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ty_vbap.

TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         matkl TYPE mara-matkl,
       END OF ty_mara.


DATA: it_vbak TYPE STANDARD TABLE OF ty_vbak,
      it_vbap TYPE STANDARD TABLE OF ty_vbap,
      it_mara TYPE STANDARD TABLE OF ty_mara,

      wa_vbak TYPE ty_vbak,
      wa_vbap TYPE ty_vbap,
      wa_mara TYPE ty_mara.

DATA: var TYPE vbak-vbeln.

DATA: fld  TYPE char255,
      val  TYPE vbeln,
      fld1 TYPE char255, " wa_mara-matnr = 000000000000000020
      val1 TYPE matnr.

SELECTION-SCREEN: BEGIN OF BLOCK ash1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR var.
SELECTION-SCREEN: END OF BLOCK ash1.

START-OF-SELECTION.
  SELECT vbeln
          netwr
          vkorg
          vtweg
          spart
     FROM vbak INTO TABLE it_vbak WHERE
   vbeln IN s_vbeln.

  SORT it_vbap BY vbeln.

  LOOP AT it_vbak INTO wa_vbak.
    WRITE:/01(10) wa_vbak-vbeln,
           11(21) wa_vbak-netwr,
           33(05) wa_vbak-vkorg,
           39(05) wa_vbak-vtweg,
           45(05) wa_vbak-spart.
  ENDLOOP.


*------------------------------------------------------------
AT LINE-SELECTION.

  IF it_vbak IS NOT INITIAL.
    GET CURSOR FIELD fld VALUE val.
    IF fld = 'WA_VBAK-VBELN'.
      IF NOT val IS INITIAL.


        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input  = val
          IMPORTING
            output = val.

        SELECT      vbeln        " VAL = VBELN
                    posnr
                    matnr
                    arktx
             FROM vbap INTO TABLE it_vbap WHERE vbeln = val.

        LOOP AT  it_vbap INTO wa_vbap.
          WRITE:/ wa_vbap-vbeln,
                  wa_vbap-posnr,
                  wa_vbap-matnr,
                  wa_vbap-arktx.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.

*---------------------------------------------------------
IF it_vbap IS NOT INITIAL.
      GET CURSOR FIELD fld1 VALUE val1.
      IF fld1 = 'WA_VBAP-MATNR'.
        IF NOT val1 IS INITIAL.

 CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input         = VAL1
         IMPORTING
           OUTPUT        = VAL1.

SELECT matnr
         mtart
         mbrsh
         matkl
  FROM mara INTO TABLE it_mara
  WHERE matnr = val1.

           LOOP AT it_mara INTO wa_mara.
    WRITE:/ wa_mara-matnr,
            wa_mara-mtart,
            wa_mara-mbrsh,
            wa_mara-matkl.
  ENDLOOP.

endif.
endif.
endif.
