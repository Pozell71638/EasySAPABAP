@AbapCatalog.sqlViewName: 'ZPK_SQL_CW5'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Joins'

//define view ZPK_DDL_CW5
//  as select from    sbook   as a
//    left outer join scustom as b on a.customid = b.id
//{
//  a.carrid,
//  a.connid,
//  a.fldate,
//  a.bookid,
//  a.customid ,
//  b.name,
//  b.email
//}

//define view ZPK_DDL_CW5
//  as select from    sbook   as a
//    inner join scustom as b on a.customid = b.id
//{
//  a.carrid,
//  a.connid,
//  a.fldate,
//  a.bookid,
//  a.customid ,
//  b.name,
//  b.email
//}
//
//where a.customid = '00000001'


define view ZPK_DDL_CW5
  as select from    sbook   as a
    right outer join scustom as b on a.customid = b.id
{
  a.carrid,
  a.connid,
  a.fldate,
  a.bookid,
  a.customid,
  b.name,
  b.email
}
