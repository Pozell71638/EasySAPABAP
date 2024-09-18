*&---------------------------------------------------------------------*
*& Report ZPK_SUM_INTERFACE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_SUM_INTERFACE_02.
DATA : r TYPE REF TO ZPK_IF_SUM_INTERFACE_01 .

***CREATE OBJECT r .  " Syntax error

DATA : ob TYPE REF TO ZPK_CL_SUM_INTERFACE_01 .
CREATE OBJECT ob .



call METHOD : ob->ZPK_IF_SUM_INTERFACE_01~area ,
              ob->ZPK_IF_SUM_INTERFACE_01~perimeter.

***ULINE .
***WRITE :/ 'Implementation class object Ob --> assigned to interface rectangle reference r' .
***
***r = ob . " Narrow Casting
***
***CALL METHOD : r->area ,
***              r->perimeter .


*Bu kod parçası, ZIF_SUM_INTERFACE_01 adlı bir arayüz ve ZCL_SUM_INTERFACE_01 adında bir sınıf tanımlar. Arayüz, bir dikdörtgenin alanını ve çevresini hesaplamak için gerekli olan iki yöntemi içerir.
*
*Daha sonra, ob adında ZCL_SUM_INTERFACE_01 sınıfından bir referans nesne oluşturulur. Bu nesne, arayüzün yöntemlerini çağırmak için kullanılır.
*
*Ancak, yorum satırı nedeniyle CREATE OBJECT r. satırı işlevsizdir. Yorum satırı olmadan kullanılırsa, bu satır bir ZIF_SUM_INTERFACE_01 arayüzüne sahip bir nesne oluşturur.
*
*CALL METHOD ifadeleri, sınıfın arayüzü uygulayıp uygulamadığına bakmaksızın, ob nesnesinin arayüzün yöntemlerini çağırır. Bu, polimorfizm özelliğinden yararlanır.
*
*Yorum satırlarındaki ULINE ve WRITE ifadeleri kullanılmıyor, bu nedenle kod bu satırları çalıştırmaz.
*
*r = ob. ifadesi, ob nesnesinin ZIF_SUM_INTERFACE_01 arayüzüne atamasını yapar. Bu, dar (narrow) dönüştürme (casting) işlemidir.
*
*Son olarak, CALL METHOD: r->area, r->perimeter. ifadeleri, r referans nesnesinin arayüz yöntemlerini çağırır. Bu ifadeler, dar dönüştürme sonucunda ob nesnesinin arayüzünü kullanan r nesnesinin yöntemlerini çağırmaktadır.
