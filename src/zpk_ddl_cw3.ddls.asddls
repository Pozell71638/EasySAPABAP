@AbapCatalog.sqlViewName: 'ZCDS_SQL_CW3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Case Expressions'
define view ZCDS_DDL_CW3 as select from sbook
{
    key carrid as airline_id ,
    bookid as bokking_id ,
    customid as customer_num ,
    custtype as customer_type ,
    smoker as smoker,
    loccuram as booking_amount ,
    
// If you want to validate only Smoker field status then you can use the below CASE Statement
    case smoker 
     when 'X' then loccuram + 100
     else 
         loccuram
    end as inc_smoker_charge_1 ,
    
// If you want to validate multiple fields status then you can use the below CASE Statement
    case
     when smoker = 'X' and custtype = 'B' then loccuram + 200
     when smoker = 'X' and custtype = 'P' then loccuram + 100
     else loccuram
     end as inc_smoker_charge_2 ,

   
    case smoker
      when ' ' then loccuram 
      else         
          case 
             when custtype = 'B' then loccuram + 200 
             when custtype = 'P' then loccuram + 100
             else loccuram 
          end
          
     end as inc_smoker_charge_3 
    
}
