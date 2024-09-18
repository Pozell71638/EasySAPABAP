*&---------------------------------------------------------------------*
*& Report ZPK_VALUE_OLD_NEW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_value_old_new.


*Ilk olarak, ty_type adında bir yapı tanımlanır. Bu yapı, comp1 adında bir tamsayı (i)
*ve comp2 adında bir dize (string) bileşenine sahiptir.
*
*Daha sonra, tty_type adında bir standart tablo türü tanımlanır. Bu, ty_type yapısının
*öğelerini içeren bir tablo türüdür. WITH EMPTY KEY, bu tablonun anahtar alanlarına ihtiyaç duymadığını belirtir.
*
*ls_tab adında bir ty_type yapısal değişken tanımlanır. Bu değişken, tek bir ty_type yapısını temsil eder.
*
*lt_tab adında bir standart tablo tanımlanır. Bu tablo, ty_type yapısının öğelerini içerir ve birden
* çok yapının depolandığı bir koleksiyonu temsil eder.

*ls_tab yapısının bileşenlerine değerler atanır.
*Daha sonra, ls_tab değişkeni lt_tab iç tablosuna eklenir. APPEND ifadesiyle yapısal değişken tabloya eklenir ve ardından
*CLEAR ifadesiyle yapısal değişken temizlenir.
*Bu işlem, ls_tab değişkenine yeni bir değer atanmadan önce yapısal değişkeni temizlemek için yapılır.

TYPES : BEGIN OF ty_type ,
          comp1 TYPE i,
          comp2 TYPE string,
        END OF ty_type ,

        tty_type TYPE STANDARD TABLE OF ty_type WITH EMPTY KEY.

DATA : ls_tab TYPE ty_type,
       lt_tab TYPE STANDARD TABLE OF ty_Type.


ls_tab-comp1 = 1 .
ls_tab-comp2 = 'Name1' .
APPEND ls_Tab TO lt_tab .
CLEAR ls_tab .

ls_tab-comp1 = 2 .
ls_tab-comp2 = 'Name2' .
APPEND ls_Tab TO lt_tab .
CLEAR ls_tab .

ls_tab-comp1 = 3 .
ls_tab-comp2 = 'Name3' .
APPEND ls_Tab TO lt_tab .
CLEAR ls_tab .

WRITE :/ '  comp1' , '  comp2'.
LOOP AT lt_tab INTO ls_Tab .
  WRITE :/ ls_tab-comp1, ls_tab-comp2 .
ENDLOOP.

***************************************** New Value Operator

WRITE:/ '**************** Value Operator ex' .
SKIP 1.

DATA(ls_tab_1) = VALUE ty_type( comp1 = 11 comp2 = 'Name11' )." Bu satır, ls_tab_1 adında bir yapısal değişkeni başlatır.
*DATA ifadesi, bir değişken tanımlar. ls_tab_1, tanımlanan değişkenin adıdır. VALUE ifadesi, bir veri öğesi oluşturmak için
*kullanılır. ty_type veri türü, comp1 ve comp2 adlarında iki bileşene sahip bir yapıdır. Parantez içindeki comp1 = 11 comp2 = 'Name11' ifadesi,
* bu iki bileşene başlangıç değerlerini atar. comp1 bileşenine 11 ve comp2 bileşenine 'Name11' değeri atanır.

WRITE :/ 'Structure' .
WRITE :/ '  comp1' , '  comp2'.
WRITE :/ ls_tab_1-comp1, ls_tab_1-comp2 .
********************************************************************************************************************************************
WRITE:/ '****************Table using Value Operator ex' .
SKIP 1.
CLEAR : ls_tab_1 .
DATA(lt_tab_1) = VALUE tty_type( ( comp1 = 11 comp2 = 'Name11' )
                                 ( comp1 = 12 comp2 = 'Name12' )
                                 ( comp1 = 13 comp2 = 'Name13' )
                                 ( comp1 = 14 comp2 = 'Name14' ) ) .


WRITE :/ 'Internal table using VALUE Operator' .
WRITE :/ '  comp1' , '  comp2'.
LOOP AT lt_tab_1 INTO ls_tab_1 .
  WRITE :/ ls_tab_1-comp1, ls_tab_1-comp2 .
ENDLOOP.
*********************************************************************************************************************************************
WRITE:/ '****************Initial Value with explicit type' .
SKIP 1.
CLEAR : ls_Tab_1 .
DATA(lt_tab_3) = VALUE tty_type( ). "Bu satır, lt_tab_3 adında bir iç tabloyu başlangıç değeriyle başlatır.
*DATA ifadesi bir değişken tanımlar. lt_tab_3, tanımlanan değişkenin adıdır. VALUE ifadesi, bir veri öğesi oluşturmak
*için kullanılır. tty_type tablo türü, ty_type veri türünden öğeleri içeren bir tabloyu temsil eder. Parantez içinde
* boş bir liste kullanılarak, iç tablonun başlangıç değeri olarak bir iç tablo oluşturulur.
WRITE :/ 'Internal table using VALUE Operator' .
WRITE :/ '  comp1' , '  comp2'.
LOOP AT lt_tab_3 INTO ls_tab_1 .
  WRITE :/ ls_tab_1-comp1, ls_tab_1-comp2 .
ENDLOOP.
***********************************************************************************************************************************************
WRITE:/ '****************Internal table with VALUE Operator and #'.
DATA : lt_tab_2 TYPE TABLE OF ty_type .
SKIP 1.
CLEAR : ls_Tab_1 .
WRITE :/ 'Internal Table' .
lt_tab_2 = VALUE #( ( comp1 = 21 comp2 = 'Name21' )
                    ( comp1 = 22 comp2 = 'Name22' )
                    ( comp1 = 23 comp2 = 'Name23' )
                    ( comp1 = 24 comp2 = 'Name24' ) ) .
"lt_tab_2 iç tablosu, VALUE operatörü ve # sembolü kullanılarak başlangıç değeriyle başlatılır.
*# sembolü, bir iç tabloyu başlatmak için kullanılır. Parantez içindeki her bir set, iç tabloya eklenecek bir yapısal öğe tanımlar.
CLEAR : ls_tab_1 .
WRITE :/ 'Internal table using VALUE Operator and #' .
WRITE :/ '  comp1' , '  comp2'.
LOOP AT lt_tab_2 INTO ls_tab_1 .
  WRITE :/ ls_tab_1-comp1, ls_tab_1-comp2 .
ENDLOOP.
************************************************************************************************************************************************

********************************************************************************************************************************
SKIP 1.
WRITE : / '************************************************Old Range Table ********************************************* ' .
SKIP 1 .

DATA : lr_tab   TYPE RANGE OF string,
       ls_tab_r LIKE LINE OF lr_tab.

ls_tab_r-sign = 'I' .
ls_tab_r-option = 'EQ' .
ls_tab_r-low = 'Name1' .
APPEND ls_Tab_r TO lr_tab .

ls_tab_r-sign = 'I' .
ls_tab_r-option = 'EQ' .
ls_tab_r-low = 'Name2' .
APPEND ls_Tab_r TO lr_tab .

ls_tab_r-sign = 'I' .
ls_tab_r-option = 'EQ' .
ls_tab_r-low = 'Name3' .
APPEND ls_Tab_r TO lr_tab .

WRITE :/ 'Sign' , 'Option', 'Low'.
LOOP AT lr_tab INTO ls_Tab_r .
  WRITE :/ ls_Tab_r-sign,
           ls_Tab_r-option,
           ls_Tab_r-low .
ENDLOOP.
SKIP 1 .
************************************************************************
*Bu kod parçası, aralık tablosunu başlatmak için RANGE OF ifadesini kullanır
*ve ardından bu tablodaki verileri döngü kullanarak yazdırır. Aralık tablosu,
*belirli bir kriteri karşılayan değerleri depolamak için kullanılır. Bu kod örneğinde,
*aralık tablosunda 'Name1', 'Name2' ve 'Name3' değerleri için eşleşen aralık belirtilmiştir.                                                                *
************************************************************************

SKIP 1.
WRITE : / '************************************************New Range Table ********************************************* ' .
Skip 1 .


DATA : lt_tab_11 TYPE RANGE OF string .
lt_tab_11 = VALUE #( sign = 'I' option = 'EQ' ( low =  'Name1' )
                                           ( low =  'Name2' )
                                           ( low =  'Name3' )
                                           ( low =  'Name4' ) ).

WRITE :/ 'Sign' , 'Option', 'Low'.
LOOP AT lt_tab_11 INTO DATA(ls_Tab1) .
  WRITE :/ ls_Tab1-sign,
           ls_Tab1-option,
           ls_Tab1-low .
ENDLOOP.
SKIP 1 .
