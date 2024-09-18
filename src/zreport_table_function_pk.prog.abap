*&---------------------------------------------------------------------*
*& Report zreport_table_function_pk
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreport_table_function_pk.

PARAMETERS : p_name TYPE S_CARRNAME .

SELECT * FROM ZPK_DDL_CW20( i_name = @p_name ) INTO TABLE @data(lt_scarr).


cl_salv_table=>factory(
  EXPORTING
    list_display   = if_salv_c_bool_sap=>false
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   =  data(lo_alv)
  CHANGING
    t_table        = lt_scarr
).
*CATCH cx_salv_msg.


lo_alv->display(  ).
