*&---------------------------------------------------------------------*
*& Report ZPK_COND_SWITCH_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_COND_SWITCH_DEMO.
TYPES : BEGIN OF ty_str ,
         id TYPE i ,
         mark TYPE string ,
         result TYPE string ,
         message TYPE string ,
        END OF ty_str .

DATA : lt_tab TYPE STANDARD TABLE OF ty_str INITIAL SIZE 0 ,
       lt_tab_1 TYPE STANDARD TABLE OF ty_str INITIAL SIZE 0 ,
       lt_tab1 TYPE STANDARD TABLE OF ty_str INITIAL SIZE 0 ,
       lt_tab2 TYPE STANDARD TABLE OF ty_str INITIAL SIZE 0 ,
       lt_tab3 TYPE STANDARD TABLE OF ty_str INITIAL SIZE 0 .

cl_demo_output=>write( '*********************** Internal Table with ID and Marks columns *********************************' ).

lt_tab = VALUE #(
                  ( id = 1 mark = 30 )
                  ( id = 2 mark = 60 )
                  ( id = 3 mark = 85 )
                  ( id = 4 mark = 20 )
                 ) .


cl_demo_output=>write( lt_Tab ) .
*cl_demo_output=>display( ) .

cl_demo_output=>write( '*********************** Using COND Operator updating Result column - based on Marks from the above table******************' ).


lt_tab1 = VALUE #( FOR ls_tab_tmp IN LT_TAB
                  (  id = ls_tab_tmp-id
                     mark = ls_Tab_tmp-mark
                     result = COND string( WHEN ls_tab_tmp-mark >= 40 and ls_tab_tmp-mark < 80 THEN 'PASS'
                                           WHEN ls_tab_tmp-mark >= 80 THEN 'PASS with distinction'
                                           ELSE 'FAIL' ) ) ).

cl_demo_output=>write( lt_tab1 ).

cl_demo_output=>write( '*********************** Using SWITCH Operator, updating Message Column- based on Result from the above table ***************' ).


lt_tab2 = VALUE #( FOR ls_tab1_tmp IN LT_TAB1
                  (  id = ls_tab1_tmp-id
                     mark = ls_tab1_tmp-mark
                     result = ls_tab1_tmp-result
                     message = SWITCH string( ls_tab1_tmp-result
                                           WHEN 'PASS' THEN 'Congratulations'
                                           WHEN 'PASS with distinction' THEN 'Congratulations'
                                           ELSE 'Try Again' ) ) ).

cl_demo_output=>write( lt_tab2 ).

cl_demo_output=>write( '*********************** Using COND Operator updating Result column - based on Marks from the above table******************' ).

lt_tab_1 = VALUE #(
                  ( id = 1 mark = 30 )
                  ( id = 2 mark = 85 )
                  ( id = 3 mark = 00 )
                  ( id = 4 mark = 20 )
                 ) .

TRY.
lt_tab3 = VALUE #( FOR ls_tab2_tmp IN LT_TAB_1
                  (  id = ls_tab2_tmp-id
                     mark = ls_Tab2_tmp-mark
                     result = COND string( WHEN ls_tab2_tmp-mark >= 40 and ls_tab2_tmp-mark < 80 THEN 'PASS'
                                           WHEN ls_tab2_tmp-mark >= 80 THEN 'PASS with distinction'
                                           WHEN ls_tab2_tmp-mark > 0 and ls_tab2_tmp-mark < 40 THEN 'FAIL'
                                           ELSE THROW cx_wrong_condition( ) ) ) ).

cl_demo_output=>write( lt_tab3 ).

CATCH cx_wrong_condition INTO DATA(lo_excptn) .
  cl_demo_output=>write( lo_excptn->get_text( ) ).

ENDTRY .



cl_demo_output=>display( ) .
