*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK19I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2017  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2017 INPUT.
*
  CASE SY-UCOMM.
  WHEN 'TAB1'.
    PINAR2-activetab = 'TAB1'.
  WHEN 'TAB2'.
    PINAR2-activetab = 'TAB2'.
  WHEN 'EXIT1'.
      LEAVE PROGRAM.
      ENDCASE.



ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2018  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2018 INPUT.
CASE SY-UCOMM.
  WHEN 'TAB2' .
    SELECT SINGLE KUNNR LAND1 NAME1 ORT01  FROM KNA1
      INTO (KNA1-KUNNR, KNA1-LAND1, KNA1-NAME1, KNA1-ORT01 )
      WHERE KUNNR = KNA1-KUNNR.

  WHEN 'CLEAR1'.
    CLEAR:KNA1-KUNNR, KNA1-LAND1, KNA1-NAME1, KNA1-ORT01.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
