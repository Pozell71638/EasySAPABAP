@EndUserText.label: 'table function for select option-amdp'
define table function ZCDS_PK_DDL_EX21
with parameters sel_opt_carrid : abap.char( 1000 )
returns {
  mandt    : s_mandt ;
  carrid   : s_carr_id ;
  carrname : s_carrname ;
  currcode : s_currcode ;
  url      : s_carrurl ;
  
}
implemented by method zcl_pk_amdp_ex22=>amdp_function;
