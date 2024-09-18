*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION1.
SELECT carrid,
       connid,
       countryfr,
       countryto
       from spfli
       INTO TABLE @DATA(lt_spfli) UP TO 100 ROWS .
  TRY.
CALL METHOD cl_salv_table=>factory
  EXPORTING
    list_display   = IF_SALV_C_BOOL_SAP=>FALSE
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   = DATA(lo_alv_new)                    " Instantiation with new inline declaration
  CHANGING
    t_table        = lt_spfli
    .
  CATCH cx_salv_msg.
ENDTRY.

* Displaying our own Title while displaying the ALV output
DATA(lo_display) = lo_alv_new->get_display_settings( ).
lo_display->set_list_header( 'Output of new Select Query Syntax' ) .



lo_alv_new->display( ).
