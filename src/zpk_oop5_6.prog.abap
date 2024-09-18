*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_6.
CLASS TOM DEFINITION.
  PUBLIC SECTION.
 EVENTS: HUNTING.
 METHODS: meth1 FOR EVENT hunting OF tom.
 METHODS: meth2.
  ENDCLASS.


  CLASS TOM IMPLEMENTATION.
  METHOD meth1.
    WRITE:/ 'the event handler method' COLOR 5.
    endmethod.
    method meth2.
   WRITE:/ 'method to raise event event1' COLOR 7.
   RAISE EVENT hunting.
    endmethod.
   ENDCLASS.

START-OF-SELECTION.
  DATA: object1 TYPE REF TO tom.
  CREATE OBJECT object1.

  SET HANDLER object1->meth1 FOR object1.
  CALL METHOD object1->meth2.
