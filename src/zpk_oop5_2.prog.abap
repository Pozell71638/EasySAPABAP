*&---------------------------------------------------------------------*
*& Report ZPK_OOP5_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_OOP5_2.

data: obj type ref to ZCL_ACCOUNTS_PK2  .
data: bal type dmbtr.

create OBJECT : obj.

PARAMETERS: p_set TYPE dmbtr,
            p_depo type dmbtr,
            p_with type dmbtr.

   obj->set_balance( p_set ).
write:/ 'opening balance', p_set.

    bal = obj->deposit( p_depo ).

write:/ 'Amt after the Deposit', bal.

bal = obj->WITHDRAW( p_with ).
write:/ 'Amt after the Withdraw', bal.
