@AbapCatalog.sqlViewName: 'ZPK_SQL_CW7'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Input Parameters Example'
define view ZPK_DDL_CW7
with parameters p_country : land1_gp
as select from kna1


{
   key kunnr as customer ,
        land1 as country ,
        name1 as Name ,
        ort01 as city ,
        regio as Region 
}

where land1 = $parameters.p_country

//where land1 = 'DE'

