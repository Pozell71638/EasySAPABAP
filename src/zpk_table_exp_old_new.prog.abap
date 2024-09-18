*&---------------------------------------------------------------------*
*& Report ZPK_TABLE_EXP_OLD_NEW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_TABLE_EXP_OLD_NEW.

TYPES : BEGIN OF ty_spfli ,
          carrid    TYPE s_carr_id,
          connid    TYPE s_conn_id,
          countryfr TYPE land1,
          countryto TYPE land1,
        END OF ty_spfli .


DATA : ls_spfli_old TYPE ty_spfli,
       lt_spfli_old TYPE STANDARD TABLE OF ty_spfli.

SELECT carrid
       connid
       countryfr
       countryto
       FROM spfli
       INTO TABLE lt_spfli_old UP TO 100 ROWS .

SKIP 1.
WRITE :/ 'Output of Select Query' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

LOOP AT lt_spfli_old INTO ls_spfli_old.
  WRITE :/   ls_spfli_old-carrid ,
          15 ls_spfli_old-connid  ,
          30 ls_spfli_old-countryfr ,
          45 ls_spfli_old-countryto .

  CLEAR : ls_spfli_old .
ENDLOOP.

WRITE :/ '**********************************************************************' .

SKIP 1.

*************************************** Old Read table with index( Data found )
CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old INTO ls_spfli_old INDEX 2 ."Bu ifade, lt_spfli_old adlı iç tablodan ikinci girişi (INDEX 2) ls_spfli_old yapısına okur.
IF sy-subrc = 0.
  WRITE :/ 'Old Read table with index 2' .
  SKIP 1.
  WRITE :/   'Airline Code' ,
          15 'Flight number' ,
          30 'Country form' ,
          45 'Country to' .

  WRITE :/   ls_spfli_old-carrid ,
        15 ls_spfli_old-connid  ,
        30 ls_spfli_old-countryfr ,
        45 ls_spfli_old-countryto .
ENDIF.

CLEAR : ls_spfli_old.

*************************************** New Read table with index( Data Found )
***DATA(lt_spfli_new) = lt_spfli_old .

WRITE :/ '**********************************************************************' .

SKIP 1.
DATA(ls_spfli_new) = lt_spfli_old[ 2 ] .
WRITE :/ 'New Read table with index 2' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_new-carrid ,
      15 ls_spfli_new-connid  ,
      30 ls_spfli_new-countryfr ,
      45 ls_spfli_new-countryto .

*************************************** Old Read table with index( Datanot Found )
WRITE :/ '**********************************************************************' .

CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old INTO ls_spfli_old INDEX 5 .
IF sy-subrc <> 0.
  WRITE:/ 'Data Not found with given index' .
ENDIF .

WRITE :/ 'Old Read table with index 5' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_old-carrid ,
      15 ls_spfli_old-connid  ,
      30 ls_spfli_old-countryfr ,
      45 ls_spfli_old-countryto .

*************************************** New Read table with index( Datanot Found )
WRITE :/ '**********************************************************************' .

SKIP 1.
CLEAR : ls_spfli_new .
TRY .
    ls_spfli_new = lt_spfli_old[ 5 ] .
  CATCH cx_sy_itab_line_not_found .
    WRITE :/ 'Data not found with given Index' .
ENDTRY .

WRITE :/ 'New Read table with index 5' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_new-carrid ,
      15 ls_spfli_new-connid  ,
      30 ls_spfli_new-countryfr ,
      45 ls_spfli_new-countryto .

*************************************** Old Read table with Key( Data Found )
WRITE :/ '**********************************************************************' .

CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old INTO ls_spfli_old WITH KEY carrid = 'AZ' connid = '0555'.
IF sy-subrc = 0.
***  WRITE:/ 'Data Not found with given index' .

  WRITE :/ 'Old Read table with key carrid = ''AZ'' connid = ''0555''' .
  SKIP 1.
  WRITE :/   'Airline Code' ,
          15 'Flight number' ,
          30 'Country form' ,
          45 'Country to' .

  WRITE :/   ls_spfli_old-carrid ,
        15 ls_spfli_old-connid  ,
        30 ls_spfli_old-countryfr ,
        45 ls_spfli_old-countryto .
ENDIF .

*************************************** New Read table with Key( Data Found )
WRITE :/ '**********************************************************************' .

SKIP 1.
CLEAR : ls_spfli_new .
TRY .
    ls_spfli_new = lt_spfli_old[ carrid = 'AA' connid = '0017' ] .
  CATCH cx_sy_itab_line_not_found .
    WRITE :/ 'Data not found with given Key values' .
ENDTRY .

WRITE :/ 'New Read table with key carrid = ''AZ'' connid = ''0555''' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_new-carrid ,
      15 ls_spfli_new-connid  ,
      30 ls_spfli_new-countryfr ,
      45 ls_spfli_new-countryto .

*************************************** Old Read table with Key( Datanot Found )
WRITE :/ '**********************************************************************' .

CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old INTO ls_spfli_old WITH KEY carrid = 'AZ' connid = '0017'.
IF sy-subrc <> 0.
  WRITE:/ 'Data Not found with given condition' .

ENDIF .
WRITE :/ 'No Data with Old Read table with key carrid = ''AZ'' connid = ''0017''' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_old-carrid ,
      15 ls_spfli_old-connid  ,
      30 ls_spfli_old-countryfr ,
      45 ls_spfli_old-countryto .

*************************************** New Read table with Key( Datanot Found )
WRITE :/ '**********************************************************************' .

SKIP 1.
CLEAR : ls_spfli_new .
TRY .
    ls_spfli_new = lt_spfli_old[ carrid = 'AA' connid = '0555' ] .
  CATCH cx_sy_itab_line_not_found .
    WRITE :/ 'Data not found with given Key values' .
ENDTRY .

WRITE :/ 'No Data with New Read table with key carrid = ''AA'' connid = ''0555''' .
SKIP 1.
WRITE :/   'Airline Code' ,
        15 'Flight number' ,
        30 'Country form' ,
        45 'Country to' .

WRITE :/   ls_spfli_new-carrid ,
      15 ls_spfli_new-connid  ,
      30 ls_spfli_new-countryfr ,
      45 ls_spfli_new-countryto .
*************************************** Old Read table with Key( data not required )
WRITE :/ '**********************************************************************' .

CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old TRANSPORTING NO FIELDS WITH KEY carrid = 'AZ' connid = '0017'. "Bu satır,
" lt_spfli_old adlı iç tablodan belirli bir koşula göre veri okur. Burada carrid alanı 'AZ' ve
"connid alanı '0017' olan satırları ararız. Ancak, TRANSPORTING NO FIELDS ifadesi, bu sorgudan dönen
"verilerin tablodaki alanlarını taşımayı devre dışı bırakır. Yani, sadece belirtilen koşula uygun satırların varlığını kontrol ederiz.
IF sy-subrc = 0 .
  WRITE :/ 'Data found' .
ELSE .
  WRITE :/ 'Data not found' .
ENDIF .

*************************************** New Read table with Key( data not required ) using Line_exists
WRITE :/ '**********************************************************************' .

IF line_exists( lt_spfli_old[ carrid = 'AZ' connid = '0555' ] ) .
  WRITE :/ 'Data found' .
ELSE .
  WRITE :/ 'Data not found' .
ENDIF.

*Daha sonra, line_exists fonksiyonu kullanılarak bir kontrol gerçekleştiriliyor.
*Bu kontrol, lt_spfli_old adındaki tabloda, carrid alanı 'AZ' ve connid alanı '0555'
*olan bir girişin bulunup bulunmadığını kontrol ediyor.
*
*Eğer bu koşula uygun bir giriş bulunursa, yani veri bulunursa, 'Data found'
*(Veri bulundu) mesajı ekrana yazdırılıyor. Aksi takdirde, yalnızca 'Data not found'
* (Veri bulunamadı) mesajı ekrana yazdırılıyor. Bu, programın çalıştığı koşula göre
* ilgili mesajın ekrana yazdırılmasını sağlar.

*************************************** Old Read table get the index
WRITE :/ '**********************************************************************' .

CLEAR : ls_spfli_old .
READ TABLE lt_spfli_old TRANSPORTING NO FIELDS WITH KEY carrid = 'AZ' connid = '0555'.
IF sy-subrc = 0 .
  WRITE :/ 'Get the table index' .
  WRITE :/ sy-tabix, 'is table index for carrid = ''AZ'' connid = ''0555'''.
ELSE .
  WRITE :/ 'Data not found' .
ENDIF .

*************************************** New Read table with Key( data not required ) using Line_index
WRITE :/ '**********************************************************************' .

DATA(indx) = line_index( lt_spfli_old[ carrid = 'AZ' connid = '0555' ] ) .
**Tablonun belirli bir koşula göre indeksini almak için line_index fonksiyonu kullanılıyor.
*Bu koşul, lt_spfli_old adındaki tablonun carrid alanının 'AZ' ve connid alanının '0555' olduğu durumu belirtiyor.
*indx adında bir değişkene bu indeks atanıyor.
*
*Daha sonra indx değişkeni kontrol ediliyor. Eğer indx boş değilse (yani tabloda bu koşula uygun bir giriş varsa),
* 'Get the table index' mesajı yazdırılıyor ve indx değeri ile birlikte 'carrid = ''AZ'' connid = ''0555''' koşuluna uygun
* olan girişin tablodaki indeksi ekrana yazdırılıyor.
*Aksi takdirde, 'Data not found' (Veri bulunamadı) mesajı ekrana yazdırılıyor.
IF indx IS NOT INITIAL .
  WRITE :/ 'Get the table index' .
  WRITE :/ indx, 'is table index for carrid = ''AZ'' connid = ''0555'''.
ELSE .
  WRITE :/ 'Data not found' .
ENDIF.
************************************************************************************
