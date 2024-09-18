class ZCL_ACCOUNTS_PK2 definition
  public
  final
  create public .

public section.

  data BALANCE type DMBTR read-only .

  methods SET_BALANCE
    importing
      !NEW_BALANCE type DMBTR .
  methods DEPOSIT
    importing
      !AMOUNT type DMBTR
    returning
      value(NEW_BALANCE) type DMBTR .
  methods WITHDRAW
    importing
      !AMOUNT type DMBTR
    returning
      value(NEW_BALANCE) type DMBTR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ACCOUNTS_PK2 IMPLEMENTATION.


  method DEPOSIT.
     balance = balance + amount.
    new_balance = Balance.
  endmethod.


  method SET_BALANCE.


   balance = new_balance.
  endmethod.


  method WITHDRAW.

     if balance >= amount.
      balance = balance - amount.
      new_balance = balance.
      else.
        message 'Insufficient Fund' type 'I'.
        endif.

  endmethod.
ENDCLASS.
