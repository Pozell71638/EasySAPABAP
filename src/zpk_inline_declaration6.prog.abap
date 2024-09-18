*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION6.

DATA : lv_lzero TYPE char10 VALUE '0000000291' ,
       Lv_nzero TYPE char10 VALUE '555' ,
       lv_message type string .


lv_message = |{ lv_lzero ALPHA = OUT }|.     " It will remove the leading zero's from the variable LV_LZERO and result captured into LV_MESSAGE.

WRITE :/ lv_message .


lv_message = |{ lv_nzero ALPHA = IN }|.

WRITE :/ lv_message.

************************************************************************************************************
*Bu kod bloğunda, alfasayısal bir değişkenin önündeki sıfırları kaldırmak ve sonucu başka bir değişkene atamak için SAP ABAP dize işlevlerini kullanıyoruz.
***lv_message = |{ lv_lzero ALPHA = OUT }|.   " LV_LZERO değişkeninin önündeki sıfırları kaldıracak ve sonucu LV_MESSAGE değişkenine atacak.
***
***WRITE :/ lv_message .   " Sonucu yazdır.

***lv_message = |{ lv_nzero ALPHA = IN }|.   " LV_NZERO değişkeninin önüne sıfır ekleyecek ve sonucu LV_MESSAGE değişkenine atayacak.
***
***WRITE :/ lv_message .   " Sonucu yazdır.
************************************************************************************************************
