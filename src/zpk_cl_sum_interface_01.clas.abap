class ZPK_CL_SUM_INTERFACE_01 definition
  public
  final
  create public .

public section.

  interfaces ZPK_IF_SUM_INTERFACE_01 .
protected section.

  data RES type I .
private section.
ENDCLASS.



CLASS ZPK_CL_SUM_INTERFACE_01 IMPLEMENTATION.


  method ZPK_IF_SUM_INTERFACE_01~AREA.
    res = ZPK_IF_SUM_INTERFACE_01~length * ZPK_IF_SUM_INTERFACE_01~breadgth .
    WRITE :/ 'Area of Rectangle :', res .
  endmethod.


  method ZPK_IF_SUM_INTERFACE_01~PERIMETER.

    res = 2 * ( ZPK_IF_SUM_INTERFACE_01~length * ZPK_IF_SUM_INTERFACE_01~breadgth ) .
    WRITE :/ 'Perimeter of Rectangle :', res .


  endmethod.
ENDCLASS.
