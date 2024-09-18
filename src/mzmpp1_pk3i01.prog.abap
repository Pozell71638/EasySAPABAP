*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK3I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2002  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2002 INPUT.

  CASE SY-UCOMM.
  WHEN 'DISP1'.
    SELECT SINGLE MATERIAL_ID MATERIAL_NAME DOM DOE COST
      FROM ZPK_MATERIAL_T
      INTO (ZPK_MATERIAL_T-MATERIAL_ID, ZPK_MATERIAL_T-MATERIAL_NAME, ZPK_MATERIAL_T-DOM, ZPK_MATERIAL_T-DOE, ZPK_MATERIAL_T-COST )
      WHERE MATERIAL_ID = ZPK_MATERIAL_T-MATERIAL_ID.

  WHEN 'CLEAR1'.
    CLEAR: ZPK_MATERIAL_T-MATERIAL_ID, ZPK_MATERIAL_T-MATERIAL_NAME, ZPK_MATERIAL_T-DOM, ZPK_MATERIAL_T-DOM, ZPK_MATERIAL_T-DOE, ZPK_MATERIAL_T-COST.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
  WHEN 'SAVE1'.
    PERFORM SAVE.

  WHEN 'CHANGE1'.
    perform change.

ENDCASE.
ENDMODULE.
