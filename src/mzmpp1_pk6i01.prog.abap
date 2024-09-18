*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK6I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2004  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2004 INPUT.

*
  CASE SY-UCOMM.
  WHEN 'DISP1'.
    SELECT SINGLE POLICY_ID HOLDER_NAME PREMIUM_AMOUNT DATE_OF_CREATION DATE_OF_PAYMENT CITY COUNTRY
    FROM ZPK_INSURANCE_T2
      INTO (ZPK_INSURANCE_T2-POLICY_ID, ZPK_INSURANCE_T2-HOLDER_NAME, ZPK_INSURANCE_T2-PREMIUM_AMOUNT, ZPK_INSURANCE_T2-DATE_OF_CREATION,
ZPK_INSURANCE_T2-DATE_OF_PAYMENT, ZPK_INSURANCE_T2-CITY, ZPK_INSURANCE_T2-COUNTRY)

      WHERE POLICY_ID = ZPK_INSURANCE_T2-POLICY_ID.

  WHEN 'CLEAR1'.
    CLEAR: ZPK_INSURANCE_T2-POLICY_ID, ZPK_INSURANCE_T2-HOLDER_NAME, ZPK_INSURANCE_T2-PREMIUM_AMOUNT, ZPK_INSURANCE_T2-DATE_OF_CREATION,
ZPK_INSURANCE_T2-DATE_OF_PAYMENT, ZPK_INSURANCE_T2-CITY, ZPK_INSURANCE_T2-COUNTRY.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
  WHEN 'SAVE1'.
    PERFORM SAVE.

  WHEN 'CHANGE1'.
    perform change.

ENDCASE.





ENDMODULE.
