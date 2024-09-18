@AbapCatalog.sqlViewName: 'ZPK_SQL_HW3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'vbak-vbap association'
define view ZPK_DDL_HW3 as select from vbak as a
association [1] to vbap as _b
    on a.vbeln = _b.vbeln
{
    
    a.vbeln ,
    a.erdat ,
    a.erzet ,
    a.ernam ,
    a.angdt , 
       
// Since we are choosing very limited columns that we wish to display from the Association table --> called as Ad-hoc Association
    _b.posnr ,
    _b.matnr ,
    _b.matwa
    
    
    // Since we are choosing complete fields from the Association table --> called as Exposed Association
//    _b
}


