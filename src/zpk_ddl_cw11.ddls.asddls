@AbapCatalog.sqlViewName: 'ZPK_SQL_CW11'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Filtered Association'
define view ZPK_DDL_CW11 as select from sbook as a
association to scustom as _b
    on a.customid = _b.id
{
    
    a.carrid ,
    a.connid ,
    a.fldate ,
    a.bookid ,
    _b.country ,
    _b[country = 'DE'].name ,     // Filtered Association
    _b.email
}

