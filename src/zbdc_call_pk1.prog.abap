










REPORT zbdc_call_pk1
       NO STANDARD PAGE HEADING LINE-SIZE 255.

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

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename            = 'C:\Users\digit\Music\BDC_MM01.txt'
    filetype            = 'ASC'
    has_field_separator = '|'
*   HEADER_LENGTH       = 0
*   READ_BY_LINE        = 'X'
*   DAT_MODE            = ' '
*   CODEPAGE            = ' '
*   IGNORE_CERR         = ABAP_TRUE
*   REPLACEMENT         = '#'
*   CHECK_BOM           = ' '
*   VIRUS_SCAN_PROFILE  =
*   NO_AUTH_CHECK       = ' '
* IMPORTING
*   FILELENGTH          =
*   HEADER              =
  TABLES
    data_tab            = it_mara
* CHANGING
*   ISSCANPERFORMED     = ' '
* EXCEPTIONS
*   FILE_OPEN_ERROR     = 1
*   FILE_READ_ERROR     = 2
*   NO_BATCH            = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE        = 5
*   NO_AUTHORITY        = 6
*   UNKNOWN_ERROR       = 7
*   BAD_DATA_FORMAT     = 8
*   HEADER_NOT_ALLOWED  = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG     = 11
*   UNKNOWN_DP_ERROR    = 12
*   ACCESS_DENIED       = 13
*   DP_OUT_OF_MEMORY    = 14
*   DISK_FULL           = 15
*   DP_TIMEOUT          = 16
*   OTHERS              = 17
  .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
*include bdcrecx1_s. " WE HAVE COMMENTED IT SO THAT STANDAR CODE WILL NOT DISPLAYED.
*
*start-of-selection." WE HAVE COMMENTED IT SO THAT STANDAR CODE WILL NOT DISPLAYED.
*
*perform open_group." WE HAVE COMMENTED IT SO THAT STANDAR CODE WILL NOT DISPLAYED.


LOOP AT it_mara INTO wa_mara. " we add it later
  CLEAR wa_bdcdata. " we add it later
  REFRESH it_bdcdata." we add it later

  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=AUSW'.
  PERFORM bdc_field       USING 'RMMG1-MBRSH'
                                wa_mara-mbrsh.    "'1'.                 " wa_mara-mbrsh IS ADDED LATER:
  PERFORM bdc_field       USING 'RMMG1-MTART'
                                wa_mara-mtart. "   'FOOD'.               " wa_mara-mtart IS ADDED LATER:
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'. " please click this line and copy ,paste the form things
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'MSICHTAUSW-DYTXT(01)'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=ENTR'.
  PERFORM bdc_field       USING 'MSICHTAUSW-KZSEL(01)'
                                'X'.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '4004'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=BU'.
  PERFORM bdc_field       USING 'MAKT-MAKTX'
                                wa_mara-maktx. "'PLAIN SODA'.             " wa_mara-maktx IS ADDED LATER:
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'MARA-MATKL'.
  PERFORM bdc_field       USING 'MARA-MEINS'
                                wa_mara-meins. " 'BT'.                     " wa_mara-mEINS IS ADDED LATER:
  PERFORM bdc_field       USING 'MARA-MATKL'
                                wa_mara-MATKL. " 'D4RML'.                   " wa_mara-MATKL IS ADDED LATER:
  PERFORM bdc_field       USING 'MARA-MTPOS_MARA'
                                'NORM'.
*perform bdc_transaction using 'MM01'." WE HAVE COMMENTED IT SO THAT STANDARD CODE WILL NOT DISPLAYED.

*
*perform close_group." WE HAVE COMMENTED IT SO THAT STANDAR CODE WILL NOT DISPLAYED.

  CALL TRANSACTION 'MM01' USING it_bdcdata MODE 'A' UPDATE 'S'. " we add it later
ENDLOOP." we add it later.

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR wa_bdcdata. " WE ARE TURNIING INTO THIS THINS AS WA_BDCDATA.(there is no wa_ before)
  wa_bdcdata-program  = program.
  wa_bdcdata-dynpro   = dynpro.
  wa_bdcdata-dynbegin = 'X'.
  APPEND wa_bdcdata TO it_bdcdata. " WE JUST ADD  'TO IT_BDCDATA: THERE IS NOTHING SUCH A THING BEFORE'.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
*  IF FVAL <> NODATA.
  CLEAR wa_bdcdata." WE ARE TURNIING INTO THIS THINS AS WA_BDCDATA.(there is no wa_ before)
  wa_bdcdata-fnam = fnam.
  wa_bdcdata-fval = fval.
  APPEND wa_bdcdata TO it_bdcdata. " WE JUST ADD  'TO IT_BDCDATA: THERE IS NOTHING SUCH A THING BEFORE'.
* ENDIF.
ENDFORM.
