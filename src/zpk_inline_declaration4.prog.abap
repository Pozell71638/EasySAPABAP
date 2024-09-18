*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION4.

SELECT carrid,
       connid,
       countryfr,
       countryto
       from spfli
       INTO TABLE @DATA(lt_spfli) UP TO 100 ROWS .


SKIP 1.
WRITE :/ 'Output of new Select Single Query' .

SKIP 1.

SELECT SINGLE Countryfr,
              Countryto
              FROM spfli
              INTO (@data(lv_from), @DATA(lv_to))         " Inline variable declaration to capture each field values from the DB Table while using Select Statement
              WHERE carrid = 'LH' .
**                    connid = '17' .

WRITE :/ 'Countryfr',
        15 'countryto' .

WRITE :/ lv_from ,
        15 lv_to .


*********************************************************************************************************************************
*     Bu kod bloğu, spfli tablosundan belirli koşulları sağlayan tek bir satırı seçer ve belirtilen alanların değerlerini alır.
***SKIP 1.   " Bir satır boşluk bırak
***WRITE :/ 'Yeni Tekil Seçim Sorgusunun Çıktısı' .   " Başlık yazdırma
***
***SKIP 1.   " Bir satır boşluk bırak
***
***SELECT SINGLE Countryfr,   " Tek bir satır seç ve belirtilen alanları al
***              Countryto
***              FROM spfli
***              INTO (@data(lv_from), @DATA(lv_to))   " Veritabanından her alanın değerini almak için iç içe değişken tanımı
***              WHERE carrid = 'LH'   " Koşullar belirtme
*****                    connid = '17' .   " Diğer bir koşul (bu satırın sonunda noktalı virgül olmamalıdır)
***
***WRITE :/ 'Başlangıç Ülkesi',   " Sütun başlıklarını yazdır
***        15 'Varış Ülkesi' .   " 15 karakter boşluk bırakarak
***
***WRITE :/ lv_from ,   " Değerleri yazdır
***        15 lv_to .   " 15 karakter boşluk bırakarak
***********************************************************************************************************************************
