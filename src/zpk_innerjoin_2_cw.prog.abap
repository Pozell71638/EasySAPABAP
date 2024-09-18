*&---------------------------------------------------------------------*
*& Report ZPK_INNERJOIN_2_CW
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_innerjoin_2_cw.
*SCARR (PARENT TABLE) + SBOOK (CHILD TABLE) ( JOINING FIELD CARRID)

INCLUDE zpk_innerjoin_2_cw_top.
INCLUDE zpk_innerjoin_2_cw_scr.
INCLUDE zpk_innerjoin_2_cw_form.

START-OF-SELECTION.
perform select.

end-OF-SELECTION.
perform display.
