*&---------------------------------------------------------------------*
*& Report ZPK_FILTER_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_FILTER_DEMO.

TYPES : BEGIN OF ty_book ,
         carrid TYPE s_carrid ,
         connid TYPE s_conn_id ,
         fldate TYPE s_Date ,
         class TYPE s_class ,
        END OF ty_book .

DATA : lt_sbook TYPE SORTED TABLE OF ty_book WITH NON-UNIQUE KEY class .


SELECT carrid,
       connid,
       fldate,
       class
       FROM sbook
       INTO TABLE @lt_sbook
       WHERE carrid eq 'AA' and
             fldate eq '20231005' .


*cl_demo_output=>write( lt_sbook ) .

*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*cl_demo_output=>write( ' Displaying using FIlter Option from 7.4 syntax ' ).
***SKIP 1 .
*
*DATA(lt_tab_filter1) = FILTER #( lt_sbook WHERE class = 'C' ) .
*"FILTER #( lt_sbook WHERE class = 'C' ) ifadesi, lt_sbook iç tablosunu filtreler ve belirli bir koşulu sağlayan
*"satırları içeren yeni bir iç tablo oluşturur. Bu durumda, class alanı 'C' olan satırların seçilmesi istenir.
*
*cl_demo_output=>write( lt_tab_filter1 ) .
**
*
**""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*cl_demo_output=>write( ' Displaying using Filter Option along with EXCEPT option from 7.4 syntax ' ).
*SKIP 1 .
*
*DATA(lt_tab_filter2) = FILTER #( lt_sbook EXCEPT WHERE class = 'C' ) .
*
*cl_demo_output=>write( lt_tab_filter2 ) .
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
TYPES : BEGIN OF ty_class ,
         class_fltr TYPE s_class ,
        END OF ty_class .

TYPES : tt_class TYPE SORTED TABLE OF ty_class WITH UNIQUE KEY class_fltr .

DATA(s_class) = VALUE tt_class(
                                        ( class_fltr = 'C' )
                                        ( class_fltr = 'F' )
                                       ).

*"                              LT_SBOOK is main internal table, S_CLASS is Group of Conditions maintained table
DATA(lt_tab_filter3) = FILTER #( lt_sbook IN s_class WHERE class = class_fltr ) .

cl_demo_output=>write( lt_tab_filter3 ) .
cl_demo_output=>display( ).
