CLASS zcl_amdp_delivery DEFINITION PUBLIC.

  PUBLIC SECTION.
*  Marker interface for Database Procedure
   INTERFACES IF_AMDP_MARKER_HDB .


*  Structure
   TYPES : BEGIN OF ty_delivery ,
            vbeln      TYPE vbeln ,   " Sales Order Number
            posnr      TYPE posnr_va, " Item Number
            vkorg      TYPE vkorg ,   " Sales Org
            Item_price TYPE netwr_ap, " Item Price

           END OF TY_delivery ,

           tt_delivery TYPE STANDARD TABLE OF ty_delivery WITH EMPTY KEY .

* Method Declaration
CLASS-METHODS get_delivery
       IMPORTING
          VALUE(iv_vbeln) TYPE vbeln
       EXPORTING
           VALUE(et_delivery) TYPE tt_delivery .

ENDCLASS.


CLASS zcl_amdp_delivery IMPLEMENTATION.

METHOD get_delivery BY DATABASE PROCEDURE
                 FOR HDB
                 LANGUAGE SQLSCRIPT
                 OPTIONS READ-ONLY
                 USING likp lips .

* To Get delivery

 et_delivery =  SELECT likp.vbeln,
                     lips.posnr,
                     likp.vkorg,
                     lips.netwr as item_price
                     FROM likp as likp
                     INNER JOIN lips as lips
                     on likp.vbeln = lips.vbeln
                     where likp.vbeln = iv_vbeln ;


ENDMETHOD.

ENDCLASS.

