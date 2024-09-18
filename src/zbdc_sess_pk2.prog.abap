report ZBDC_SESS_PK2
       no standard page heading line-size 255.


TYPES: BEGIN OF ty_mara,
         mbrsh TYPE mara-mbrsh,
         mtart TYPE mara-mtart,
         maktx TYPE makt-maktx,
         meins TYPE mara-meins,
         matkl TYPE mara-matkl,
       END OF ty_mara.

DATA:it_mara TYPE STANDARD TABLE OF ty_mara,
     wa_mara TYPE ty_mara.
DATA:it_bdcdata TYPE STANDARD TABLE OF bdcdata,
     wa_bdcdata TYPE bdcdata.
DATA: session1 LIKE apqi-groupid VALUE 'PINAR'.


CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                      = 'C:\Users\digit\Music\BDC_MM01_2.txt'
   FILETYPE                      = 'ASC'
   HAS_FIELD_SEPARATOR           = '|'

  tables
    data_tab                      = it_mara

 EXCEPTIONS
   FILE_OPEN_ERROR               = 1
   FILE_READ_ERROR               = 2
   NO_BATCH                      = 3
   GUI_REFUSE_FILETRANSFER       = 4
   INVALID_TYPE                  = 5
   NO_AUTHORITY                  = 6
   UNKNOWN_ERROR                 = 7
   BAD_DATA_FORMAT               = 8
   HEADER_NOT_ALLOWED            = 9
   SEPARATOR_NOT_ALLOWED         = 10
   HEADER_TOO_LONG               = 11
   UNKNOWN_DP_ERROR              = 12
   ACCESS_DENIED                 = 13
   DP_OUT_OF_MEMORY              = 14
   DISK_FULL                     = 15
   DP_TIMEOUT                    = 16
   OTHERS                        = 17
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.




CALL FUNCTION 'BDC_OPEN_GROUP'
 EXPORTING
   CLIENT                    = SY-MANDT
   GROUP                     = session1
   KEEP                      = 'X'
   USER                      = SY-UNAME
   PROG                      = SY-CPROG

 EXCEPTIONS
   CLIENT_INVALID            = 1
   DESTINATION_INVALID       = 2
   GROUP_INVALID             = 3
   GROUP_IS_LOCKED           = 4
   HOLDDATE_INVALID          = 5
   INTERNAL_ERROR            = 6
   QUEUE_ERROR               = 7
   RUNNING                   = 8
   SYSTEM_LOCK_ERROR         = 9
   USER_INVALID              = 10
   OTHERS                    = 11
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
*include bdcrecx1_s.  " form copy paste ini buraya girerek yapiyoruz.
*
*start-of-selection.
*
*perform open_group.



LOOP AT IT_MARA INTO WA_MARA.
  clear wa_bdcdata.
  refresh it_bdcdata.


perform bdc_dynpro      using 'SAPLMGMM' '0060'.
perform bdc_field       using 'BDC_CURSOR'
                              'RMMG1-MTART'.
perform bdc_field       using 'BDC_OKCODE'
                              '=AUSW'.
perform bdc_field       using 'RMMG1-MBRSH'
                              wa_mara-mbrsh. "'1'.
perform bdc_field       using 'RMMG1-MTART'
                              wa_mara-mtart."'FOOD'.
perform bdc_dynpro      using 'SAPLMGMM' '0070'.
perform bdc_field       using 'BDC_CURSOR'
                              'MSICHTAUSW-DYTXT(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_field       using 'MSICHTAUSW-KZSEL(01)'
                              'X'.
perform bdc_dynpro      using 'SAPLMGMM' '4004'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'MAKT-MAKTX'
                              wa_mara-maktx."'PLAIN SODA'.
perform bdc_field       using 'BDC_CURSOR'
                              'MARA-MATKL'.
perform bdc_field       using 'MARA-MEINS'
                              wa_mara-meins."'BT'.
perform bdc_field       using 'MARA-MATKL'
                              wa_mara-matkl."'D4RML'.
perform bdc_field       using 'MARA-MTPOS_MARA'
                              'NORM'.
*perform bdc_transaction using 'MM01'.
*
*perform close_group.
CALL FUNCTION 'BDC_INSERT'
 EXPORTING
   TCODE                  = 'MM01'

  TABLES
    dynprotab              = it_bdcdata
 EXCEPTIONS
   INTERNAL_ERROR         = 1
   NOT_OPEN               = 2
   QUEUE_ERROR            = 3
   TCODE_INVALID          = 4
   PRINTING_INVALID       = 5
   POSTING_INVALID        = 6
   OTHERS                 = 7
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


ENDLOOP.


CALL FUNCTION 'BDC_CLOSE_GROUP'
* EXCEPTIONS
*   NOT_OPEN          = 1
*   QUEUE_ERROR       = 2
*   OTHERS            = 3
          .
IF sy-subrc = 0.
MESSAGE: 'SESSION CREATED. PLEASE CHECK SM35' TYPE 'I'.
ENDIF.


*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR wa_BDCDATA.
  wa_BDCDATA-PROGRAM  = PROGRAM.
  wa_BDCDATA-DYNPRO   = DYNPRO.
  wa_BDCDATA-DYNBEGIN = 'X'.
  APPEND wa_BDCDATA to it_bdcdata..
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR wa_BDCDATA.
    wa_BDCDATA-FNAM = FNAM.
    wa_BDCDATA-FVAL = FVAL.
    APPEND wa_BDCDATA to it_bdcdata.
*  ENDIF.
ENDFORM.
