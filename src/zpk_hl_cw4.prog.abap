*&---------------------------------------------------------------------*
*& Report ZPK_HL_CW4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_HL_CW4.



TYPE-POOLS: slis.
TYPES: BEGIN OF ty_likp,
        vbeln TYPE likp-vbeln,
        ernam TYPE likp-ernam,
        vkorg TYPE likp-vkorg,
        lfart TYPE likp-lfart,
  expand,
      END OF ty_likp.


TYPES: BEGIN OF ty_lips,
        vbeln TYPE lips-vbeln,
        posnr TYPE lips-posnr,
        matnr TYPE lips-matnr,
        matkl TYPE lips-matkl,
        werks TYPE lips-werks,
      END OF ty_lips.



DATA: var type likp-vbeln," variable for select-opion
*      Internal tables
      it_likp TYPE TABLE OF ty_likp,
      it_lips TYPE TABLE OF ty_lips,

*      Field catalog work area & tables
      wa_fcat TYPE slis_fieldcat_alv,
      it_fcat TYPE slis_t_fieldcat_alv,

*     ALV layout work area
      wa_layout TYPE slis_layout_alv,

*     Key information for hierarchical list
      wa_key TYPE slis_keyinfo_alv.

*------Event Initialization--------------------------------------------*
INITIALIZATION.
  SELECT-OPTIONS: s_vbeln FOR var.

*-----Event Start of Selection-----------------------------------------*
START-OF-SELECTION.
  PERFORM get_likp.
  PERFORM get_lips.
  PERFORM field_catalog.
*
  PERFORM alv_layout.
  PERFORM key_info.
  PERFORM alv_hierseq_list_display.


*&---------------------------------------------------------------------*
*& Form get_likp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_likp .
    SELECT vbeln
            ernam
            vkorg
            lfart
      FROM likp INTO TABLE it_likp
      WHERE vbeln IN s_vbeln.
*
    IF sy-subrc = 0.
      SORT it_likp.
    ELSE.
      MESSAGE 'DELIVERY HEADER DATA AND LAPS DELIVERY ITEM DATA doesn''t exist' TYPE 'I'.
    ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_lips
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_lips .
 IF it_likp IS NOT INITIAL.
    SELECT vbeln
            posnr
            matnr
            matkl
            werks
      FROM lips INTO TABLE it_lips
      FOR ALL ENTRIES IN it_likp
      WHERE vbeln = it_likp-vbeln.

    IF sy-subrc = 0.
      SORT it_lips.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form field_catalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*




FORM field_catalog .
  DATA lv_col TYPE i VALUE 0.

  IF it_likp IS NOT INITIAL.




    wa_fcat-col_pos   = 1.
    wa_fcat-fieldname = 'VBELN'.
    wa_fcat-tabname   = 'IT_LIKP'.
    wa_fcat-seltext_l = 'Delivery'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 2.
    wa_fcat-fieldname = 'ERNAM'.
    wa_fcat-tabname   = 'IT_LIKP'.
    wa_fcat-seltext_l = 'Name of Person Responsible for Creating the Object'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 3.
    wa_fcat-fieldname = 'VKORG'.
    wa_fcat-tabname   = 'IT_LIKP'.
    wa_fcat-seltext_l = 'Sales Organization'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 4.
    wa_fcat-fieldname = 'LFART'.
    wa_fcat-tabname   = 'IT_LIKP'.
    wa_fcat-seltext_l = 'Delivery Type'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


  ENDIF.


 IF it_lips IS NOT INITIAL.


    wa_fcat-col_pos   = 1.
    wa_fcat-fieldname = 'VBELN'.
    wa_fcat-tabname   = 'IT_LIPS'.
    wa_fcat-seltext_l = 'Delivery'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 2.
    wa_fcat-fieldname = 'POSNR'.
    wa_fcat-tabname   = 'IT_LIPS'.
    wa_fcat-seltext_l = 'Delivery Item'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 3.
    wa_fcat-fieldname = 'MATNR'.
    wa_fcat-tabname   = 'IT_LIPS'.
    wa_fcat-seltext_l = 'Material Number'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 4.
    wa_fcat-fieldname = 'MATKL'.
    wa_fcat-tabname   = 'IT_LIPS'.
    wa_fcat-seltext_l = 'Material Group'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.


    wa_fcat-col_pos   = 5.
    wa_fcat-fieldname = 'WERKS'.
    wa_fcat-tabname   = 'IT_LIPS'.
    wa_fcat-seltext_l = 'Plant'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form alv_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM alv_layout .
 wa_layout-zebra             = 'X'. "Zebra looks
  wa_layout-colwidth_optimize = 'X'. "Column width optimized
  wa_layout-expand_fieldname  = 'EXPAND'. "Expand operation
  wa_layout-window_titlebar   = 'Hierarchical PO Header & Item Display'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form key_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM key_info .
wa_key-header01 = 'VBELN'. "Purchase Order number
  wa_key-item01   = 'VBELN'. "is the key for header & item table
ENDFORM.
*&---------------------------------------------------------------------*
*& Form alv_hierseq_list_display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM alv_hierseq_list_display .
CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
  EXPORTING
*   I_INTERFACE_CHECK              = ' '
   I_CALLBACK_PROGRAM             = sy-repid
   IS_LAYOUT                      = wa_layout
   IT_FIELDCAT                    = it_fcat
    i_tabname_header               = 'IT_LIKP'
    i_tabname_item                 = 'IT_LIPS'
    is_keyinfo                     = wa_key
  TABLES
    t_outtab_header                = it_likp
    t_outtab_item                  = it_lips
* EXCEPTIONS
*   PROGRAM_ERROR                  = 1
*   OTHERS                         = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

ENDFORM.
