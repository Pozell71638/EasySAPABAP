@EndUserText.label: 'CDS with Table Function'
define table function ZPK_DDL_CW20
with parameters @Environment.systemField: #CLIENT
                i_mandt : s_mandt,
                i_name  : s_carrname
returns {
  mandt    : s_mandt;
  CARRID   : s_carr_id;
  CARRNAME : s_carrname;
  CURRCODE : s_currcode;
  URL      : s_carrurl ;
  
}
implemented by method zpk_cl_amdp_d_ex02=>amdp_function;
