*&---------------------------------------------------------------------*
*& Report ZPK_CBS_CW6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_CBS_CW6.

*****************************************************************************
TYPE-POOLS: slis. " SLIS contains all the ALV data types
DATA: lt_vbak     TYPE TABLE OF vbak.
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
     FROM vbak
     INTO TABLE lt_vbak.

*&—– Field Catalog —–
wa_fieldcat-col_pos   = 1.
wa_fieldcat-fieldname = 'VBELN'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Sales Document'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.



wa_fieldcat-col_pos   = 2.
wa_fieldcat-fieldname = 'ERDAT'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Date on which the record was created'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

wa_fieldcat-col_pos   = 3.
wa_fieldcat-fieldname = 'ERNAM'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Name of Person Responsible for Creating the Object'. "Column description in the output
APPEND wa_fieldcat TO lt_fieldcat.

*
wa_fieldcat-col_pos   = 4.
wa_fieldcat-fieldname = 'NETWR'. "Fieldname in the data table
wa_fieldcat-seltext_m = 'Net Value of the Sales Order in Document Currency'. "Column description in the output
wa_fieldcat-do_sum    = 'X'.
APPEND wa_fieldcat TO lt_fieldcat.

*Build a sort catalog to generating sub-total
WA_SORT-fieldname = 'ERDAT'.
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
    t_outtab                          = LT_vbak
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
