*&---------------------------------------------------------------------*
*& Report ZPK_INLINE_DECLARATION7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPK_INLINE_DECLARATION7.

Tables : Sbook .

SELECT-OPTIONS : s_custom for sbook-customid .

CONSTANTS : lc_smoker_fee TYPE s_l_cur_pr VALUE '1.75' ,
            lc_non_smkr type s_l_cur_pr VALUE '.75' .


SELECT carrid,
       connid,
       fldate,
       bookid,
       customid,
       LOCCURAM,
       smoker ,
       floor( LOCCURAM * @lc_smoker_fee ) as adjusted_amount,
       LOCCURKEY
       FROM sbook
       WHERE customid in @s_custom and smoker = @abap_true


UNION

SELECT carrid,
       connid,
       fldate,
       bookid,
       customid,
       LOCCURAM,
       smoker ,
       CEIL( LOCCURAM * @lc_non_smkr ) as adjusted_amount,
       LOCCURKEY
       FROM sbook
       WHERE customid in @s_custom and smoker = @abap_false
into TABLE @DATA(lt_sbook) .
SORT lt_sbook by customid .


*Creating instance for display the ALV we can use this below Class & Method...
TRY.
CALL METHOD cl_salv_table=>factory
  EXPORTING
    list_display   = IF_SALV_C_BOOL_SAP=>FALSE
*    r_container    =
*    container_name =
  IMPORTING
    r_salv_table   = DATA(lo_salv)
  CHANGING
    t_table        = lt_sbook
    .
  CATCH cx_salv_msg.
ENDTRY.

*To Display the ALV we can use below method
lo_salv->display( ).


* Instantly if you want to check the output of table data then we can use this below statements...
cl_demo_output=>write( lt_sbook ) .
cl_demo_output=>display(  ) .
