*&---------------------------------------------------------------------*
*& Report ZPK_CBS_HW5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CBS_HW5.

*TYPE-POOLS: slis. " SLIS contains all the ALV data types
*DATA: lt_sbook     TYPE TABLE OF sbook.
*DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
*      wa_fieldcat TYPE slis_fieldcat_alv,
*      lt_sort     TYPE slis_t_sortinfo_alv,
*      wa_sort     TYPE slis_sortinfo_alv.
*DATA: g_repid      TYPE sy-repid.
*
**&———————————————————————
**& START-OF-SELECTION
**&———————————————————————
*START-OF-SELECTION.
*
*g_repid = sy-repid.
*
**&—– Fetch data from the database —–
*SELECT *
*     FROM sbook
*     INTO TABLE lt_sbook.
*
**&—– Field Catalog —–
*wa_fieldcat-col_pos   = 1.
*wa_fieldcat-fieldname = 'CARRID'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Airline'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*
*wa_fieldcat-col_pos   = 2.
*wa_fieldcat-fieldname = 'CONNID'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Flight Connection Number'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*
*wa_fieldcat-col_pos   = 3.
*wa_fieldcat-fieldname = 'FLDATE'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Flight date'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*
*wa_fieldcat-col_pos   = 4.
*wa_fieldcat-fieldname = 'BOOKID'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Booking number'. "Booking Number
*wa_fieldcat-do_sum    = 'X'.
*APPEND wa_fieldcat TO lt_fieldcat.
*
*wa_fieldcat-col_pos   = 5.
*wa_fieldcat-fieldname = 'CUSTOMID'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Customer Number'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*wa_fieldcat-col_pos   = 6.
*wa_fieldcat-fieldname = 'LOCCURAM'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Price of booking in local currency of airline'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*wa_fieldcat-col_pos   = 7.
*wa_fieldcat-fieldname = 'ORDER_DATE'. "Fieldname in the data table
*wa_fieldcat-seltext_m = 'Booking Date'. "Column description in the output
*APPEND wa_fieldcat TO lt_fieldcat.
*
*
**WA_SORT-spos = 1.
*
*
*
*
**Build a sort catalog to generating sub-total
*WA_SORT-fieldname = 'ORDER_DATE'.
*WA_SORT-subtot    = 'X'.
* APPEND WA_SORT TO LT_SORT.
* CLEAR WA_SORT.
*
*
*
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
* EXPORTING
*   I_CALLBACK_PROGRAM                = g_repid
*   IT_FIELDCAT                       = LT_FIELDCAT
**   IT_EXCLUDING                      =
**   IT_SPECIAL_GROUPS                 =
*  IT_SORT                           = LT_SORT
*  TABLES
*    t_outtab                          = LT_SBOOK
** EXCEPTIONS
**   PROGRAM_ERROR                     = 1
**   OTHERS                            = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

*************************************************************
TYPE-POOLS: slis. " SLIS contains all the ALV data types
DATA: lt_vbrp     TYPE TABLE OF vbrp.
DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv,
      lt_sort     TYPE slis_t_sortinfo_alv,
      wa_sort     TYPE slis_sortinfo_alv.
DATA: g_repid      TYPE sy-repid.

*&———————————————————————
*& START-OF-SELECTION
*&———————————————————————
START-OF-SELECTION.

g_repid = sy-repid.

*&—– Fetch data from the database —–
SELECT *
     FROM vbrp
     INTO TABLE lt_vbrp.

*&—– Field Catalog —–
wa_fieldcat-col_pos   = 1.
wa_fieldcat-fieldname = 'VBELN'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Billing Document'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.
*
*
wa_fieldcat-col_pos   = 2.
wa_fieldcat-fieldname = 'POSNR'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Billing Item'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.
*
*
wa_fieldcat-col_pos   = 3.
wa_fieldcat-fieldname = 'FBUDA'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Date on which services are rendered'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

*
wa_fieldcat-col_pos   = 4.
wa_fieldcat-fieldname = 'NETWR'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Net Value of Billing item in Document Currency'. "Column description in the output
wa_fieldcat-do_sum    = 'X'.
APPEND wa_fieldcat TO lt_fieldcat.

*Build a sort catalog to generating sub-total
WA_SORT-fieldname = 'FBUDA'.
WA_SORT-subtot    = 'X'.
 APPEND WA_SORT TO LT_SORT.
 CLEAR WA_SORT.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = g_repid
   IT_FIELDCAT                       = LT_FIELDCAT
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
  IT_SORT                           = LT_SORT
  TABLES
    t_outtab                          = LT_vbrp
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
