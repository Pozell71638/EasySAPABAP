@AbapCatalog.sqlViewName: 'ZCDS_SQL_CW2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Annotation Example'
//@AbapCatalog.buffering.status: #ACTIVE
//@AbapCatalog.buffering.type: #SINGLE
@ClientDependent:true
define view ZPK_DDL_CW2 as select from sbook
{
     key carrid as airline_id ,
    connid as flight_id,
    fldate as flight_date,
    bookid as booking_id,
    customid as Customer_id,
   
    // This below element Annotation is for providing reference of Currency key from the same CDS from the field of line number 21. 
    @Semantics.amount.currencyCode: 'local_currency_key'
    loccuram as local_currency_amount, 
// This below element annotation is for letting CDS understand about the field is belongs to Currency KEY    
    @Semantics.currencyCode: true
    loccurkey as local_currency_key
    
   
    
}


