*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK16I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2012  INPUT
*&---------------------------------------------------------------------*
*       text

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2013  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2023  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE user_command_2023 INPUT.
*  CASE sy-ucomm.
*    WHEN 'LOG1'.
*      SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
*        FROM zpk_employer_t
*        INTO wa   WHERE  EMPLOYER_id = zpk_employer_t-EMPLOYER_id AND
*              EMPLOYER_password = zpk_employer_t-EMPLOYER_password.
*      IF sy-subrc = 0.
*        IF zpk_employer_t-employer_name = 'ADMIN'.
*          CALL SCREEN 2024.
*
*        ENDIF.
*      ELSE.
*        CALL SCREEN 2025.
*      ENDIF.
*
*    WHEN'CLEAR1'.
*      CLEAR:zpk_employer_t-EMPLOYER_id, zpk_employer_t-employer_name, zpk_employer_t-EMPLOYER_password.
*    WHEN 'EXIT1'.
*      LEAVE PROGRAM.
*
*  ENDCASE.

*ENDMODULE.
**&---------------------------------------------------------------------*
**&      Module  USER_COMMAND_2024  INPUT
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*MODULE user_command_2024 INPUT.
*
*  WRITE:/ 'WELCOME TO ADMIN PAGE.'.
*  MESSAGE 'Admin Login Successful' TYPE 'I'.
*
*
*
*
*
*ENDMODULE.


MODULE user_command_2025 INPUT.

CASE SY-UCOMM.
  WHEN 'BACK2'.
    LEAVE TO SCREEN 0.
    ENDCASE.

  WRITE:/ 'WELCOME TO THE TEACHER OVERVIEW SCREEN.'.
  MESSAGE ' Login Successful' TYPE 'I'.




ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2023  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2023 INPUT.
CASE sy-ucomm.
    WHEN 'LOG1'.
      IF zpk_employer_t-employer_ID = 'E04' AND
        zpk_employer_t-EMPLOYER_password = 'ADMIN123'.
          CALL SCREEN 2024.
       ENDIF.

      SELECT SINGLE * "EMPLOYER_ID EMPLOYER_NAME EMPLOYER_PASSWORD
        FROM zpk_employer_t
        INTO wa   WHERE  EMPLOYER_id = zpk_employer_t-EMPLOYER_id AND
              EMPLOYER_password = zpk_employer_t-EMPLOYER_password.
      IF sy-subrc = 0.
        CALL SCREEN 2025.
      ENDIF.

    WHEN'CLEAR1'.
      CLEAR:zpk_employer_t-EMPLOYER_id, zpk_employer_t-employer_name, zpk_employer_t-EMPLOYER_password.
    WHEN 'EXIT1'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2024  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2024 INPUT.
CASE SY-UCOMM.
  WHEN 'BACK1'.
    LEAVE TO SCREEN 0.
    ENDCASE.
ENDMODULE.
