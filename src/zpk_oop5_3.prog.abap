*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_3.
* oops alv
data: o_cust type ref to cl_gui_custom_container,
      o_alv  type ref to  cl_gui_alv_grid.

data: it_mara type STANDARD TABLE OF mara,
      wa_mara type mara.

select-OPTIONS: s_matnr for wa_mara-matnr.

select * from mara into table it_mara where matnr in s_matnr.

* bcz of useing executable program we have to write a special keyword " call screen XXXX."

call screen 4610.
*&---------------------------------------------------------------------*
*& Module STATUS_4610 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4610 OUTPUT.
 SET PF-STATUS 'GUI_4610'.
* SET TITLEBAR 'xxx'.

 CREATE OBJECT o_cust " it provides the space for displaying the data
   EXPORTING

     container_name              = 'CUST_AA1'.

  CREATE OBJECT o_alv " it is used to display the data on the container
    EXPORTING

      i_parent          = o_cust.

CALL METHOD o_alv->set_table_for_first_display
  EXPORTING
*    i_buffer_active               =
*    i_bypassing_buffer            =
*    i_consistency_check           =
    i_structure_name               = 'MARA'
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
  CHANGING
    it_outtab                     = it_mara
*    it_fieldcatalog               =
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4
        .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.



ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4610  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4610 INPUT.
CASE SY-UCOMM.
  WHEN 'BACK' .
    LEAVE TO SCREEN 0." TO COME BACK TO PREVIOUS SCREEN
  WHEN 'EXIT'.
    LEAVE PROGRAM." TO TERMINATE A COME OUT OF THE PROGRAM
  WHEN 'CANCEL'.
    LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
