*&---------------------------------------------------------------------*
*& Report ZPK_INNERJOIN_2_CW2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INNERJOIN_2_CW2.
***********************************************************************
*                                                                      *
************************************************************************
* SBOOK + SCUSTOM (JOIING FIELD CUSTOMID)

INCLUDE ZPK_INNERJOIN_2_CW2_TOP.
INCLUDE ZPK_INNERJOIN_2_CW2_SCR.
INCLUDE ZPK_INNERJOIN_2_CW2_FORM.


START-OF-SELECTION.
perform select.

end-OF-SELECTION.
perform display.
