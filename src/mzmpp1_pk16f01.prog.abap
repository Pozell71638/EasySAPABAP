*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK16F01
*&---------------------------------------------------------------------*
FORM save .
  wa-employer_id = zpk_employer_t-employer_id .
  wa-employer_name = zpk_employer_t-employer_name.
  wa-employer_password = zpk_employer_t-employer_password.


  INSERT zpk_employer_t FROM wa.
  IF sy-subrc = 0.
    MESSAGE: 'INSTERT SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'INSTERT UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
endform.
*&---------------------------------------------------------------------*
*& Form CHANGE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM change .
  wa-employer_id = zpk_employer_t-employer_id .
  wa-employer_name = zpk_employer_t-employer_name.
  wa-employer_password = zpk_employer_t-employer_password.


  UPDATE zpk_employer_t FROM wa.
  IF sy-subrc = 0.
    MESSAGE: 'update SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'UPDAATE UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.
