@AbapCatalog.sqlViewName: 'ZPK_SQL_CW9'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ad Hoc Associations'
define view ZPK_DDL_CW9 as select from sbook as a 
association to scustom as _b
on a.customid = _b.id

{
    a.carrid ,
    a.connid ,
    a.fldate ,
    a.bookid ,
    a.customid , 
       
// Since we are choosing very limited columns that we wish to display from the Association table --> called as Ad-hoc Association
    _b.country ,
    _b.name ,
    _b.email
    
    
}


