*&---------------------------------------------------------------------*
*& Report ZPK_STRING_EXPR_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_STRING_EXPR_DEMO.
Data : lv_str1 TYPE String ,
       lv_str_1 TYPE string ,
       lv_str2 TYPE string ,
       lv_str3 TYPE string .

LV_str1 = 'Shelton' .
lv_str_1 = 'Pinar' .
lv_str2 = 'Learning SAP ABAP' .

CL_demo_output=>write( '************************** Using concatenation ***********************' ).

CONCATENATE lv_str1 lv_Str2 INTO lv_str3 SEPARATED BY space .

cl_demo_output=>write( lv_Str3 ) .

CL_demo_output=>write( '************************** Using 7.4 ABAP syntax && ***********************' ).

CLEAR : lv_str3 .
****lv_str3 = lv_str_1 && ' ' && lv_str2 .
lv_str3 = lv_str_1 && lv_str2 .

cl_demo_output=>write( lv_Str3 ) .


CL_demo_output=>write( '************************** Using 7.4 ABAP syntax && and with Integer values***********************' ).

DATA(lv_str4) = 1 && 1 .

cl_demo_output=>write( lv_Str4 ) .


CL_demo_output=>write( '************************** Using 7.4 ABAP syntax String Templates ***********************' ).

CL_demo_output=>write( '************************** |{ lv_str1 }{ lv_str2 }| ***********************' ).

DATA(lv_str5) = |{ lv_str1 }{ lv_str2 }| .

cl_demo_output=>write( lv_Str5 ) .

CL_demo_output=>write( '************************** Using 7.4 ABAP syntax String Templates ***********************' ).

CL_demo_output=>write( '************************** |{ lv_str_1 } { lv_str2 }| ***********************' ).

DATA(lv_str6) = |{ lv_str_1 } { lv_str2 }| .

cl_demo_output=>write( lv_Str6 ) .

CL_demo_output=>write( '************************** |Today Date: { sy-datum }| ***********************' ).

DATA(lv_str7) = |Today Date: { sy-datum }| .
cl_demo_output=>write( lv_Str7 ) .

CL_demo_output=>write( '************************** |Today Date: { sy-datum date = user }| ***********************' ).

DATA(lv_str8) = |Today Date: { sy-datum DATE = USER }| .
cl_demo_output=>write( lv_Str8 ) .

CL_demo_output=>write( '************************** |Today Date: { sy-datum date = user }| ***********************' ).

DATA(lv_str9) = |Today Time: { sy-uzeit TIME = USER  }| .
cl_demo_output=>write( lv_Str9 ) .





cl_demo_output=>display( ).
