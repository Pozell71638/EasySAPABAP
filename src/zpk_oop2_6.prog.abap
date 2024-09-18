*&---------------------------------------------------------------------*
*& Report ZPK_OOP2_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP2_6.
class tom DEFINITION.
  PUBLIC SECTION.
  methods: show.
  class-METHODS:disp.

  endclass.

  class tom IMPLEMENTATION.
  method show.
  write:/ 'this is instance method of class tom' color 2.
    endmethod.

    method disp.
  write:/ 'this is static method of class tom' color 6.
      endmethod.
  ENDCLASS.

START-OF-SELECTION.
  data: obj type ref to tom.
  create object obj.
  call method: obj->show.
*               obj->disp." since meth disp is static it shoub be call by the calss itself

  call method tom=>disp.
