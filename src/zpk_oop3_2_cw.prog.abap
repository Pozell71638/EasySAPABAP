*&---------------------------------------------------------------------*
*& Report ZPK_OOP3_2_CW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP3_2_CW.
*2-create a public class wih instance and static method and call them in my program.
*the name of the class is sofia

class sofia DEFINITION.
  PUBLIC SECTION.
  methods: instance_method.
  class-METHODS:static_method.

  endclass.

  class sofia IMPLEMENTATION.
  method instance_method.
  write:/ 'this is instance method of class sofia' color 3.
    endmethod.

    method static_method.
  write:/ 'this is static method of class sofia' color 1.
      endmethod.
  ENDCLASS.

START-OF-SELECTION.
  data: obj type ref to sofia.
  create object obj.
  call method: obj->instance_method.
*               obj->disp." since meth disp is static it shoub be call by the calss itself

  call method sofia=>static_method.
