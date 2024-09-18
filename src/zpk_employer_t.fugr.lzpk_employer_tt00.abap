*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZPK_EMPLOYER_T..................................*
DATA:  BEGIN OF STATUS_ZPK_EMPLOYER_T                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZPK_EMPLOYER_T                .
CONTROLS: TCTRL_ZPK_EMPLOYER_T
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZPK_EMPLOYER_T                .
TABLES: ZPK_EMPLOYER_T                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
