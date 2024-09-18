*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK2I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2001 INPUT.


CASE SY-UCOMM.
  WHEN 'DISP1' .
    SELECT SINGLE KUNNR LAND1 NAME1 ORT01 PSTLZ REGIO FROM KNA1
      INTO (KNA1-KUNNR, KNA1-LAND1, KNA1-NAME1, KNA1-ORT01, KNA1-PSTLZ, KNA1-REGIO )
      WHERE KUNNR = KNA1-KUNNR.

  WHEN 'CLEAR1'.
    CLEAR:KNA1-KUNNR, KNA1-LAND1, KNA1-NAME1, KNA1-ORT01, KNA1-PSTLZ, KNA1-REGIO.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
