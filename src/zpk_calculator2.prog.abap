*&---------------------------------------------------------------------*
*& Report ZPK_CALCULATOR2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CALCULATOR2.


DATA: lv_number1 TYPE p DECIMALS 2,
      lv_number2 TYPE p DECIMALS 2,
      lv_result1 TYPE i, "P DECIMALS 2,
      lv_sign    TYPE c LENGTH 1.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_sign TYPE c LENGTH 1.

START-OF-SELECTION.
CALL FUNCTION 'ZPK_FM8'
  EXPORTING
    lv_number1       = p_num1
    lv_number2       = p_num2
    SIGN             = p_sign
 IMPORTING
   LV_RESULT        = lv_result1.

write / 'high'.
