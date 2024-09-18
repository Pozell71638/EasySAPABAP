report ZBDC_CALL_PK2
       no standard page heading line-size 255.

TYPES: BEGIN OF ty_mara,
  mbrsh type mara-mbrsh,
  mtart type mara-mtart,
  maktx TYPE makt-maktx,
  meins TYPE mara-meins,
  matkl TYPE mara-matkl,
  END OF ty_mara.
 data:it_mara type STANDARD TABLE OF ty_mara,
       wa_mara TYPE ty_mara.
 data:it_bdcdata type STANDARD TABLE OF bdcdata,
       wa_bdcdata TYPE bdcdata.

  data: pname type string.

*selection-screen: begin of block a1 with frame.  " dosyani yerini gosteren ve yukleyen kisim, call function F4 Function da seciyor. Sonrasi normal bdc call.
PARAMETERS: file_nm type rlgrap-filename.
*selection-screen: end of block a1 .

at SELECTION-SCREEN on VALUE-REQUEST FOR file_nm.

CALL FUNCTION 'F4_FILENAME'
* EXPORTING
* PROGRAM_NAME = SYST-CPROG
* DYNPRO_NUMBER = SYST-DYNNR
* FIELD_NAME = ' '

IMPORTING

FILE_NAME = file_nm.


pname = file_nm.

 CALL FUNCTION 'GUI_UPLOAD'
   EXPORTING
     filename                      = file_nm "'C:\Users\digit\Music\BDC_MM01.txt'  " ve dosya yeri yerine buraya yazarsak burayi veriyor.call function F4 Function
    FILETYPE                      = 'ASC'
    HAS_FIELD_SEPARATOR           = '|'
*    HEADER_LENGTH                 = 0
*    READ_BY_LINE                  = 'X'
*    DAT_MODE                      = ' '
*    CODEPAGE                      = ' '
*    IGNORE_CERR                   = ABAP_TRUE
*    REPLACEMENT                   = '#'
*    CHECK_BOM                     = ' '
*    VIRUS_SCAN_PROFILE            =
*    NO_AUTH_CHECK                 = ' '
*  IMPORTING
*    FILELENGTH                    =
*    HEADER                        =
   tables
     data_tab                      = it_mara
*  CHANGING
*    ISSCANPERFORMED               = ' '
*  EXCEPTIONS
*    FILE_OPEN_ERROR               = 1
*    FILE_READ_ERROR               = 2
*    NO_BATCH                      = 3
*    GUI_REFUSE_FILETRANSFER       = 4
*    INVALID_TYPE                  = 5
*    NO_AUTHORITY                  = 6
*    UNKNOWN_ERROR                 = 7
*    BAD_DATA_FORMAT               = 8
*    HEADER_NOT_ALLOWED            = 9
*    SEPARATOR_NOT_ALLOWED         = 10
*    HEADER_TOO_LONG               = 11
*    UNKNOWN_DP_ERROR              = 12
*    ACCESS_DENIED                 = 13
*    DP_OUT_OF_MEMORY              = 14
*    DISK_FULL                     = 15
*    DP_TIMEOUT                    = 16
*    OTHERS                        = 17
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.


* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
*include bdcrecx1_s.
*
*start-of-selection.
*
*perform open_group.

perform bdc_dynpro      using 'SAPLMGMM' '0060'.
perform bdc_field       using 'BDC_CURSOR'
                              'RMMG1-MTART'.
perform bdc_field       using 'BDC_OKCODE'
                              '=AUSW'.
perform bdc_field       using 'RMMG1-MBRSH'
                              wa_mara-mbrsh. "'1'.
perform bdc_field       using 'RMMG1-MTART'
                              wa_mara-mtart. "'FOOD'.
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
                              wa_mara-maktx. "'PLAIN SODA'.
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


CALL TRANSACTION 'MM01' USING it_bdcdata MODE 'A' UPDATE 'S'.

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR wa_BDCDATA.
  wa_BDCDATA-PROGRAM  = PROGRAM.
  wa_BDCDATA-DYNPRO   = DYNPRO.
  wa_BDCDATA-DYNBEGIN = 'X'.
  APPEND wa_BDCDATA to it_bdcdata.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
* IF FVAL <> NODATA.
    CLEAR wa_BDCDATA.
    wa_BDCDATA-FNAM = FNAM.
    wa_BDCDATA-FVAL = FVAL.
    APPEND wa_BDCDATA to it_bdcdata.
*  ENDIF.
ENDFORM.
