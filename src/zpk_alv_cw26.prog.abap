*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW26
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw26.
*----Declaration of type pools for alv slis----------------------------*
TYPE-POOLS: slis.

*------Declaration of internal table structures------------------------*


TYPES: BEGIN OF ty_vbak,
         vbeln  TYPE vbak-vbeln,
         erdat  TYPE vbak-erdat,
         erzet  TYPE vbak-erzet,
         ernam  TYPE vbak-ernam,
         expand,              "Expand operation on header list
       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         matwa TYPE vbap-matwa,
       END OF ty_vbap.




DATA: var       type vbak-vbeln, " variable for select-opion
      "Internal tables
      it_vbak   TYPE TABLE OF ty_vbak,
      it_vbap   TYPE TABLE OF ty_vbap,

      "Field catalog work area & tables
      wa_fcat   TYPE slis_fieldcat_alv,
      it_fcat   TYPE slis_t_fieldcat_alv,

      "ALV layout work area
      wa_layout TYPE slis_layout_alv,

      "Key information for hierarchical list
      wa_key    TYPE slis_keyinfo_alv.

*------Event Initialization--------------------------------------------*
INITIALIZATION.
  SELECT-OPTIONS: s_vbeln for var.

*-----Event Start of Selection-----------------------------------------*
START-OF-SELECTION.
  PERFORM get_vbak.
  PERFORM get_vbap.
  PERFORM field_catalog.

  PERFORM alv_layout.
  PERFORM key_info.
  PERFORM alv_hierseq_list_display.
*&---------------------------------------------------------------------*
*& Form get_mara
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_vbak .
  select  vbeln
          erdat
          erzet
          ernam
    from vbak into table it_vbak
    where vbeln in s_vbeln.

  IF sy-subrc = 0.
    SORT it_vbak.
  ELSE.
    MESSAGE 'Mat ID doesn''t exist' TYPE 'I'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_makt
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_vbap .
  if it_vbak is not INITIAL.
    select vbeln
            posnr
            matnr
            matwa
      from vbap into table it_vbap
      FOR ALL ENTRIES IN it_vbak
      where vbeln = it_vbak-vbeln.

    IF sy-subrc = 0.
      SORT it_vbap.
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

*  """"""""""""""""""""""""""""""""""""""""""""""""""""""
FORM field_catalog .
  wa_fcat-col_pos   = 1.
  wa_fcat-fieldname = 'VBELN'.
  wa_fcat-tabname   = 'IT_VBAK'.
  wa_fcat-seltext_l = 'Sales Document'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 2.
  wa_fcat-fieldname = 'ERDAT'.
  wa_fcat-tabname   = 'IT_VBAK'.
  wa_fcat-seltext_l = 'Date on which the record was created'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 3.
  wa_fcat-fieldname = 'ERZET'.
  wa_fcat-tabname   = 'IT_VBAK'.
  wa_fcat-seltext_l = 'Entry time'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 4.
  wa_fcat-fieldname = 'ERNAM'.
  wa_fcat-tabname   = 'IT_VBAK'.
  wa_fcat-seltext_l = 'Name of Person Responsible for Creating the Object'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.



***********************************************************


  wa_fcat-col_pos   = 1.
  wa_fcat-fieldname = 'VBELN'.
  wa_fcat-tabname   = 'IT_VBAP'.
  wa_fcat-seltext_l = 'Sales Document'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 2.
  wa_fcat-fieldname = 'POSNR'.
  wa_fcat-tabname   = 'IT_VBAP'.
  wa_fcat-seltext_l = 'Sales Document Item'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 3.
  wa_fcat-fieldname = 'MATNR'.
  wa_fcat-tabname   = 'IT_VBAP'.
  wa_fcat-seltext_l = 'Material Number'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

  wa_fcat-col_pos   = 4.
  wa_fcat-fieldname = 'MATWA'.
  wa_fcat-tabname   = 'IT_VBAP'.
  wa_fcat-seltext_l = 'Material Entered'.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.


ENDFORM.
**&---------------------------------------------------------------------*
**& Form alv_layout
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
FORM alv_layout .
  wa_layout-zebra             = 'X'. "Zebra looks
  wa_layout-colwidth_optimize = 'X'. "Column width optimized
  wa_layout-expand_fieldname  = 'EXPAND'. "Expand operation
  wa_layout-window_titlebar   = 'Hierarchical PO Header & Item Display'.
ENDFORM.
**&---------------------------------------------------------------------*
**& Form key_info
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
FORM key_info .
  wa_key-header01 = 'VBELN'. "Purchase Order number
  wa_key-item01   = 'VBELN'. "is the key for header & item table
ENDFORM.
**&---------------------------------------------------------------------*
**& Form alv_hierseq_list_display
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**& -->  p1        text
**& <--  p2        text
**&---------------------------------------------------------------------*
FORM alv_hierseq_list_display .
   IF it_fcat IS NOT INITIAL.
    CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = wa_layout
        it_fieldcat        = it_fcat
        i_tabname_header   = 'IT_VBAK'
        i_tabname_item     = 'IT_VBAP'
        is_keyinfo         = wa_key
      TABLES
        t_outtab_header    = it_VBAK
        t_outtab_item      = it_VBAP
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      MESSAGE 'Internal Error' TYPE 'I'.
    ENDIF.
  ENDIF.
ENDFORM.
