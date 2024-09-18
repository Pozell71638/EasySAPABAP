*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION3.


SELECT carrid,
       connid,
       countryfr,
       countryto
       from spfli
       INTO TABLE @DATA(lt_spfli) UP TO 100 ROWS .





WRITE :/ 'Output of New Work Area Syntax' .

SKIP 1.
FORMAT COLOR 4 ON.
WRITE :/   'Airline Code',
        15 'Flight Number' ,
        30 'Country From' ,
        45 'Counter To' .
FORMAT COLOR OFF .

LOOP AT lt_spfli into data(ls_spfli).               " Inline Work Area declaration while looping internal table( With 7.4 Syntax )

WRITE :/   ls_spfli-carrid,
        15 ls_spfli-connid,
        30 ls_spfli-countryfr,
        45 ls_spfli-countryto.

ENDLOOP.

************************************************************************
*Bu kod bloğu, iç tablo üzerinde dönerken yeni iş alanı ("work area") sözdizimini kullanır.
***WRITE :/ 'Yeni İş Alanı Sözdizimi ile Çıktı' .   " Başlık yazdırma
***
***SKIP 1.   " Bir satır atla
***FORMAT COLOR 4 ON.   " Renk formatını değiştir, 4 numaralı renk kodu (Kırmızı)
***WRITE :/   'Havayolu Kodu',   " Sütun başlıklarını yazdır
***        15 'Uçuş Numarası' ,   " 15 karakter boşluk bırakarak
***        30 'Başlangıç Ülkesi' ,   " 30 karakter boşluk bırakarak
***        45 'Varış Ülkesi' .   " 45 karakter boşluk bırakarak
***FORMAT COLOR OFF .   " Renk formatını kapat
***
***LOOP AT lt_spfli into data(ls_spfli).   " İç tabloyu dolaş, yeni iş alanı ile
***
***WRITE :/   ls_spfli-carrid,   " Yeni iş alanı ile içerikleri yazdır
***        15 ls_spfli-connid,   " 15 karakter boşluk bırakarak
***        30 ls_spfli-countryfr,   " 30 karakter boşluk bırakarak
***        45 ls_spfli-countryto.   " 45 karakter boşluk bırakarak
***
***ENDLOOP.   " Döngüyü bitir.
