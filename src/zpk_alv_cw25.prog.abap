*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW25.

*----Declaration of type pools for ALV slis----------------------------*
TYPE-POOLS: slis.

*------Declaration of internal table structures------------------------*
TYPES: BEGIN OF ty_mara,
        matnr TYPE mara-matnr,
        mtart TYPE mara-mtart,
        mbrsh TYPE mara-mbrsh,
        matkl TYPE mara-matkl,
        expand,               "Expand operation on header list
       END OF ty_mara,

       BEGIN OF ty_makt,
        matnr TYPE makt-matnr,
        spras TYPE makt-spras,
        maktx TYPE makt-maktx,
      END OF ty_makt.

DATA: var type mara-matnr," variable for select-opion
      "Internal tables
      it_mara TYPE TABLE OF ty_mara,
      it_makt TYPE TABLE OF ty_makt,

      "Field catalog work area & tables
      wa_fcat TYPE slis_fieldcat_alv,
      it_fcat TYPE slis_t_fieldcat_alv,

      "ALV layout work area
      wa_layout TYPE slis_layout_alv,

      "Key information for hierarchical list
      wa_key TYPE slis_keyinfo_alv.

*------Event Initialization--------------------------------------------*
INITIALIZATION.
  SELECT-OPTIONS: s_matnr for var.

*-----Event Start of Selection-----------------------------------------*
START-OF-SELECTION.
  PERFORM get_mara.
  PERFORM get_makt.
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
FORM get_mara .
select  matnr
        mtart
        mbrsh
        matkl
  from mara into table it_mara
  where matnr in s_matnr.

  IF sy-subrc = 0.
      SORT it_mara.
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
FORM get_makt .
  if it_mara is not INITIAL.
select matnr spras maktx
  from makt into table it_makt
  FOR ALL ENTRIES IN it_mara
  where matnr = it_mara-matnr.

   IF sy-subrc = 0.
      SORT it_makt.
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
 wa_fcat-col_pos   = 1.
    wa_fcat-fieldname = 'MATNR'.
    wa_fcat-tabname   = 'IT_MARA'.
    wa_fcat-seltext_l = 'Material ID'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

     wa_fcat-col_pos   = 2.
    wa_fcat-fieldname = 'MTART'.
    wa_fcat-tabname   = 'IT_MARA'.
    wa_fcat-seltext_l = 'Material type'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

     wa_fcat-col_pos   = 3.
    wa_fcat-fieldname = 'MBRSH'.
    wa_fcat-tabname   = 'IT_MARA'.
    wa_fcat-seltext_l = 'Industry Sector'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

     wa_fcat-col_pos   = 4.
    wa_fcat-fieldname = 'MATKL'.
    wa_fcat-tabname   = 'IT_MARA'.
    wa_fcat-seltext_l = 'Material Group'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""
    wa_fcat-col_pos   = 1.
    wa_fcat-fieldname = 'MATNR'.
    wa_fcat-tabname   = 'IT_MAKT'.
    wa_fcat-seltext_l = 'Material ID '.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

     wa_fcat-col_pos   = 2.
    wa_fcat-fieldname = 'SPRAS'.
    wa_fcat-tabname   = 'IT_MAKT'.
    wa_fcat-seltext_l = 'Language Id'.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.

     wa_fcat-col_pos   = 3.
    wa_fcat-fieldname = 'MAKTX'.
    wa_fcat-tabname   = 'IT_MAKT'.
    wa_fcat-seltext_l = 'Material Desc '.
    APPEND wa_fcat TO it_fcat.
    CLEAR wa_fcat.
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
  wa_key-header01 = 'MATNR'. "Purchase Order number
  wa_key-item01   = 'MATNR'. "is the key for header & item table
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
   IF it_fcat IS NOT INITIAL.
    CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        is_layout          = wa_layout
        it_fieldcat        = it_fcat
        i_tabname_header   = 'IT_MARA'
        i_tabname_item     = 'IT_MAKT'
        is_keyinfo         = wa_key
      TABLES
        t_outtab_header    = it_MARA
        t_outtab_item      = it_MAKT
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
      MESSAGE 'Internal Error' TYPE 'I'.
    ENDIF.
  ENDIF.
ENDFORM.
