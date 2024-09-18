*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION2.

SELECT carrid,
       connid,
       countryfr,
       countryto
       from spfli
       INTO TABLE @DATA(lt_spfli) UP TO 100 ROWS .


WRITE :/ 'Output of New Field-Symbols Syntax' .

SKIP 1.
FORMAT COLOR 3 ON.
WRITE :/   'Airline Code',
        15 'Flight Number' ,
        30 'Country From' ,
        45 'Counter To' .
FORMAT COLOR OFF .

LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<lfs_spfli>).              " Inline Field Symbol declaration while looping internal table( With 7.4 Syntax )

WRITE :/   <lfs_spfli>-carrid,
        15 <lfs_spfli>-connid,
        30 <lfs_spfli>-countryfr,
        45 <lfs_spfli>-countryto.

ENDLOOP.

*    Bu kod bloğu, bir iç tabloyu dolaşırken ve içerisindeki verileri yazdırırken yeni alan işaretçisi ("Field-Symbol") sözdizimini kullanır.
*
***WRITE :/ 'Yeni Alan İşaretçisi Sözdizimi ile Çıktı' .   " Başlık yazdırma
***
***SKIP 1.   " Bir satır atla
***FORMAT COLOR 3 ON.   " Renk formatını değiştir, 3 numaralı renk kodu (Turkuaz)
***WRITE :/   'Havayolu Kodu',   " Sütun başlıklarını yazdır
***        15 'Uçuş Numarası' ,   " 15 karakter boşluk bırakarak
***        30 'Başlangıç Ülkesi' ,   " 30 karakter boşluk bırakarak
***        45 'Varış Ülkesi' .   " 45 karakter boşluk bırakarak
***FORMAT COLOR OFF .   " Renk formatını kapat
***
***LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<lfs_spfli>).   " İç tabloyu dolaş, alan işaretçisi ile
***
***WRITE :/   <lfs_spfli>-carrid,   " Alan işaretçisi ile içerikleri yazdır
***        15 <lfs_spfli>-connid,   " 15 karakter boşluk bırakarak
***        30 <lfs_spfli>-countryfr,   " 30 karakter boşluk bırakarak
***        45 <lfs_spfli>-countryto.   " 45 karakter boşluk bırakarak
***
***ENDLOOP.   " Döngüyü bitir
