*&---------------------------------------------------------------------*
*& Include          ZPK_INNERJOIN_2_CW_FORM
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
       a~carrname,
       a~currcode,
       a~url,
      b~connid,
      b~fldate,
      b~bookid,
      b~customid
  INTO TABLE @it_final
  FROM scarr AS a INNER JOIN sbook AS b ON a~carrid = b~carrid
  WHERE a~carrid IN @s_carrid.

IF sy-subrc = 0.
  SORT it_final BY carrid.
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
