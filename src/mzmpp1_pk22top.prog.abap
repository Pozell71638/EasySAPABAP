*&---------------------------------------------------------------------*
*& Include MZMPP1_PK22TOP                           - Module Pool      SAPMZMPP1_PK22
*&---------------------------------------------------------------------*
PROGRAM sapmzmpp1_pk22.
TABLES: mara, marc, mard.

CONTROLS: pinar4 TYPE TABSTRIP.
DATA: x4 TYPE i.

DATA: lt_mara TYPE TABLE OF mara,
      lt_marc TYPE TABLE OF marc,
      lt_mard TYPE TABLE OF mard,
      ls_mara TYPE mara,
      ls_marc TYPE marc,
      ls_mard TYPE mard.
