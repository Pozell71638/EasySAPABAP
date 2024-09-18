@AbapCatalog.sqlViewName: 'ZPK_SQL_CW12'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sample CDS View'
define view ZPK_DDL_CW12 as select from scarr
{
    key carrid as airline_id ,
    carrname as airline_name ,
    currcode as curr_code,
    url as website
}
