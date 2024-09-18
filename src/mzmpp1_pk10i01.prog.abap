*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK10I01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2007  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2007 INPUT.
 TEXT1 = ' '.

IF  SY-UCOMM = 'SELECT'.
IF CB1 = 'X'.
CONCATENATE TEXT1 KA1 INTO TEXT1 SEPARATED BY ' '.
ENDIF.

IF CB2 = 'X'.
CONCATENATE TEXT1 DO1 INTO TEXT1 SEPARATED BY ' '.
ENDIF.

IF CB3 = 'X'.
CONCATENATE TEXT1 PI1 INTO TEXT1 SEPARATED BY ' '.
ENDIF.

IF CB4 = 'X'.
CONCATENATE TEXT1 CKB INTO TEXT1 SEPARATED BY ' '.
ENDIF.
ENDIF.
ENDMODULE.
