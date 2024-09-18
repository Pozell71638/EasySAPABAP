REPORT zbdc_sess_pk1
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
DATA: session1 LIKE apqi-groupid VALUE 'PINAR'.



CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                = 'C:\Users\digit\Music\BDC_MM01_2.txt'
    filetype                = 'ASC'
    has_field_separator     = '|'
  TABLES
    data_tab                = it_mara
  EXCEPTIONS                      " WE HAVE UNCOMMETED IT
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    invalid_type            = 5
    no_authority            = 6
    unknown_error           = 7
    bad_data_format         = 8
    header_not_allowed      = 9
    separator_not_allowed   = 10
    header_too_long         = 11
    unknown_dp_error        = 12
    access_denied           = 13
    dp_out_of_memory        = 14
    disk_full               = 15
    dp_timeout              = 16
    OTHERS                  = 17.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


CALL FUNCTION 'BDC_OPEN_GROUP'
  EXPORTING
    client              = sy-mandt
    group               = session1         " WE HAVE CHANGED IT
    keep                = 'X'               " WE HAVE CHANGED IT
    user                = sy-uname   " WE HAVE CHANGED IT
    prog                = sy-cprog
  EXCEPTIONS
    client_invalid      = 1
    destination_invalid = 2
    group_invalid       = 3
    group_is_locked     = 4
    holddate_invalid    = 5
    internal_error      = 6
    queue_error         = 7
    running             = 8
    system_lock_error   = 9
    user_invalid        = 10
    OTHERS              = 11.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.



* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
*INCLUDE bdcrecx1_s.

LOOP AT it_mara INTO wa_mara." we added it later
  CLEAR wa_bdcdata. " we added it later
  REFRESH it_bdcdata." we added it later

*START-OF-SELECTION.
*
*  PERFORM open_group.

  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=AUSW'.
  PERFORM bdc_field       USING 'RMMG1-MBRSH'
                                wa_mara-mbrsh."'1'.
  PERFORM bdc_field       USING 'RMMG1-MTART'
                                wa_mara-mtart."'FOOD'.
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
                                wa_mara-maktx."'PLAIN SODA'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'MARA-MATKL'.
  PERFORM bdc_field       USING 'MARA-MEINS'
                                wa_mara-meins."'BT'.
  PERFORM bdc_field       USING 'MARA-MATKL'
                                wa_mara-matkl."'D4RML'.
  PERFORM bdc_field       USING 'MARA-MTPOS_MARA'
                                'NORM'.
*  PERFORM bdc_transaction USING 'MM01'.
*
*  PERFORM close_group.
  CALL FUNCTION 'BDC_INSERT'            " we added it later
    EXPORTING
      tcode            = 'MM01' " we added it later
*     POST_LOCAL       = NOVBLOCAL
*     PRINTING         = NOPRINT
*     SIMUBATCH        = ' '
*     CTUPARAMS        = ' '
    TABLES
      dynprotab        = it_bdcdata " we added it later
    EXCEPTIONS
      internal_error   = 1
      not_open         = 2
      queue_error      = 3
      tcode_invalid    = 4
      printing_invalid = 5
      posting_invalid  = 6
      OTHERS           = 7.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.




ENDLOOP.




CALL FUNCTION 'BDC_CLOSE_GROUP'         " we added it later
*   EXCEPTIONS
*     NOT_OPEN          = 1
*     QUEUE_ERROR       = 2
*     OTHERS            = 3
  .
IF sy-subrc = 0.     " we equalize it later
  MESSAGE: 'SESSION CREATED. PLEASE CHECK SM35' TYPE 'I'.
ENDIF.

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR wa_BDCDATA.
  wa_BDCDATA-program  = program.
  wa_BDCDATA-dynpro   = dynpro.
  wa_BDCDATA-dynbegin = 'X'.
  APPEND wa_BDCDATA TO it_bdcdata.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
*  IF FVAL <> NODATA.
  CLEAR wa_BDCDATA.
  wa_BDCDATA-fnam = fnam.
  wa_BDCDATA-fval = fval.
  APPEND wa_BDCDATA TO it_bdcdata.
*  ENDIF.
ENDFORM.
