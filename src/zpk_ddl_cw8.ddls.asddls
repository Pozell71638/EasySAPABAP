@AbapCatalog.sqlViewName: 'ZPK_SQL_CW8'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consuming CDS in another example'
define view ZPK_DDL_CW8 
with parameters p_land1 : land1_gp
as select from ZPK_DDL_CW7( p_country : $parameters.p_land1 )
{
     key customer ,
        country ,
        Name ,
        city ,
        Region
   
    
}

where Region = '11'

