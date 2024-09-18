*&---------------------------------------------------------------------*
*& Report zreport_pk_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreport_pk_22.

SELECT * FROM ZCDS_PK_DDL_EX22 into TABLE @data(it_tab).

cl_salv_table=>factory(
  EXPORTING
    list_display   = if_salv_c_bool_sap=>false
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   =  data(lo_alv)
  CHANGING
    t_table        = it_Tab
).
*CATCH cx_salv_msg.

lo_alv->display( ).
