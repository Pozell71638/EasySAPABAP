*&---------------------------------------------------------------------*
*& Report ZPK_OOP1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP1.


CLASS A1 DEFINITION.
  PUBLIC SECTION.
*  DATA: NUM1 TYPE I,
*        NUM2 TYPE I,
*        NUM3 TYPE I.
  METHODS: MUL
  IMPORTING num1 type i
            num2 type i
  EXPORTING num3 type i.




ENDCLASS.


CLASS A1 IMPLEMENTATION.
METHOD MUL.
  NUM3 = NUM1 * NUM2.
*  WRITE:/ NUM3.
ENDMETHOD .
ENDCLASS.


START-OF-SELECTION.
PARAMETERS: A TYPE I,
            B TYPE I.

DATA result TYPE i.

DATA: OBJ TYPE REF TO A1.

CREATE OBJECT OBJ.

CALL METHOD OBJ->mul
exporting num1 = a
          num2 = b
IMPORTING num3 = result.

write: / result.
