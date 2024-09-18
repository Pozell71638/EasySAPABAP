CLASS zpk_cl_amdp_d_ex02 DEFINITION PUBLIC.

  PUBLIC SECTION.

  INTERFACES if_amdp_marker_hdb .

  CLASS-METHODS amdp_function FOR TABLE FUNCTION ZPK_DDL_CW20 .

ENDCLASS.



CLASS zpk_cl_amdp_d_ex02 IMPLEMENTATION .

METHOD amdp_function BY DATABASE FUNCTION
                     FOR HDB
                     LANGUAGE SQLSCRIPT
                     OPTIONS READ-ONLY
                     USING scarr .

      RETURN SELECT mandt, carrid, carrname, currcode, url from scarr
             WHERE mandt = :i_mandt and
             CONTAINS (carrname, :i_name, FUZZY(0.4));


endmethod.

ENDCLASS.
