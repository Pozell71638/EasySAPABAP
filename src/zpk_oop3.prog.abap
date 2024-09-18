*&---------------------------------------------------------------------*
*& Report ZPK_OOP3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP3.

class hari DEFINITION.
  PUBLIC SECTION.
  METHODS: METH1.
ENDCLASS.

CLASS HARI IMPLEMENTATION.
  METHOD METH1.
   WRITE: / 'METHOD METH1 FROM CLASS HARI' COLOR 1.
  ENDMETHOD.
ENDCLASS.

************************
*                                                                      *
************************

class sam DEFINITION.
 PUBLIC SECTION.
 METHODS: METH2.
   ENDCLASS.

 CLASS SAM IMPLEMENTATION.
 METHOD METH2.
    WRITE: / 'METHOD METH2 FROM CLASS SAM' COLOR 6.
 ENDMETHOD.
 ENDCLASS.

************************
*                                                                      *
************************
START-OF-SELECTION.
DATA: OBJ1 TYPE REF TO HARI,
      OBJ2 TYPE REF TO SAM.

CREATE OBJECT: OBJ1 ,
               OBJ2  .

CALL METHOD OBJ1->meth1.

CALL METHOD OBJ2->meth2.
