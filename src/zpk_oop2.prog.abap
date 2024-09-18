*&---------------------------------------------------------------------*
*& Report ZPK_OOP2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP2.

class pinar DEFINITION.
  PUBLIC SECTION.
  methods: meth1,
           constructor.

ENDCLASS.

class pinar IMPLEMENTATION.
  method meth1.
   write:/ 'This is a normal method' color 2 .
 ENDMETHOD.

 method constructor.
   Write:/ 'This is a special method called Constructor' color 6.
ENDMETHOD.
  endclass.

 START-OF-SELECTION.
  data: shelton type ref to pinar.
  create OBJECT shelton.

  call method shelton->meth1.
