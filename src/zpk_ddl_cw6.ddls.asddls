@AbapCatalog.sqlViewName: 'ZPK_SQL_CW6'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union Example'
define view ZPK_DDL_CW6 as select from sbook
{
       customid
}

where customid = '00000002'

 union
//union all

select from scustom
{
 
 id as customid 
}
where id = '00000002'

