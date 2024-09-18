*&---------------------------------------------------------------------*
*& Report ZPK_OOP1_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP1_3.
*&---------------------------------------------------------------------*
*& Class lcl_animal
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_animal DEFINITION.
PUBLIC SECTION.
METHODS:
get_number_of_legs.
ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) lcl_animal
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_animal IMPLEMENTATION.
METHOD get_number_of_legs.
  Write:  / '4' COLOR 1.
ENDMETHOD.
ENDCLASS.


*&---------------------------------------------------------------------*
*& Class lcl_cat
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
PUBLIC SECTION.
METHODS: METH2,
        get_number_of_legs REDEFINITION.

ENDCLASS.
*&---------------------------------------------------------------------*
*& Class (Implementation) lcl_cat
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
CLASS lcl_cat IMPLEMENTATION.
 METHOD METH2.
   WRITE : / 'The Number of Legs of a Cat' COLOR 6.
 ENDMETHOD.
 METHOD get_number_of_legs.
  write : / 'FOUR' COLOR 3.
   ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

START-OF-SELECTION.
DATA: OBJ1 TYPE REF TO lcl_animal,
      OBJ2 TYPE REF TO lcl_cat.

CREATE OBJECT: OBJ1 ,
               OBJ2  .

CALL METHOD OBJ1->get_number_of_legs.

CALL METHOD OBJ2->meth2.
CALL METHOD OBJ2->get_number_of_legs.
