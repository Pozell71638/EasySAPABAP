*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_4.
data: o_cust type ref to cl_gui_custom_container,
      o_alv  type ref to cl_gui_alv_grid.

data: itab TYPE STANDARD TABLE OF mara,
      wa   type mara.

select-OPTIONS: s_matnr for wa-matnr.

select * from mara into table itab
  where matnr in s_matnr.

call screen 4611. " Ilk olarak call screen numarasina tikliyoruz ve pbo ve pai deki commentleri kaldiriyoruz.
*&---------------------------------------------------------------------*
*& Module STATUS_4611 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*-----------------------------------------------*
*& Module STATUS_4611 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_4611 OUTPUT.

 SET PF-STATUS 'GUI_4611'." bu kismi en son yaptik ve tiklayinca ucuncuye "back" ve "cancel"  olarak yazdik
* SET TITLEBAR 'xxx'.

  CREATE OBJECT o_cust  " ASSIGNING MEMORY BY CALLING THE APTTERN 'CREATE OBJECT ' OPTION. pattern e tikladik ve abap create object e tiklayrak yaptik
    EXPORTING
      container_name    = 'CUST_AA1'. "buraya olusturdugumuy layout un adini koyduk.


  CREATE OBJECT o_alv  " ASSIGNING MEMORY BY CALLING THE APTTERN 'CREATE OBJECT ' OPTION
    EXPORTING
      i_parent          = o_cust.



  CALL METHOD o_alv->set_table_for_first_display  " CALLING THE METHODUSING 'CALL METHOD ' OPTION. pattern a tiklayarak call method a yukardaki instance ve class isimleini yazdik.
  " sonrasinda set_table* diyip method aradik ve bu methodu bulduk.
    EXPORTING
      i_structure_name              = 'MARA'
    CHANGING
      it_outtab                     = ITAB.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_4611  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_4611 INPUT.
CASE SY-UCOMM.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
      ENDCASE.
ENDMODULE.
