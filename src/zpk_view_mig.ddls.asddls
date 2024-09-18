@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Migration View Sample'
define view entity ZPK_VIEW_MIG as select from sbook
{
    key carrid as airline_id ,
    connid as flight_id,
    fldate as flight_date,
    bookid as booking_id,
    customid as Customer_id ,

// This below element Annotation is for providing reference of Currency key from the same CDS from the field of line number 21. 
    @Semantics.amount.currencyCode: 'local_currency_key'
    loccuram as local_currency_amount, 
// This below element annotation is for letting CDS understand about the field is belongs to Currency KEY    
//    @Semantics.currencyCode: true
    loccurkey as local_currency_key ,
    
    smoker as smoker ,
    case
     when smoker = 'X' then  GET_NUMERIC_VALUE( loccuram ) + 50
     else  GET_NUMERIC_VALUE( loccuram )
     end as extra_charge    

    
}
