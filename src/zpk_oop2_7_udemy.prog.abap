*&---------------------------------------------------------------------*
*& Report ZPK_OOP2_7_UDEMY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_oop2_7_udemy.

CLASS: lcl_animal DEFINITION DEFERRED,
       lcl_cat DEFINITION DEFERRED.
DATA:go_animal TYPE REF TO lcl_animal,
     go_cat    TYPE REF TO lcl_cat.

CLASS lcl_animal DEFINITION.
*  PUBLIC SECTION.
*    METHODS:
*      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i,
*      get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.
*    DATA:mv_legs TYPE i,
*         mv_arms TYPE i.
**--------------------------------------------------
*   PUBLIC SECTION.
*    METHODS:
*      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i.
*    DATA:mv_legs TYPE i.
*
*   PROTECTED SECTION.
*    METHODS:
*    get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.
*      DATA: mv_arms TYPE i.
*-------------------------------------------------------------

 PUBLIC SECTION.
    METHODS:
      get_number_of_legs RETURNING VALUE(rv_legs) TYPE i.
    DATA:mv_legs TYPE i.

   PRIVATE SECTION.
    METHODS:
    get_number_of_arms RETURNING VALUE(rv_arms) TYPE i.
      DATA: mv_arms TYPE i.





ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.
  METHOD get_number_of_legs.
    rv_legs = mv_legs.
  ENDMETHOD.

  METHOD get_number_of_arms.
    rv_arms = mv_arms.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_cat DEFINITION INHERITING FROM lcl_animal.
  PUBLIC SECTION.
    METHODS:
      constructor.
ENDCLASS.

CLASS lcl_cat IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    mv_legs = 4.
*   mv_arms = 0. PRIVATE DURUMUNDA IZIN VERMEDI; PUBLIC VE PROTECTED DA VERDI
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  CREATE OBJECT: go_animal,
                 go_cat.

*PROTECTED
*WRITE: go_animal->get_number_of_legs( ).
**WRITE: go_animal->get_number_of_arms( ).
*
*WRITE: go_cat->get_number_of_legs( ).
**WRITE: go_cat->get_number_of_arms( ).
*
**WRITE: go_cat->mv_arms.
*WRITE: go_cat->mv_legs.
*
**WRITE: go_animal->mv_arms.
*WRITE: go_animal->mv_legs.
*-------------------------------------------------------
*PUBLIC
*WRITE: go_animal->get_number_of_legs( ).
*WRITE: go_animal->get_number_of_arms( ).
*
*WRITE: go_cat->get_number_of_legs( ).
*WRITE: go_cat->get_number_of_arms( ).
*
*WRITE: go_cat->mv_arms.
*WRITE: go_cat->mv_legs.
*
*WRITE: go_animal->mv_arms.
*WRITE: go_animal->mv_legs.
*------------------------------------------------------
*PRIVATE
WRITE: go_animal->get_number_of_legs( ).
*WRITE: go_animal->get_number_of_arms( ).

WRITE: go_cat->get_number_of_legs( ).
*WRITE: go_cat->get_number_of_arms( ).

*WRITE: go_cat->mv_arms.
WRITE: go_cat->mv_legs.

*WRITE: go_animal->mv_arms.
WRITE: go_animal->mv_legs.
