*&---------------------------------------------------------------------*
*& Report ZPK_CORRESPONDING_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CORRESPONDING_DEMO.


TYPES : BEGIN OF ty_tab1 ,
         comp1 TYPE i ,
         comp2 TYPE string ,
        END OF ty_tab1 ,

        BEGIN OF ty_tab2 ,
         comp1 TYPE i ,
         comp2 TYPE string ,
         comp3 TYPE char5 ,
        END OF ty_tab2 ,

        tty_tab2 TYPE TABLE of ty_Tab2 WITH EMPTY KEY .

DATA : ls_tab1 TYPE ty_Tab1 ,
       lt_tab1 TYPE STANDARD TABLE OF ty_Tab1 ,

       ls_tab2 TYPE ty_Tab2 ,
       lt_tab2 TYPE STANDARD TABLE OF ty_tab2 .


ls_Tab1 = VALUE #( comp1 = 1 comp2 = 'Name1' ) .

lt_tab1 = value #(
                   ( comp1 = 1 comp2 = 'Name1' )
                   ( comp1 = 2 comp2 = 'Name2' )
                   ( comp1 = 3 comp2 = 'Name3' )
                  ) .

ls_Tab2 = VALUE #( comp1 = 4 comp2 = 'Name4' comp3 = 'Addr4' ) .

lt_tab2 = value #(
                   ( comp1 = 4 comp2 = 'Name4' comp3 = 'Addr4' )
                   ( comp1 = 5 comp2 = 'Name5' comp3 = 'Addr5' )
                   ( comp1 = 6 comp2 = 'Name6' comp3 = 'Addr6' )
                  ) .

********************************************************************************************************************************
*Bu ABAP kodunda iki farklı yapı (structure) tanımlanıyor ve bu yapılar üzerinde işlemler gerçekleştiriliyor.
*
*İlk olarak, ty_tab1 ve ty_tab2 adında iki yapı tanımlanıyor. Her bir yapı farklı bileşenlere sahiptir:
*
*ty_tab1: comp1 ve comp2 adında birer bileşene sahiptir.
*ty_tab2: comp1, comp2, ve comp3 adında üç bileşene sahiptir.
*tty_tab2 adında, ty_tab2 türünde bir tablo tanımlanıyor. Ancak, WITH EMPTY KEY belirteci ile tablo içi
*birincil anahtar (primary key) kullanılmaz. Yani, bu tablo sadece bir dizi (array) olarak davranır.
*
*Ardından, ls_tab1, lt_tab1, ls_tab2, ve lt_tab2 olmak üzere dört farklı değişken tanımlanıyor:
*
*ls_tab1: ty_tab1 türünden bir tekil yapı değişkeni.
*lt_tab1: ty_tab1 türünden standart bir tablo (standard table).
*ls_tab2: ty_tab2 türünden bir tekil yapı değişkeni.
*lt_tab2: ty_tab2 türünden standart bir tablo.
*Değişkenler belirli değerlerle dolduruluyor:
*
*ls_tab1 tekil yapı değişkenine değer atanıyor.
*lt_tab1 standart tablo değişkenine VALUE kullanılarak birden fazla değer atanıyor.
*ls_tab2 tekil yapı değişkenine değer atanıyor.
*lt_tab2 standart tablo değişkenine VALUE kullanılarak birden fazla değer atanıyor.
*Kod, farklı veri yapısı ve değişkenler üzerinde işlem yapar. ty_tab1 ve ty_tab2 yapıları, farklı sayıda
*bileşenlere sahiptir ve bu bileşenlere göre değişkenler doldurulur. Son olarak, bu değişkenler işlem yapmak üzere kullanılabilir.
***********************************************************************************************************************************
WRITE :/ '****************  LS_TAB1  ***************************************' .
SKIP 1.

WRITE :/ '  Comp1', 'Comp2' .
WRITE :/ ls_Tab1-comp1, ls_tab1-comp2 .
SKIP 1.
**********************************************************************************************************************************
WRITE :/ '****************  LS_TAB2  ***************************************' .
SKIP 1.

WRITE :/ '  Comp1', 'Comp2' , 'Comp3' .
WRITE :/ ls_Tab2-comp1, ls_tab2-comp2, ls_tab2-comp3  .

**********************************************************************************************************************************
SKIP 1.
WRITE :/ '****************  Move Corresponding from ls_Tab1 to ls_tab2  ***************************************' .

MOVE-CORRESPONDING ls_tab1 to ls_Tab2 .
SKIP 1.

WRITE :/ '  Comp1', 'Comp2' , 'Comp3' .
WRITE :/ ls_Tab2-comp1, ls_tab2-comp2, ls_tab2-comp3  .
SKIP 1."Burada ls_tab1 in degerini ls_tab2 ya atti ancak son sutun ls_tab2 ya ait oldugu icin son veri ordan geldi.
**********************************************************************************************************************************
WRITE :/ '****************  Move Corresponding from ls_Tab1 = Corresponding #( base ( ls_tab2 )   ***************************************' .

Ls_tab2 = CORRESPONDING #( BASE ( ls_tab2 ) ls_tab1 ).
SKIP 1.

WRITE :/ '  Comp1', 'Comp2' , 'Comp3' .
WRITE :/ ls_Tab2-comp1, ls_tab2-comp2, ls_tab2-comp3  .
SKIP 1."Bir onceki ile ayno sonucu verdi.
***********************************************************************************************************************************
WRITE :/ '****************  Move Corresponding from ls_Tab1 = Corresponding #( ( ls_tab2 )   ***************************************' .

Ls_tab2 = CORRESPONDING #( ls_tab1 ) .
SKIP 1.

WRITE :/ '  Comp1', 'Comp2' , 'Comp3' .
WRITE :/ ls_Tab2-comp1, ls_tab2-comp2, ls_tab2-comp3  .
SKIP 1.
