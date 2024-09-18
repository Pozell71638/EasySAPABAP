*&---------------------------------------------------------------------*
*& Report ZPK_SEARCHHELP1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_SEARCHHELP1.


DATA : t_return TYPE TABLE OF ddshretval WITH HEADER LINE .
PARAMETERS p_vbeln TYPE vbak-vbeln.

***Parameters p_kunnr1 type .


AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vbeln .




  SELECT vbeln, erdat, erzet, ernam FROM vbak INTO TABLE @DATA(lt_vbak) WHERE ernam = 'USER02' . " UP TO 10 ROWS.

************************** If you want to use your own internal table content to be showcase for Search help then we can use this below function module

CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
  EXPORTING
    retfield              = 'VBELN'
   DYNPPROG               = sy-cprog
   DYNPNR                 = sy-dynnr
   DYNPROFIELD            = 'P_VBELN'
   VALUE_ORG              = 'S'
  tables
    value_tab              = lt_VBAK .


******************* /// If you want to use SE11 Search help then we can use the below Function module...

**  CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
**    EXPORTING
**      tabname           = 'VBAK'
**      fieldname         = 'VBELN'
**      DYNPPROG          = sy-cprog
**      dynpnr            = sy-dynnr
**      searchhelp        = 'ZSH_VBAK'
**      dynprofield       = 'P_VBELN'
**    TABLES
**      return_tab        = t_return
**    EXCEPTIONS
**      field_not_found   = 1
**      no_help_for_field = 2
**      inconsistent_help = 3
**      no_values_found   = 4
**      OTHERS            = 5.
