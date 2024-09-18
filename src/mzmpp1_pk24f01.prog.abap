*&---------------------------------------------------------------------*
*& Include          MZMPP1_PK24F01
*&---------------------------------------------------------------------*
FORM save .
  wa-employer_id = zpk_employer_t-employer_id .
  wa-employer_name = zpk_employer_t-employer_name.
  wa-employer_password = zpk_employer_t-employer_password.


  INSERT zpk_employer_t FROM wa.
  IF sy-subrc = 0.
    MESSAGE: 'INSTERT SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'INSTERT UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CHANGE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM change .
  wa-employer_id = zpk_employer_t-employer_id .
  wa-employer_name = zpk_employer_t-employer_name.
  wa-employer_password = zpk_employer_t-employer_password.


  UPDATE zpk_employer_t FROM wa.
  IF sy-subrc = 0.
    MESSAGE: 'update SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'UPDAATE UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.




FORM save2.
  wa2-passenger_id    = zpk_lpassenger_t-passenger_id.
  wa2-name            = zpk_lpassenger_t-name.
  wa2-passport_number = zpk_lpassenger_t-passport_number.
  wa2-date_of_birth   = zpk_lpassenger_t-date_of_birth.
  wa2-gender          = zpk_lpassenger_t-gender.
  wa2-email           = zpk_lpassenger_t-email.
  wa2-landline        = zpk_lpassenger_t-landline.
  wa2-mobile          = zpk_lpassenger_t-mobile.
  wa2-building        = zpk_lpassenger_t-building.
  wa2-city            = zpk_lpassenger_t-city.
  wa2-country         = zpk_lpassenger_t-country.
  wa2-pin_code        = zpk_lpassenger_t-pin_code.

  INSERT zpk_lpassenger_t FROM wa2.
  IF sy-subrc = 0.
    MESSAGE: 'INSTERT SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'INSTERT UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.

FORM change2 .
  wa2-passenger_id    = zpk_lpassenger_t-passenger_id.
  wa2-name            = zpk_lpassenger_t-name.
  wa2-passport_number = zpk_lpassenger_t-passport_number.
  wa2-date_of_birth   = zpk_lpassenger_t-date_of_birth.
  wa2-gender          = zpk_lpassenger_t-gender.
  wa2-email           = zpk_lpassenger_t-email.
  wa2-landline        = zpk_lpassenger_t-landline.
  wa2-mobile          = zpk_lpassenger_t-mobile.
  wa2-building        = zpk_lpassenger_t-building.
  wa2-city            = zpk_lpassenger_t-city.
  wa2-country         = zpk_lpassenger_t-country.
  wa2-pin_code        = zpk_lpassenger_t-pin_code.


  UPDATE zpk_lpassenger_t FROM wa2.
  IF sy-subrc = 0.
    MESSAGE: 'update SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'UPDAATE UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.






FORM save3.
  wa3-passenger_id          = zpk_airlines_t-passenger_id.
  wa3-airline_code          = zpk_airlines_t-airline_code.
  wa3-airline_name          = zpk_airlines_t-airline_name.
  wa3-flight_number         = zpk_airlines_t-flight_number.
  wa3-origin                = zpk_airlines_t-origin.
  wa3-destination           = zpk_airlines_t-destination.
  wa3-departure_times       = zpk_airlines_t-departure_times.
  wa3-arrival_times         = zpk_airlines_t-arrival_times.
  wa3-aircraft_type         = zpk_airlines_t-aircraft_type.
  wa3-seating_capacity      = zpk_airlines_t-seating_capacity.
  wa3-departure_date        = zpk_airlines_t-departure_date.
  wa3-arrival_date         = zpk_airlines_t-arrival_date.

  INSERT zpk_airlines_t FROM wa3.
  IF sy-subrc = 0.
    MESSAGE: 'INSTERT SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'INSTERT UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.

FORM change3 .
  wa3-passenger_id          = zpk_airlines_t-passenger_id.
  wa3-airline_code          = zpk_airlines_t-airline_code.
  wa3-airline_name          = zpk_airlines_t-airline_name.
  wa3-flight_number         = zpk_airlines_t-flight_number.
  wa3-origin                = zpk_airlines_t-origin.
  wa3-destination           = zpk_airlines_t-destination.
  wa3-departure_times       = zpk_airlines_t-departure_times.
  wa3-arrival_times         = zpk_airlines_t-arrival_times.
  wa3-aircraft_type         = zpk_airlines_t-aircraft_type.
  wa3-seating_capacity      = zpk_airlines_t-seating_capacity.
  wa3-departure_date        = zpk_airlines_t-departure_date.
  wa3-arrival_date         = zpk_airlines_t-arrival_date.



  UPDATE zpk_airlines_t FROM wa3.
  IF sy-subrc = 0.
    MESSAGE: 'update SUCCESSFUL' TYPE 'I'.
  ELSE.
    MESSAGE: 'UPDAATE UNSUCCESSFUL' TYPE 'I'.
  ENDIF.
ENDFORM.

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

  CONTAINER EXPORTING CONTAINER_NAME = 'CUST_PIN1',

  PICTURE EXPORTING PARENT = CONTAINER.

  CALL METHOD CL_SSF_XSF_UTILITIES=>GET_BDS_GRAPHIC_AS_BMP

    EXPORTING

      P_OBJECT       = 'GRAPHICS'

      P_NAME         = 'THY'" SE78

     P_ID           = 'BMAP'

      P_BTYPE        = 'Bcol'

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


FORM dis_logo2 .

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

  CONTAINER EXPORTING CONTAINER_NAME = 'CUST_PIN2',

  PICTURE EXPORTING PARENT = CONTAINER.

  CALL METHOD CL_SSF_XSF_UTILITIES=>GET_BDS_GRAPHIC_AS_BMP

    EXPORTING

      P_OBJECT       = 'GRAPHICS'

      P_NAME         = 'THY'" SE78

     P_ID           = 'BMAP'

      P_BTYPE        = 'Bcol'

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




FORM dis_logo3 .

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

  CONTAINER EXPORTING CONTAINER_NAME = 'CUST_PIN3',

  PICTURE EXPORTING PARENT = CONTAINER.

  CALL METHOD CL_SSF_XSF_UTILITIES=>GET_BDS_GRAPHIC_AS_BMP

    EXPORTING

      P_OBJECT       = 'GRAPHICS'

      P_NAME         = 'THY'" SE78

     P_ID           = 'BMAP'

      P_BTYPE        = 'Bcol'

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
