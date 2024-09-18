*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_1.

data: obj type ref to ZCL_ACCOUNTS_PK2.
data: bal type dmbtr.
*data: new_balance type dmbtr.


create object obj.

PARAMETERS: p_set type dmbtr,
            p_depo type dmbtr,
            p_with type dmbtr.


START-OF-SELECTION.

CALL METHOD obj->set_balance
  EXPORTING
    new_balance = p_set  .

write:/ 'opening bala',p_set.
*write:/ 'opening bala',new_balance color 3.

CALL METHOD obj->deposit
  EXPORTING
    amount      = p_depo
  receiving
    new_balance = bal  .

write:/ 'Balance after deposit', bal.

CALL METHOD obj->withdraw
  EXPORTING
    amount      = p_with
  receiving
    new_balance = bal .

write:/ 'Balance after withdraw', bal.
