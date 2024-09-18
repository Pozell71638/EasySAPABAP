*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK1I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2000 INPUT.



CASE SY-UCOMM.
  WHEN 'DISP1' .
    SELECT SINGLE NAME FORM STREET FROM SCUSTOM
      INTO (SCUSTOM-NAME, SCUSTOM-FORM, SCUSTOM-STREET)
      WHERE ID = SCUSTOM-ID.

  WHEN 'CLEAR1'.
    CLEAR:SCUSTOM-NAME, SCUSTOM-FORM, SCUSTOM-STREET, SCUSTOM-ID.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
ENDCASE.
ENDMODULE.
