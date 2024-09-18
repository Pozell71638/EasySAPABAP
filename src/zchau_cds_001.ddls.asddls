

@EndUserText.label: 'CDS with Table Function'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE

define table function zchau_cds_001 with parameters
@Environment.systemField:#CLIENT 
p_date: mandt

returns {
  key CLIENT     : abap.clnt;
  key RBUKRS     : bukrs;
  key DOC_NUM    : belnr_d;
  key GJAHR      : gjahr;
  key DOCLN      : docln6;
      RACCT      : racct;
      RCNTR      : kostl;
      PRCTR      : prctr;
}
implemented by method ZCL_DEMO_AMDP=>GET_ACDOCA;

//https://community.sap.com/t5/technology-blogs-by-members/consume-cds-view-inside-cds-table-function-by-using-amdp/ba-p/13565733
