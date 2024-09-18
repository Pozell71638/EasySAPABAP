*&---------------------------------------------------------------------*
*& Report ZPK_OBB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OBB.

CLASS A DEFINITION.
  PUBLIC SECTION.
  DATA: NAME TYPE C LENGTH 20.
  METHODS: METH1.
ENDCLASS.


CLASS A IMPLEMENTATION.
METHOD METH1.
  NAME = 'PINAR KIZILOGLU'.
  WRITE:/ NAME.
ENDMETHOD .
ENDCLASS.


START-OF-SELECTION.
DATA: OBJ TYPE REF TO A.
CREATE OBJECT OBJ.

CALL METHOD OBJ->meth1.
