*&---------------------------------------------------------------------*
*& Report ZPK_OOP1_4_CW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_oop1_4_cw.


*CREATE FOUR CLASSES
*CLASSS A; B;C;D
*
*A;B;C WILL BE CONNECTED WITH INHERITENCE
*D WILL BE A SEPARATE CLASS
*ALL THE CLASS WILL HAVE A CONSTRUCTOR
*i WILL CREATE AN OBJECT FOR METHOD C AND D ONLY AND CALL ITS(C) METHOD


*&---------------------------------------------------------------------*
*& Class A
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS a DEFINITION.
  PUBLIC SECTION.
  METHODS: method_a,
    constructor.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) A
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS a IMPLEMENTATION.

  method method_a.
 write:/ 'Hello from Method_a' color 4.
 ENDMETHOD.

  method constructor.
 write:/ 'Hello from Method_a-Constructor' color 5.
  endmethod.

ENDCLASS.
*&---------------------------------------------------------------------*
*& Class B
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS b DEFINITION iNHERITING FROM a.
  PUBLIC SECTION.
  METHODS: method_b,
         constructor.
    endclass.
*&---------------------------------------------------------------------*
*& Class (Implementation) B
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS b IMPLEMENTATION.
  method method_b.
  write:/ 'Hello from Method_b' color 1.
 ENDMETHOD.

  method constructor.
    call method super->constructor.
 write:/ 'Hello from Method_b-Constructor' color 3.
ENDMETHOD.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class C
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS cc DEFINITION iNHERITING FROM b.
  PUBLIC SECTION.
methods: method_cc,
         constructor.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) C
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS cc IMPLEMENTATION.
  method method_cc.
  write:/ 'Hello from Method_c' color 2.
 ENDMETHOD.

  method constructor.
    call method super->constructor.
 write:/ 'Hello from Method_c-Constructor' color 6.
ENDMETHOD.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class D
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS dd DEFINITION.
  PUBLIC SECTION.
methods: method_dd,
         constructor.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) D
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS dd IMPLEMENTATION.
  method method_dd.
  write:/ 'Hello from Method_d' color 1.
 ENDMETHOD.

  method constructor.
 write:/ 'Hello from Method_d-Constructor' color 7.
 ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
data: ccc TYPE REF TO cc,
      ddd type REF TO dd.

 create object: ccc,
                ddd.

ccc->method_cc( ).
