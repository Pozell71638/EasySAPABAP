*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK20I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2020  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2020 INPUT.
  CASE sy-ucomm.
    WHEN 'TAB1'.
      PINAR3-activetab = 'TAB1'.
    WHEN 'TAB2'.
      PINAR3-activetab = 'TAB2'.
    WHEN 'EXIT1'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.



MODULE user_command_2021 INPUT.

  CASE sy-ucomm.
    WHEN 'TAB2'.
      SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
        FROM zpk_employer_t
        INTO wa   WHERE  EMPLOYER_id = zpk_employer_t-EMPLOYER_id AND
              EMPLOYER_password = zpk_employer_t-EMPLOYER_password.
      IF sy-subrc = 0.
        IF zpk_employer_t-employer_name = 'ADMIN'.
          WRITE:/ 'WELCOME TO ADMIN PAGE.'.
          MESSAGE 'Admin Login Successful' TYPE 'I'.

        ENDIF.
      ELSE.
        MESSAGE ' Please check your details' TYPE 'I'.
      ENDIF.
ENDCASE.
ENDMODULE.

MODULE user_command_2022 INPUT.

  CASE sy-ucomm.
    WHEN 'TAB3'.

      IF sy-subrc = 0.
        IF zpk_employer_t-employer_name NE 'ADMIN'.
          WRITE:/ 'WELCOME TO THE TEACHER OVERVIEW SCREEN.'.
          MESSAGE ' Login Successful' TYPE 'I'.

        ENDIF.
      ELSE.
        MESSAGE ' Please check your details' TYPE 'I'.
      ENDIF.
ENDCASE.

ENDMODULE.
