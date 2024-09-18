@AbapCatalog.sqlViewName: 'ZCDS_SQL_CW5'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aggregation Demo'
define view ZCDS_DDL_CW5 as select from sbook
{
    
    key carrid as airline_id, 
    
    // COUNT gives you total number of records for the selected table
    count(*) as no_of_records ,
    
    // COUNT( Distinct <Field Name> ) on which the distinct functionality applying
    count(distinct loccuram) as distinct_records ,
    
    // it will give us Min value based on the Field value which we mentioned in MIN(<FieldName>)
    min(loccuram) as min_booking_amount ,
    
    // it will give us Mix value based on the Field value which we mentioned in MAX(<FieldName>)
    max(loccuram) as max_booking_amount ,
    
    // it will give us AVG value based on the Field value which we mentioned in AVG(<FieldName>)
    avg(loccuram) as avg_booking_amount ,
    
    
    sum(loccuram) as sum_booking_amount 
    
    
 }   

 group by carrid having carrid = 'AA'
