REPORT zbdc_call_pk3
       NO STANDARD PAGE HEADING LINE-SIZE 255.


TYPES: BEGIN OF ty_mara,
         mbrsh TYPE mara-mbrsh,
         mtart TYPE mara-mtart,
         maktx TYPE makt-maktx,
         meins TYPE mara-meins,
         maktl TYPE mara-matkl,
       END OF ty_mara.

DATA: it_mara TYPE STANDARD TABLE OF ty_mara,
      wa_mara TYPE ty_mara.

DATA: it_bdcdata TYPE STANDARD TABLE OF bdcdata,
      wa_bdcdata TYPE bdcdata.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename            = 'C:\Users\digit\Music\BDC_MM01_2.txt'
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

LOOP AT it_mara INTO wa_mara.
  CLEAR wa_bdcdata.
  REFRESH it_bdcdata.
* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
*INCLUDE bdcrecx1_s.
*
*START-OF-SELECTION.
*
*  PERFORM open_group.

  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=AUSW'.
  PERFORM bdc_field       USING 'RMMG1-MBRSH'
                                wa_mara-mbrsh. "'C'.
  PERFORM bdc_field       USING 'RMMG1-MTART'
                                wa_mara-mtart."'NOF1'.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'.
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
                                wa_mara-maktx."'Sodium'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                wa_mara-maktl."'MARA-MATKL'.
  PERFORM bdc_field       USING 'MARA-MEINS'
                                wa_mara-meins."'PAC'.
  PERFORM bdc_field       USING 'MARA-MATKL'
                                'CVRM'.
  PERFORM bdc_field       USING 'MARA-MTPOS_MARA'
                                'NORM'.


  CALL TRANSACTION 'MM01' USING it_bdcdata MODE 'A' UPDATE 'S'.
*  PERFORM bdc_transaction USING 'MM01'.
*
*  PERFORM close_group.
ENDLOOP.
*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR wa_bdcdata.
  wa_bdcdata-program  = program.
  wa_bdcdata-dynpro   = dynpro.
  wa_bdcdata-dynbegin = 'X'.
  APPEND wa_bdcdata to it_bdcdata.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
*  IF fval <> nodata.
    CLEAR wa_bdcdata.
    wa_bdcdata-fnam = fnam.
    wa_bdcdata-fval = fval.
    APPEND wa_bdcdata to it_bdcdata.
*  ENDIF.
ENDFORM.
