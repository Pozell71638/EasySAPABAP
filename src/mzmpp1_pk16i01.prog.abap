*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK16I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2012  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2012 INPUT.

  CASE sy-ucomm.
    WHEN 'LOG1'.
      SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
        FROM zpk_employer_t
        INTO wa   WHERE  EMPLOYER_id = zpk_employer_t-EMPLOYER_id AND
              EMPLOYER_password = zpk_employer_t-EMPLOYER_password.
      IF sy-subrc = 0.
        MESSAGE 'Admin Login Successful' TYPE 'I'.
        CALL SCREEN 2013.

      ELSE.
        MESSAGE ' Please check your details' TYPE 'I'.
      ENDIF.



    WHEN'CLEAR1'.
      CLEAR:zpk_employer_t-EMPLOYER_id, zpk_employer_t-employer_name, zpk_employer_t-EMPLOYER_password.
    WHEN 'EXIT1'.
      LEAVE PROGRAM.
    WHEN 'SAVE1'.
      PERFORM save.
    WHEN 'CHANGE1'.
      PERFORM change.
*
*
*
*      WHEN 'EXIT1'.
*        LEAVE PROGRAM.
*      WHEN 'LOG1'.
*        CALL TRANSACTION 'ZSHP15'.
  ENDCASE.




ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2013  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2013 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT1'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
