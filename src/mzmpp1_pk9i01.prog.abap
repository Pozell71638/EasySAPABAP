*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK9I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2006 INPUT.

IF  SY-UCOMM = 'SELECT'.
IF RB1 = 'X'.
TEXT1 = 'MALE'.
ENDIF.

IF RB2 = 'X'.
TEXT1 = 'FEMALE'.
ENDIF.
ENDIF.





ENDMODULE.
