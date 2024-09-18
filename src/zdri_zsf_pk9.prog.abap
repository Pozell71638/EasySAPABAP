*&---------------------------------------------------------------------*
*& Report ZDRI_ZSF_PK9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDRI_ZSF_PK9.
DATA: WA TYPE ZSTR_SF__CUST_AA1.

PARAMETERS: S_ID TYPE ZSTR_SCUSTOM_PK1-id.

SELECT SINGLE
ID
NAME
CITY
COUNTRY
  FROM SCUSTOM INTO WA
  WHERE ID = S_ID.

 CALL FUNCTION '/1BCDWB/SF00000065'
   EXPORTING
*    ARCHIVE_INDEX              =
*    ARCHIVE_INDEX_TAB          =
*    ARCHIVE_PARAMETERS         =
*    CONTROL_PARAMETERS         =
*    MAIL_APPL_OBJ              =
*    MAIL_RECIPIENT             =
*    MAIL_SENDER                =
*    OUTPUT_OPTIONS             =
*    USER_SETTINGS              = 'X'
     wa_cust                    = wa
*  IMPORTING
*    DOCUMENT_OUTPUT_INFO       =
*    JOB_OUTPUT_INFO            =
*    JOB_OUTPUT_OPTIONS         =
*  EXCEPTIONS
*    FORMATTING_ERROR           = 1
*    INTERNAL_ERROR             = 2
*    SEND_ERROR                 = 3
*    USER_CANCELED              = 4
*    OTHERS                     = 5
           .
 IF sy-subrc <> 0.
* Implement suitable error handling here
 ENDIF.
