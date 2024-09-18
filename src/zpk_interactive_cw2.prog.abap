*&---------------------------------------------------------------------*
*& Report ZPK_INTERACTIVE_CW2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INTERACTIVE_CW2.
************************************************************************
* first output- vbap- vbeln, posnr, matnr (select-options: vbap-vbeln)
* second output- vbak- vbeln, netwr, kunnr
* third output - kna1- kunnr, land1, name1
*
* fld1 type char255,
* fld2 type char255,
* val1 type vbeln,
* val2 type kunnr.
*
*
* fm- CONVERSION_EXIT_ALPHA_INPUT
* fm- CONVERSION_EXIT_ALPHA_INPUT

************************************************************************

TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         netwr TYPE vbak-netwr,
         kunnr TYPE vbak-kunnr,
       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
       END OF ty_vbap.

TYPES: BEGIN OF ty_kna1,
        kunnr TYPE kna1-kunnr,
        land1 TYPE kna1-land1,
        name1 TYPE kna1-name1,
      END OF ty_kna1.




DATA: it_vbak TYPE STANDARD TABLE OF ty_vbak,
      it_vbap TYPE STANDARD TABLE OF ty_vbap,
      it_kna1 TYPE STANDARD TABLE OF ty_kna1,

      wa_vbak TYPE ty_vbak,
      wa_vbap TYPE ty_vbap,
      wa_kna1 TYPE ty_kna1.

DATA: var TYPE vbap-vbeln.

DATA: fld1  TYPE char255,
      val1  TYPE vbeln,
      fld2 TYPE char255,
      val2 TYPE kunnr.

SELECTION-SCREEN: BEGIN OF BLOCK ash1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR var.
SELECTION-SCREEN: END OF BLOCK ash1.

START-OF-SELECTION.
  SELECT vbeln
         posnr
         matnr
     FROM vbap INTO TABLE it_vbap WHERE
   vbeln IN s_vbeln.

  SORT it_vbap BY vbeln.

  LOOP AT it_vbap INTO wa_vbap.
    WRITE:/01(10) wa_vbap-vbeln,
           11(21) wa_vbap-posnr,
           33(05) wa_vbap-matnr.

  ENDLOOP.


*------------------------------------------------------------
AT LINE-SELECTION.

  IF it_vbap IS NOT INITIAL.
    GET CURSOR FIELD fld1 VALUE val1.
    IF fld1 = 'WA_VBAP-VBELN'.
      IF NOT val1 IS INITIAL.


        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input  = val1
          IMPORTING
            output = val1.

        SELECT      vbeln
                    netwr
                    kunnr
             FROM vbak INTO TABLE it_vbak WHERE vbeln = val1.

        LOOP AT  it_vbak INTO wa_vbak.
          WRITE:/ wa_vbak-vbeln,
                  wa_vbak-netwr,
                  wa_vbak-kunnr.

        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.

*---------------------------------------------------------
IF it_vbak IS NOT INITIAL.
      GET CURSOR FIELD fld2 VALUE val2.
      IF fld2 = 'WA_VBAK-KUNNR'.
        IF NOT val2 IS INITIAL.

 CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input         = VAL2
         IMPORTING
           OUTPUT        = VAL2.

SELECT kunnr
       land1
       name1
  FROM kna1 INTO TABLE it_kna1
  WHERE kunnr = val2.

           LOOP AT it_kna1 INTO wa_kna1.
    WRITE:/ wa_kna1-kunnr,
            wa_kna1-land1,
            wa_kna1-name1.

  ENDLOOP.

endif.
endif.
endif.
