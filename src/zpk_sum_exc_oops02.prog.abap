*&---------------------------------------------------------------------*
*& Report ZPK_SUM_EXC_OOPS02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_SUM_EXC_OOPS02.
"Ilk metoda gore Before exception yazis var. ve Catch blogu olmadan damph error veriyor.
CLASS lcl_abc DEFINITION .

  PUBLIC SECTION.
   METHODS m1 IMPORTING i_x TYPE i
                        i_y TYPE i
              EXPORTING e_z TYPE i .

ENDCLASS .

CLASS lcl_abc IMPLEMENTATION .

  METHOD m1 .
    WRITE :/ 'Begin of Method...' .
TRY.
    WRITE :/ 'Before Exception...' .
    e_z = i_x / i_y .

CLEANUP ."after the statemetn Cleanup, it is not possible to use the statement catch within a control strcuture with try
    WRITE :/ 'After Eexception...' ." burasi sifira bolunmez ise calisiyor ve cleanup pasif olucak,catch block aktif olucak.

*CATCH CX_root .                          " Super Class for all exception classes whcih is useful to handle the Exception

  MESSAGE 'Cannot divide by Zero' TYPE 'I' .
  WRITE :/ 'Within CATCH Block...' ." burasi catch block aktif oldugunda calisti.

ENDTRY .
    WRITE :/ 'End of Method...' .
  ENDMETHOD .

ENDCLASS .

START-OF-SELECTION .
DATA : ob TYPE REF TO lcl_abc ,
       v_z TYPE i .

CREATE OBJECT ob .

PARAMETERS : p_x TYPE i ,
             p_y TYPE i .

call  METHOD ob->m1
 EXPORTING
   i_x  = p_x
   i_y  = p_y
 IMPORTING
   e_z  = v_z .


WRITE :/ 'Division is' , v_z .
WRITE :/ 'End of Program...' .



*Bu program, iki sayı arasında bir bölme işlemi gerçekleştirir ve sonucu ekrana yazdırır. Ancak sıfıra bölme hatası durumunda uygun bir hata mesajı gösterir. İşte programın adımları:
*
*CLASS lcl_abc tanımlanır ve m1 adında bir metodu içerir.
*m1 metodu, i_x ve i_y adında iki giriş parametresi ve e_z adında bir çıkış parametresi alır.
*Metod içinde, TRY ... ENDTRY bloğu başlatılır. Bu, programın belirli bir hataya kadar çalışmasını sağlar ve hatanın oluştuğu noktada programın kontrolünü alır.
*TRY bloğunun içinde, bölme işlemi gerçekleştirilir (e_z = i_x / i_y). Ancak, bu blok içinde yazılmış bir "CLEANUP" bloğu görünüyor, ancak herhangi bir temizlik işlemi yok.
*Eğer bir hata oluşursa, CATCH bloğu devreye girer.
*CATCH CX_root ifadesi, tüm istisna sınıflarını yakalar. Ancak, yakalanan hatanın türüne göre özel bir mesaj gösterilmez, bu nedenle hatanın ne olduğunu belirlemek zor olabilir.
*Hata yakalandığında, bir mesaj gösterilir ve işlem sonlandırılır.
*START-OF-SELECTION bölümünde, bir lcl_abc sınıfından bir nesne oluşturulur ve m1 metodu çağrılır.
*Kullanıcıdan p_x ve p_y adında iki sayı alınır ve bu sayılar m1 metodu çağrısına geçirilir.
*Sonuç ekrana yazdırılır.
