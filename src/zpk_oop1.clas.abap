class ZPK_OOP1 definition
  public
  final
  create public .

public section.

  methods ADDITION
    importing
      !A type I
      !B type I
    exporting
      !C type I .
protected section.
private section.
ENDCLASS.



CLASS ZPK_OOP1 IMPLEMENTATION.


  METHOD addition.
    IF a LT b.
      MESSAGE 'PLEASE ENTER A HIGHER VALUE' TYPE 'I'.
    ELSE.
      c = a + b.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
