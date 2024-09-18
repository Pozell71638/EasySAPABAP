@AbapCatalog.sqlViewName: 'ZPK_SQLCW10'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exposed Association'
define view ZPK_DDL_CW10 as select from sbook as a

association to scustom as _b
 on a.customid = _b.id
{
      a.carrid ,
    a.connid ,
    a.fldate ,
    a.bookid ,
    a.customid ,
    
// Since we are choosing complete fields from the Association table --> called as Exposed Association
    _b
    
}



