*&---------------------------------------------------------------------*
*& Report ZPK_INNERJOIN_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INNERJOIN_3.

*marc + mard + mara
TYPES: BEGIN OF ty_final,
         matnr           TYPE mard-matnr,
         werks           TYPE mard-werks,
         lgort           TYPE mard-lgort,

         pstat           TYPE marc-pstat,
         lvorm           TYPE marc-lvorm,
         bwtty           TYPE marc-bwtty,

         created_at_time TYPE mara-created_at_time,
         ernam           TYPE mara-ernam,
         laeda           TYPE mara-laeda,

       END OF ty_final.

DATA: it_final TYPE STANDARD TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: var TYPE mard-matnr.

SELECT-OPTIONS: s_matnr FOR var.

SELECT  k~matnr
        k~werks
        k~lgort
        p~pstat
        p~lvorm
        p~bwtty
        m~created_at_time
        m~ernam
        m~laeda

  INTO TABLE it_final
  FROM mard AS k INNER JOIN marc AS p ON k~werks = p~werks
                 INNER JOIN mara AS m ON p~matnr = m~matnr
  WHERE k~matnr IN s_matnr.

IF  sy-subrc = 0.
  SORT it_final BY matnr.
ELSE.
  MESSAGE 'Data not found' TYPE 'I'.
ENDIF.


LOOP AT it_final INTO wa_final.
  WRITE:/ wa_final-matnr COLOR 4,
  wa_final-werks COLOR 1,
  wa_final-lgort COLOR 2,
  wa_final-pstat COLOR 3.
ENDLOOP.
