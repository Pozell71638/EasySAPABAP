CLASS zcl_demo_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    CLASS-METHODS:
      get_acdoca     FOR TABLE FUNCTION zchau_cds_001.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_demo_amdp IMPLEMENTATION.
  METHOD get_acdoca BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zchau_acdoca.
    RETURN SELECT _raw.mandt as client,
            _raw.bukrs as rbukrs,
            _raw.belnr as doc_num,
            _raw.gjahr as gjahr,
            _raw.docln as docln,
            _raw.RACCT as RACCT,
            _raw.RCNTR as RCNTR,
            _raw.PRCTR as PRCTR
     from zchau_acdoca as _raw;
  endmethod.

ENDCLASS.
