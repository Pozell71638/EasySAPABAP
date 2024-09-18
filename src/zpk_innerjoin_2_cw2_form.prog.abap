*&---------------------------------------------------------------------*
*& Include          ZPK_INNERJOIN_2_CW2_FORM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*



FORM select .
  SELECT a~carrid,
         a~connid,
         a~fldate,
         a~bookid,
         a~customid,
         b~id,
         b~name,
         b~form,
         b~street
    INTO TABLE @it_final
    FROM sbook AS a INNER JOIN scustom AS b ON a~customid = b~id
    WHERE a~customid IN @s_cstomd.

  IF sy-subrc = 0.
    SORT it_final BY customid.
  ELSE.
    MESSAGE 'data not found' TYPE 'I'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display .
  LOOP AT it_final INTO wa_final.
    WRITE:/ wa_final-carrid,
            wa_final-connid,
            wa_final-bookid,
            wa_final-customid.

  ENDLOOP.
ENDFORM.
