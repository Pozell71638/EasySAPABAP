*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK3F01
*&---------------------------------------------------------------------*

FORM save .

WA-MATERIAL_ID   = ZPK_MATERIAL_T-MATERIAL_ID.
WA-MATERIAL_NAME = ZPK_MATERIAL_T-MATERIAL_NAME.
WA-DOM           = ZPK_MATERIAL_T-DOM.
WA-DOE           = ZPK_MATERIAL_T-DOE.
WA-COST          = ZPK_MATERIAL_T-COST.
INSERT ZPK_MATERIAL_T FROM WA.
IF SY-SUBRC = 0.
MESSAGE: 'INSERT SUCCESFUL' TYPE 'I'.
ELSE.
  MESSAGE: 'INSERT UNSUCCESFUL' TYPE 'I'.
ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form change
*&---------------------------------------------------------------------*
FORM change .
WA-MATERIAL_ID   = ZPK_MATERIAL_T-MATERIAL_ID.
WA-MATERIAL_NAME = ZPK_MATERIAL_T-MATERIAL_NAME.
WA-DOM           = ZPK_MATERIAL_T-DOM.
WA-DOE           = ZPK_MATERIAL_T-DOE.
WA-COST          = ZPK_MATERIAL_T-COST.
update ZPK_MATERIAL_T FROM WA.

IF SY-SUBRC = 0.
MESSAGE: 'UPDATE SUCCESFUL' TYPE 'I'.
ELSE.
  MESSAGE: 'UPDATE UNSUCCESFUL' TYPE 'I'.
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DIS_LOGO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM dis_logo .

  DATA: W_LINES TYPE I.

  TYPES PICT_LINE(256) TYPE C.

  DATA :

  CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

  EDITOR TYPE REF TO CL_GUI_TEXTEDIT,

  PICTURE TYPE REF TO CL_GUI_PICTURE,

  PICT_TAB TYPE TABLE OF PICT_LINE,

  URL(255) TYPE C.

  DATA: GRAPHIC_URL(255).

  DATA: BEGIN OF GRAPHIC_TABLE OCCURS 0,

          LINE(255) TYPE X,

        END OF GRAPHIC_TABLE.

  DATA: L_GRAPHIC_CONV TYPE I.

  DATA: L_GRAPHIC_OFFS TYPE I.

  DATA: GRAPHIC_SIZE TYPE I.

  DATA: L_GRAPHIC_XSTR TYPE XSTRING.

  .

  CALL METHOD CL_GUI_CFW=>FLUSH.

  CREATE OBJECT:

  CONTAINER EXPORTING CONTAINER_NAME = 'CUS_P1',

  PICTURE EXPORTING PARENT = CONTAINER.

  CALL METHOD CL_SSF_XSF_UTILITIES=>GET_BDS_GRAPHIC_AS_BMP

    EXPORTING

      P_OBJECT       = 'GRAPHICS'

      P_NAME         = 'ENJOY'" SE78

     P_ID           = 'BMAP'

      P_BTYPE        = 'BCOL'

    RECEIVING

      P_BMP          = L_GRAPHIC_XSTR

*  EXCEPTIONS

*    NOT_FOUND      = 1

*    INTERNAL_ERROR = 2

*    others         = 3

          .

  IF SY-SUBRC <> 0.

* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  ENDIF.

  GRAPHIC_SIZE = XSTRLEN( L_GRAPHIC_XSTR ).

  L_GRAPHIC_CONV = GRAPHIC_SIZE.

  L_GRAPHIC_OFFS = 0.

  WHILE L_GRAPHIC_CONV > 255.

    GRAPHIC_TABLE-LINE = L_GRAPHIC_XSTR+L_GRAPHIC_OFFS(255).

    APPEND GRAPHIC_TABLE.

    L_GRAPHIC_OFFS = L_GRAPHIC_OFFS + 255.

    L_GRAPHIC_CONV = L_GRAPHIC_CONV - 255.

  ENDWHILE.

  GRAPHIC_TABLE-LINE = L_GRAPHIC_XSTR+L_GRAPHIC_OFFS(L_GRAPHIC_CONV).

  APPEND GRAPHIC_TABLE.

  CALL FUNCTION 'DP_CREATE_URL'

    EXPORTING

      TYPE     = 'IMAGE'

      SUBTYPE  = 'X-UNKNOWN'

      SIZE     = GRAPHIC_SIZE

      LIFETIME = 'T'

    TABLES

      DATA     = GRAPHIC_TABLE

    CHANGING

      URL      = URL.

  CALL METHOD PICTURE->LOAD_PICTURE_FROM_URL

    EXPORTING

      URL = URL.

  CALL METHOD PICTURE->SET_DISPLAY_MODE

    EXPORTING

      DISPLAY_MODE = PICTURE->DISPLAY_MODE_FIT_CENTER.



ENDFORM.
