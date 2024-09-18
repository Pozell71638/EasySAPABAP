*&---------------------------------------------------------------------*
*& Include MZMPP1_PK15TOP                           - Module Pool      SAPMZMPP1_PK15
*&---------------------------------------------------------------------*
PROGRAM SAPMZMPP1_PK15.

DATA: X3 TYPE C,
      Y3 TYPE I.

TYPES: BEGIN OF ty_user,
         username TYPE string,
         password TYPE string,
       END OF ty_user.

DATA: gv_user TYPE ty_user,
      gv_admin TYPE ty_user.

INITIALIZATION.
  gv_user-username = 'user'.
  gv_user-password = '123'.

     gv_admin-username = 'admin'.
  gv_admin-password = '123'.
