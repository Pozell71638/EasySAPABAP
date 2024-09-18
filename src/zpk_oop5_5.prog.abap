*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_5.
TYPES:BEGIN OF TY_MARA,
      MATNR TYPE MARA-MATNR,
      MTART TYPE MARA-MTART,
      MEINS TYPE MARA-MEINS,
      END OF TY_MARA.

DATA: IT_MARA TYPE STANDARD TABLE OF TY_MARA,
      WA_MARA TYPE TY_MARA.

DATA: O_CUST TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
      O_ALV  TYPE REF TO CL_GUI_ALV_GRID.

DATA: IT_FCAT TYPE LVC_T_FCAT,  " WE NEED TO CREATE IT WHEN WE HAVE FEW FIELDS TO DISPLAY
      WA_FCAT TYPE LVC_S_FCAT.

SELECT-OPTIONS: S_MATNR FOR WA_MARA-MATNR.

SELECT MATNR MTART MEINS FROM MARA INTO TABLE IT_MARA
  WHERE MATNR IN S_MATNR.

 CALL SCREEN 4612 .
*&---------------------------------------------------------------------*
*& Module STATUS_4612 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4612 OUTPUT.
 SET PF-STATUS 'GUI_4612'. " En son yaptik tiklayip ucuncuye back ve cancel butonlarini ekledik
* SET TITLEBAR 'xxx'.


CREATE OBJECT o_cust
  EXPORTING
*    parent                      =
    container_name              = 'CUST_AA02'.
*    style                       =
*    lifetime                    = lifetime_default
*    repid                       =
*    dynnr                       =
*    no_autodef_progid_dynnr     =
*  EXCEPTIONS
*    cntl_error                  = 1
*    cntl_system_error           = 2
*    create_error                = 3
*    lifetime_error              = 4
*    lifetime_dynpro_dynpro_link = 5
*    others                      = 6
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CREATE OBJECT o_alv
  EXPORTING
*    i_shellstyle      = 0
*    i_lifetime        =
    i_parent          = o_cust.
*    i_appl_events     = SPACE
*    i_parentdbg       =
*    i_applogparent    =
*    i_graphicsparent  =
*    i_name            =
*    i_fcat_complete   = SPACE
*    o_previous_sral_handler =
*  EXCEPTIONS
*    error_cntl_create = 1
*    error_cntl_init   = 2
*    error_cntl_link   = 3
*    error_dp_create   = 4
*    others            = 5
    .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

*  Populate Field Catalog
  PERFORM GET_FIELDCATALOG. " THIS HAS TO BE CREATED SINCE LIMITED FIELDS ARE REQUIRED

  CALL METHOD o_alv->set_table_for_first_display
*    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    =
*      i_save                        =
*      i_default                     = 'X'
*      is_layout                     =
*      is_print                      =
*      it_special_groups             =
*      it_toolbar_excluding          =
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = it_mara
      it_fieldcatalog               = it_fcat
*      it_sort                       =
*      it_filter                     =
*    EXCEPTIONS
*      invalid_parameter_combination = 1
*      program_error                 = 2
*      too_many_lines                = 3
*      others                        = 4
          .
  IF sy-subrc <> 0.
*   Implement suitable error handling here
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4612  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4612 INPUT.
CASE SY-UCOMM.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form GET_FIELDCATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fieldcatalog .
WA_FCAT-col_pos = 1.
WA_FCAT-fieldname = 'MATNR'.
WA_FCAT-tabname   = 'IT_MARA'.
WA_FCAT-scrtext_m = 'Material Number'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-col_pos = 2.
WA_FCAT-fieldname = 'MTART'.
WA_FCAT-tabname   = 'IT_MARA'.
WA_FCAT-scrtext_m = 'Material TYPE'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

WA_FCAT-col_pos = 3.
WA_FCAT-fieldname = 'MEINS'.
WA_FCAT-tabname   = 'IT_MARA'.
WA_FCAT-scrtext_m = 'Material Base Unit'.
APPEND WA_FCAT TO IT_FCAT.
CLEAR WA_FCAT.

ENDFORM.
