*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_ALV_CW12.
TYPE-POOLS: slis.

TYPES: BEGIN OF ty_sbook,
         carrid   TYPE sbook-carrid,
         connid   TYPE sbook-connid,
         fldate   TYPE sbook-fldate,
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
       END OF ty_sbook,

       BEGIN OF ty_scustom,
         id      TYPE scustom-id,
         name    TYPE scustom-name,
         form    TYPE scustom-form,
         street  TYPE scustom-street,
         postbox TYPE scustom-postbox,
         city    TYPE scustom-city,
         country TYPE scustom-country,
       END OF ty_scustom.

DATA: it_sbook   TYPE STANDARD TABLE OF ty_sbook,
      it_scustom TYPE STANDARD TABLE OF ty_scustom,
      it_fcat    TYPE slis_t_fieldcat_alv,
      it_fcat1   TYPE slis_t_fieldcat_alv.


DATA: wa_sbook   TYPE ty_sbook,
      wa_scustom TYPE ty_scustom,
      wa_fcat    TYPE slis_fieldcat_alv,

      var type sbook-carrid.


SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_carr for var.
SELECTION-SCREEN END OF BLOCK B1.

START-OF-SELECTION.
SELECT  carrid
        connid
        fldate
        bookid
        customid
  from sbook into table it_sbook
  where carrid in s_carr.

    IF SY-SUBRC = 0.
      sort it_sbook by carrid.
      else.
    MESSAGE 'NO DATA AVAILABLE FOR THIS Airline' TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

   Wa_FCAT-COL_POS = 1.
   Wa_FCAT-FIELDNAME = 'CARRID'.
   Wa_FCAT-TABNAME   = 'IT_SBOOK'.
   Wa_FCAT-SELTEXT_M =  'Airline Code'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 2.
   Wa_FCAT-FIELDNAME = 'CONNID'.
   Wa_FCAT-TABNAME   = 'IT_SBOOK'.
   Wa_FCAT-SELTEXT_M =  'Flight Connection Number'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 3.
   Wa_FCAT-FIELDNAME = 'FLDATE'.
   Wa_FCAT-TABNAME   = 'IT_SBOOK'.
   Wa_FCAT-SELTEXT_M =  'Flight date'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 4.
   Wa_FCAT-FIELDNAME = 'BOOKID'.
   Wa_FCAT-TABNAME   = 'IT_SBOOK'.
   Wa_FCAT-SELTEXT_M =  'Booking number'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 5.
   Wa_FCAT-FIELDNAME = 'CUSTOMID'.
   Wa_FCAT-TABNAME   = 'IT_SBOOK'.
   Wa_FCAT-SELTEXT_M =  'Customer Number'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-REPID
   I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
   IT_FIELDCAT                       = IT_FCAT
  TABLES
    t_outtab                          = IT_SBOOK.

**--------------------------------------------------------------------

FORM USER_COMMAND USING COMMAND LIKE SY-UCOMM
                        SELFIELD TYPE SLIS_SELFIELD	.

  READ TABLE IT_SBOOK INTO WA_SBOOK INDEX SELFIELD-TABINDEX.
  IF COMMAND EQ '&IC1'.
    CLEAR: IT_FCAT1[].


  SELECT id
         name
         form
         street
         postbox
         city
         country
    FROM SCUSTOM INTO TABLE IT_SCUSTOM
    WHERE ID = WA_SBOOK-customid.

    WA_FCAT-COL_POS = 1.
    WA_FCAT-FIELDNAME = 'ID'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'Customer Number'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

     WA_FCAT-COL_POS = 2.
    WA_FCAT-FIELDNAME = 'NAME'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'Customer name'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

      WA_FCAT-COL_POS = 3.
    WA_FCAT-FIELDNAME = 'FORM'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'Form of address'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

      WA_FCAT-COL_POS = 4.
    WA_FCAT-FIELDNAME = 'STREET'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'Street'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

      WA_FCAT-COL_POS = 5.
    WA_FCAT-FIELDNAME = 'POSTBOX'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'PO Box'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

      WA_FCAT-COL_POS = 6.
    WA_FCAT-FIELDNAME = 'CITY'.
    WA_FCAT-TABNAME  = 'IT_SCUSTOM'.
    WA_FCAT-SELTEXT_M = 'City'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
        I_CALLBACK_PROGRAM = SY-REPID
        IT_FIELDCAT        = iT_FCAT1
      TABLES
        T_OUTTAB           = iT_scustom.

 endif.
  ENDFORM.
