*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_inline_declaration5.

*SELECT carrid,
*       connid,
*       countryfr,
*       countryto
*       FROM spfli
*       INTO TABLE @DATA(lt_spfli) UP TO 100 ROWS .

DATA : lv_lzero   TYPE char10 VALUE '0000000291',
       Lv_nzero   TYPE char10 VALUE '555',
       lv_message TYPE string.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
  EXPORTING
    input  = Lv_nzero
  IMPORTING
    output = Lv_nzero.

WRITE : lv_nzero .

SKIP 1.

CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
  EXPORTING
    input  = lv_lzero
  IMPORTING
    output = lv_lzero.

WRITE : lv_Lzero .

************************************************************************
* Bu kod bloğu, SAP standard fonksiyonlarını kullanarak alfasayısal verileri sayısal verilere dönüştürme
* ve tersine dönüştürme işlemlerini gerçekleştirir. İşlevlerin her biri, belirtilen giriş değerini alır ve dönüştürülmüş çıktı
* değerini sağlar. Sonuçlar, ilgili değişkenlere atanır ve daha sonra yazdırılır.
************************************************************************

************************************************************************
*     Bu kod bloğunda, sayısal ve alfasayısal veriler arasında dönüşüm yapmak için SAP standart fonksiyonlarını kullanıyoruz
*DATA: lv_lzero TYPE char10 VALUE '0000000291',   " 10 karakterlik alfanümerik bir değer oluşturulur ve başlangıçta '0000000291' olarak ayarlanır
*      Lv_nzero TYPE char10 VALUE '555',   " 10 karakterlik alfanümerik bir değer oluşturulur ve başlangıçta '555' olarak ayarlanır
*      lv_message TYPE string .   " Metin tipinde bir değişken tanımlanır

***CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'   " Alfanümerik giriş için dönüşüm fonksiyonunu çağır
***  EXPORTING
***    input         = Lv_nzero   " Dönüşüm yapılacak giriş değeri
*** IMPORTING
***   OUTPUT        = Lv_nzero .   " Dönüştürülmüş çıktı değeri

***WRITE : lv_nzero .   " Dönüştürülmüş değeri yazdır

***SKIP 1.   " Bir satır boşluk bırak

***CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'   " Alfanümerik çıkış için dönüşüm fonksiyonunu çağır
***  EXPORTING
***    input         = lv_lzero   " Dönüşüm yapılacak giriş değeri
*** IMPORTING
***   OUTPUT        = lv_lzero .   " Dönüştürülmüş çıktı değeri

***WRITE : lv_Lzero .   " Dönüştürülmüş değeri yazdır
