*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK17I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2014  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2014 INPUT.

  CASE SY-UCOMM.
  WHEN 'TAB1'.
    PINAR1-activetab = 'TAB1'.
  WHEN 'TAB2'.
    PINAR1-activetab = 'TAB2'.
  WHEN 'EXIT1'.
      LEAVE PROGRAM.
      ENDCASE.


ENDMODULE.
