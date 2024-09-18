*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK11I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2008  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2008 INPUT.
CASE SY-UCOMM.
  WHEN 'ADD1'.
    C = A + B.

    WHEN 'SUB1'.
      IF B GT A.
        MESSAGE 'PLEASE CHANGE THE VALUES' TYPE 'I'.
        ELSE.
    C = A - B.
ENDIF.


  WHEN 'MUL1'.
    C = A * B.

  WHEN 'EXIT1'.
    LEAVE PROGRAM.
ENDCASE.


ENDMODULE.
