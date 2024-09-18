*&---------------------------------------------------------------------*
*& Report ZPK_FOR_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_FOR_DEMO.

TYPES : BEGIN OF ty_str ,
         comp1 TYPE i ,
         comp2 TYPE string ,
        END OF ty_str .

DATA : ls_tab TYPE ty_str ,
       lt_tab TYPE STANDARD TABLE OF ty_str ,
       lt_name TYPE TABLE OF string .


lt_Tab = VALUE #( ( comp1 = 1 comp2 = 'Name1' )
                  ( comp1 = 2 comp2 = 'Name2' )
                  ( comp1 = 3 comp2 = 'Name3' )
                  ( comp1 = 4 comp2 = 'Name4' ) ) .
***************************************************************************************************
*Bu ABAP kodu bir iç tablo tanımlar ve doldurur.
*
*TYPES bildirimiyle ty_str adında bir yapı (structure) tanımlanır.
*Bu yapı iki bileşenden oluşur: comp1 adında bir tamsayı (integer)
*bileşen ve comp2 adında bir dize (string) bileşen.
*
*DATA bildirimiyle üç değişken tanımlanır:
*
*ls_tab: ty_str türünden bir tekil yapı değişkeni.
*lt_tab: ty_str türünden standart bir tablo (standard table).
*lt_name: Dize (string) türünden bir tablo.
*lt_tab değişkeni, VALUE komutu kullanılarak doldurulur. VALUE komutu,
*tablo türünden bir değer oluşturmayı sağlar. İç tablo lt_tab, ty_str
*türünde elemanlara sahip olacak şekilde değer atanır. Bu değerler,
* özelleştirilmiş bir sözdizimi kullanılarak doğrudan atama yapılır.
*
*Kodun açıklaması şudur:
*
*lt_tab adında bir iç tablo tanımlanır ve doldurulur.
*Bu iç tablo, her biri comp1 ve comp2 alanlarına sahip olan ty_str türünden öğeler içerir.
*lt_name adında bir dize tablosu tanımlanır, ancak kodun bu bölümünde bu tablo kullanılmaz.
*Sonuç olarak, lt_tab iç tablosu, dört satırdan oluşur ve her satırda bir tamsayı ve bir dize bulunur.
* Bu veri yapısı, işlem yapmak için kullanılabilir.
********************************************************************************************************
SKIP 1 .
WRITE :/ '********************************IT_TAB Internal table****************************************' .

SKIP 1 .

LOOP AT lt_Tab INTO ls_Tab .
  WRITE :/ ls_tab-comp1,
           ls_tab-comp2 .
ENDLOOP.
********************************************************************************************************
SKIP 1 .
WRITE :/ '********************************LT_NAME Internal table****************************************' .

SKIP 1 .

lt_name = VALUE #( FOR ls_tab_temp in lt_tab              " Ls_Tab_temp doesn't appear to have been declared but it declared implicitly
                                   WHERE ( comp1 > 2 )
                                         ( ls_tab_temp-comp2 ) ).


LOOP AT lt_name INTO DATA(ls_name).
 WRITE :/ ls_name .
ENDLOOP.
*********************************************************************************************************
SKIP 1 .
WRITE :/ '********************************Create Range table****************************************' .

SKIP 1 .

DATA : lr_name TYPE RANGE OF string .

lr_name = VALUE #( FOR ls_tab_tmp in lt_tab
                 ( sign = 'I'
                   option = 'EQ'
                   low = ls_tab_tmp-comp2 ) ) .


LOOP AT lr_name INTO DATA(ls_name_r).
 WRITE :/ ls_name_r-sign,
          ls_name_r-option,
          ls_name_r-low,
          ls_name_r-high .
ENDLOOP.

**********************************************************************************************************

SKIP 1 .
WRITE :/ '********************************Create Dynamic values using DO loop ****************************************' .

SKIP 1 .
DATA : lv_cnt TYPE sy-tabix VALUE IS INITIAL .
REFRESH lt_Tab .
DO 10 TIMES.
  lv_cnt = lv_cnt + 1.
  ls_tab-comp1 = lv_cnt .
  ls_tab-comp2 = 'comp' && lv_cnt .
  APPEND ls_tab to lt_tab .
ENDDO.

LOOP AT lt_tab INTO ls_tab.
 WRITE :/ ls_tab-comp1,
          ls_tab-comp2 .
ENDLOOP.
************************************************************************************************************
SKIP 1 .
WRITE :/ '********************************Alternative way of DO loop using 7.4 ABAP syntax ****************************************' .

SKIP 1 .

clear : lt_tab .

lt_tab = VALUE #( FOR lv_count = 1 THEN lv_count + 1 UNTIL lv_count > 10
                 ( comp1 = lv_count comp2 = 'Test' && lv_count )
                ) .


LOOP AT lt_tab INTO ls_tab.
 WRITE :/ ls_tab-comp1,
          ls_tab-comp2 .
ENDLOOP.
