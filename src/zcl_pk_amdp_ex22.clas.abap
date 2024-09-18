CLASS zcl_pk_amdp_ex22 DEFINITION PUBLIC.

 PUBLIC SECTION .
   INTERFACES if_amdp_marker_hdb .

  CLASS-METHODS amdp_function FOR table FUNCTION zcds_pk_ddl_ex21 .
ENDCLASS.



CLASS zcl_pk_amdp_ex22 IMPLEMENTATION.

METHOD amdp_function BY DATABASE FUNCTION
                     FOR HDB
                     LANGUAGE SQLSCRIPT
                     OPTIONS READ-ONLY
                     using scarr .

  lt_scarr = apply_filter ( scarr, :sel_opt_carrid ) ;

  RETURN select mandt, carrid, carrname, currcode, url
                from :lt_scarr;

endmethod.

ENDCLASS.

