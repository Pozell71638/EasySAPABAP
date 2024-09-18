*&---------------------------------------------------------------------*
*& Report zreport_pk_amdp_soptions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreport_pk_amdp_soptions.

DATA : lv_carrid TYPE s_carrid ,
       lt_scarr TYPE STANDARD TABLE OF zcds_pk_ddl_ex21,
       lv_where TYPE string .

SELECT-OPTIONS : s_carrid for lv_carrid .

* Here is the data capturing from the select options as a string("Conversion of the selection tables into an SQL WHERE clause using method")
lv_where = cl_shdb_seltab=>combine_seltabs( EXPORTING
                                                IT_NAMED_SELTABS = VALUE #(  ( name = 'CARRID' dref = ref #( s_carrid[] ) ) )
                                                IV_CLIENT_FIELD  = 'MANDT' ).

* fetching the data from CDS view using lv_where string values
SELECT * from zcds_pk_ddl_ex21( sel_opt_carrid = @lv_where  )  into TABLE @lt_scarr .


cl_salv_table=>factory(
  EXPORTING
    list_display   = if_salv_c_bool_sap=>false
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   = DATA(lo_alv)
  CHANGING
    t_table        = lt_scarr
).
*CATCH cx_salv_msg.

lo_alv->display( ).
