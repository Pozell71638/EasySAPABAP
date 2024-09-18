class ZPK_OOP2 definition
  public
  final
  create public .

public section.

  methods EXTRACTION
    importing
      !A type I
      !B type I
    exporting
      !C type I .
protected section.
private section.
ENDCLASS.



CLASS ZPK_OOP2 IMPLEMENTATION.


  method EXTRACTION.
    if A LT B .
      MESSAGE 'PLEASE ENTER A HIGHER VALUE ' TYPE 'I'.
      else.
        c = a - b.
        endif.


  endmethod.
ENDCLASS.
