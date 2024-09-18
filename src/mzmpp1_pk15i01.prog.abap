*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK15I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2011  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2011 INPUT.
  IF sy-ucomm = 'ENTER1'.
  IF X3 = gv_user-username AND Y3 = gv_user-password.
    PERFORM display_user_screen.
  ELSEIF X3 = gv_admin-username AND Y3 = gv_admin-password.
    PERFORM display_admin_screen.
  ELSE.
    WRITE: / 'Wrong username or password!'.
  ENDIF.
ENDIF.
*case sy-ucomm.
*  when 'EXIT1'.
*    leave PROGRAM.
*    WHEN 'NEXT1'.
*      CALL TRANSACTION 'ZSHP9'.
*    endcase.

ENDMODULE.
