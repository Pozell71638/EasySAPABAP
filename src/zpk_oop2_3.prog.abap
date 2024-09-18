*&---------------------------------------------------------------------*
*& Report ZPK_OOP2_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP2_3.

INTERFACE shelton1.
 methods meth1.
 ENDINTERFACE.

 INTERFACE shelton2.
 INTERFACEs shelton1.
 methods meth2.
 ENDINTERFACE.


class tom DEFINITION.
 PUBLIC SECTION.
 INTERFACEs shelton2.
 endclass.

 class tom IMPLEMENTATION.
   method shelton1~meth1.
   write:/ 'this is shelton 1 interface' color 2.
   ENDMETHOD.

   method shelton2~meth2.
   write:/ 'this is shelton 2 interface' color 3.
     ENDMETHOD.
     endclass.

START-OF-SELECTION.
  data: obj1 TYPE REF TO tom.

  CREATE OBJECT obj1.
  call method obj1->shelton1~meth1.
  call method obj1->shelton2~meth2.
