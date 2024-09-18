*&---------------------------------------------------------------------*
*& Report ZPK_ALV_CW13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpk_alv_cw13.


******************************************************
TYPE-POOLS: slis.
TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         ersda TYPE mara-ersda,
         ernam TYPE mara-ernam,
         laeda TYPE mara-laeda,
       END OF ty_mara.

TYPES: BEGIN OF ty_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
       END OF ty_mard.

DATA: it_mara  TYPE STANDARD TABLE OF ty_mara,
      it_mard  TYPE STANDARD TABLE OF ty_mard,
      it_fcat  TYPE slis_t_fieldcat_alv,
      it_fcat1 TYPE slis_t_fieldcat_alv.


DATA: wa_mara TYPE ty_mara,
      wa_mard TYPE ty_mard,
      wa_fcat TYPE slis_fieldcat_alv,
      var     TYPE mara-matnr.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR var.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  SELECT  matnr
          ersda
          ernam
          laeda

    FROM mara INTO TABLE it_mara
    WHERE matnr IN s_matnr.

  IF sy-subrc = 0.
    SORT it_mara BY matnr.
  ELSE.
    MESSAGE 'NO DATA AVAILABLE FOR THIS Airline' TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

   Wa_FCAT-COL_POS = 1.
   Wa_FCAT-FIELDNAME = 'MATNR'.
   Wa_FCAT-TABNAME   = 'IT_MARA'.
   Wa_FCAT-SELTEXT_M =  'Material Number'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 2.
   Wa_FCAT-FIELDNAME = 'ERSDA'.
   Wa_FCAT-TABNAME   = 'IT_MARA'.
   Wa_FCAT-SELTEXT_M =  'Created On'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 3.
   Wa_FCAT-FIELDNAME = 'ERNAM'.
   Wa_FCAT-TABNAME   = 'IT_MARA'.
   Wa_FCAT-SELTEXT_M =  'Name of Person Responsible for Creating the Object'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

   Wa_FCAT-COL_POS = 4.
   Wa_FCAT-FIELDNAME = 'LAEDA'.
   Wa_FCAT-TABNAME   = 'IT_MARA'.
   Wa_FCAT-SELTEXT_M =  'Date of Last Change'.
  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.



CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = SY-REPID
   I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
   IT_FIELDCAT                       = IT_FCAT
  TABLES
    t_outtab                          = IT_MARA.
*-----------------------------------------------------------
FORM USER_COMMAND USING COMMAND LIKE SY-UCOMM
                        SELFIELD TYPE SLIS_SELFIELD  .

  READ TABLE IT_MARA INTO WA_MARA INDEX SELFIELD-TABINDEX.
  IF COMMAND EQ '&IC1'.
    CLEAR: IT_FCAT1[].

  SELECT matnr
         werks
         lgort
    FROM MARD INTO TABLE IT_MARD
    WHERE MATNR = WA_MARA-MATNR.

 WA_FCAT-COL_POS = 1.
    WA_FCAT-FIELDNAME = 'MATNR'.
    WA_FCAT-TABNAME  = 'IT_MARD'.
    WA_FCAT-SELTEXT_M = 'Material Number'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

     WA_FCAT-COL_POS = 2.
    WA_FCAT-FIELDNAME = 'WERKS'.
    WA_FCAT-TABNAME  = 'IT_MARD'.
    WA_FCAT-SELTEXT_M = 'Plant'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.

      WA_FCAT-COL_POS = 3.
    WA_FCAT-FIELDNAME = 'LGORT'.
    WA_FCAT-TABNAME  = 'IT_MARD'.
    WA_FCAT-SELTEXT_M = 'Storage location'.
    APPEND WA_FCAT TO IT_FCAT1.
    CLEAR  WA_FCAT.




    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
        I_CALLBACK_PROGRAM = SY-REPID
        IT_FIELDCAT        = iT_FCAT1
      TABLES
        T_OUTTAB           = iT_MARD.

 endif.
  ENDFORM.
