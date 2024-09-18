*&---------------------------------------------------------------------*
*& Report ZPK_OOP1_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP1_1.


PARAMETERS:p_num1 TYPE int4,
           p_num2 TYPE int4.
DATA:gv_sum TYPE int4.
*&---------------------------------------------------------------------*
*& Class lcl_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION FINAL.
  PUBLIC SECTION.
  METHODS:
  sum_numbers.


ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) lcl_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_main IMPLEMENTATION.

  METHOD sum_numbers.
    gv_sum = p_num1 + p_num2.
  ENDMETHOD.
ENDCLASS.

DATA: go_main TYPE REF TO lcl_main.

START-OF-SELECTION.
CREATE OBJECT go_main.
go_main->sum_numbers( ).
write: 'Total:', gv_sum.
