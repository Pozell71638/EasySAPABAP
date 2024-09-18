*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK7I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2005  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2005 INPUT.


  txt_likes = ' '.

IF sy-ucomm = 'FCT_LIKES'.
  if CB_NAAN_CG = 'X'.
CONCATENATE txt_likes NAAN_CG into txt_likes SEPARATED BY ','.
ENDIF.

if CB_CH_BIR = 'X'.
CONCATENATE txt_likes CH_BIR into txt_likes SEPARATED BY ','.
ENDIF.

if CB_CM_PAR = 'X'.
CONCATENATE txt_likes CM_PAR into txt_likes SEPARATED BY ','.
ENDIF.

ENDIF.



ENDMODULE.
