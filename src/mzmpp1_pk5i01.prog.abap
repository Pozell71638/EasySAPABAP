*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK5I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2003  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_2003 INPUT.


  CASE SY-UCOMM.
  WHEN 'DISP1'.
    SELECT SINGLE SUPPLIER_ID SUPPLIER_NAME COMPANY_NAME ORDER_PRICE ORDER_QTY DOM
      FROM ZPK_SUPPLIER_T2
      INTO (ZPK_SUPPLIER_T2-SUPPLIER_ID, ZPK_SUPPLIER_T2-SUPPLIER_NAME, ZPK_SUPPLIER_T2-COMPANY_NAME, ZPK_SUPPLIER_T2-ORDER_PRICE, ZPK_SUPPLIER_T2-ORDER_QTY, ZPK_SUPPLIER_T2-DOM)
      WHERE SUPPLIER_ID = ZPK_SUPPLIER_T2-SUPPLIER_ID.

  WHEN 'CLEAR1'.
    CLEAR: ZPK_SUPPLIER_T2-SUPPLIER_ID, ZPK_SUPPLIER_T2-SUPPLIER_NAME, ZPK_SUPPLIER_T2-COMPANY_NAME, ZPK_SUPPLIER_T2-ORDER_PRICE, ZPK_SUPPLIER_T2-ORDER_QTY, ZPK_SUPPLIER_T2-DOM.
  WHEN 'EXIT1'.
    LEAVE PROGRAM.
  WHEN 'SAVE1'.
    PERFORM SAVE.

  WHEN 'CHANGE1'.
    perform change.

ENDCASE.




ENDMODULE.
