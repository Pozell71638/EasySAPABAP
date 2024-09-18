*&---------------------------------------------------------------------*
*& Report ZPK_SUM_EXC_OOPS01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_SUM_EXC_OOPS01.

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
    e_z = i_x / i_y .
    WRITE : 'After Immidiate exceptin' .

*CATCH CX_SY_ZERODIVIDE .                 " Actual Exception Class for Dividing Zero Runtime Dump
*CATCH cx_sy_assign_error .               " Some Random Class which is not useful to handle the Exception.damph error
*CATCH CX_SY_ARITHMETIC_ERROR  .          " One of the Parent/Super Class whcih is useful to handle the Exception
CATCH CX_root .                          " Super Class for all exception classes whcih is useful to handle the Exception

  MESSAGE 'Cannot divide by Zero' TYPE 'I' .

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

*Bu program, verilen iki sayının bölümünü hesaplar ve sonucu ekrana yazdırır. Ancak sıfıra bölme hatası (zero divide error) durumunda program uygun bir hata mesajı gösterir. İşte programın adımları:
*
*CLASS lcl_abc tanımlanır ve m1 adında bir metod içerir.
*m1 metodu, i_x ve i_y adında iki giriş parametresi ve e_z adında bir çıkış parametresi alır.
*Metod içinde, TRY ... ENDTRY bloğu başlatılır. Bu, programın belirli bir hataya kadar çalışmasını sağlar ve hatanın oluştuğu noktada programın kontrolünü alır.
*TRY bloğunun içinde, e_z = i_x / i_y ifadesi ile bölme işlemi gerçekleştirilir.
*Eğer bir hata oluşursa, CATCH bloğu devreye girer.
*CATCH CX_SY_ZERODIVIDE ifadesi, sıfıra bölme hatası durumunda çalışır. Ancak bu ifade kapatılmış görünüyor. Bunun yerine, CX_SY_ARITHMETIC_ERROR ifadesi kullanılmış. Bu hatayı yakalamak için daha genel bir hata sınıfı.
*Hata yakalandığında, bir mesaj gösterilir ve işlem sonlandırılır.
*START-OF-SELECTION bölümünde, bir lcl_abc sınıfından bir nesne oluşturulur ve m1 metodu çağrılır.
*Kullanıcıdan p_x ve p_y adında iki sayı alınır ve bu sayılar m1 metoduna gönderilir.
*Sonuç ekrana yazdırılır.
