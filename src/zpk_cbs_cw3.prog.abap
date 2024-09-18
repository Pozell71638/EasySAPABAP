*&---------------------------------------------------------------------*
*& Report ZPK_CBS_CW3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CBS_CW3.

TYPE-POOLS: slis. " SLIS contains all the ALV data types
DATA: lt_sflight     TYPE TABLE OF sflight.
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
     FROM sflight
     INTO TABLE lt_sflight.

*&—– Field Catalog —–
wa_fieldcat-col_pos   = 1.
wa_fieldcat-fieldname = 'CARRID'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Airline'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

wa_fieldcat-col_pos   = 2.
wa_fieldcat-fieldname = 'CONNID'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Flight Connection Number'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

wa_fieldcat-col_pos   = 3.
wa_fieldcat-fieldname = 'FLDATE'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Flight date'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

wa_fieldcat-col_pos   = 4.
wa_fieldcat-fieldname = 'PRICE'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Airfare'. "Column description in the output
wa_fieldcat-do_sum    = 'X'.
APPEND wa_fieldcat TO lt_fieldcat.

wa_fieldcat-col_pos   = 5.
wa_fieldcat-fieldname = 'CURRENCY'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Local currency of airline'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

*Build a sort catalog to generating sub-total
WA_SORT-fieldname = 'FLDATE'.
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
    t_outtab                          = LT_SFLIGHT
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
