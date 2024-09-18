*&---------------------------------------------------------------------*
*& Report zreport_amdp_delivery
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zreport_amdp_delivery.

PARAMETERS : p_vbeln TYPE vbeln .

* Calling AMDP Method
  zcl_amdp_delivery=>get_delivery(
    EXPORTING
      iv_vbeln = p_vbeln
    IMPORTING
      et_delivery = DATA(lt_delivery)
  ).

  if lt_delivery is not INITIAL .
  cl_demo_output=>display_data(  value   =  lt_delivery
                                 name    = 'Delivery Details' ).
  endif .
