*&---------------------------------------------------------------------*
*& Report ZPK_REDUCE_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_REDUCE_DEMO.


TYPES : BEGIN OF ty_str ,
         comp1 TYPE i ,
         comp2 TYPE string ,
        END OF ty_str ,

        tty_str TYPE STANDARD TABLE OF ty_str WITH DEFAULT KEY .

DATA : lt_tab TYPE STANDARD TABLE OF ty_str ,
       ls_tab TYPE ty_str .

* Here # is used because we already declared the lt_tab in the declaration section using DATA keyword
lt_tab = VALUE #(
                  ( comp1 = 1 comp2 = 'Name1' )
                  ( comp1 = 2 comp2 = 'Name2' )
                  ( comp1 = 3 comp2 = 'Name3' )
                  ( comp1 = 4 comp2 = 'Name4' )
                 ).

cl_demo_output=>write( '******************************************** Internal Table *****************' ) .

cl_demo_output=>write( lt_tab ) .

cl_demo_output=>write( '********************* With OLD Loop and where ( COMP1 > 2 ) *****************' ) .

DATA : lv_cnt TYPE sy-index VALUE IS INITIAL .

LOOP AT lt_tab INTO ls_tab WHERE comp1 > 2.
  lv_cnt = lv_cnt + 1 .
ENDLOOP.

cl_demo_output=>write( lv_cnt ) .

cl_demo_output=>write( '********************* With Reduce operator for counting where ( COMP1 > 1 )  *****************' ) .

DATA(lv_count) = REDUCE int2( init i = 0 FOR ls_tab_tmp in lt_tab
                                         WHERE ( comp1 > 1 )
                                         NEXT i = i + 1 ) .

cl_demo_output=>write( lv_count ) .



cl_demo_output=>display( ) .
