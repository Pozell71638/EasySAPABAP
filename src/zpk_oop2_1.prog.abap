*&---------------------------------------------------------------------*
*& Report ZPK_OOP2_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP2_1.

INTERFACE pinar.
METHODS meth1.
ENDINTERFACE.


class shelton DEFINITION.
PUBLIC SECTION.
INTERFACEs pinar.
endclass.

class shelton IMPLEMENTATION.
 METHOD pinar~meth1.
 write: / 'this is a method from interface.' color 3.
 endmethod.
ENDCLASS.

START-OF-SELECTION.
data: obj1 type ref to shelton,
      obj2 type ref to pinar.

create object: obj1.

call method obj1->pinar~meth1.
