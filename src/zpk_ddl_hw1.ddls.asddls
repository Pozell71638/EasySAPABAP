@AbapCatalog.sqlViewName: 'ZCDS_SQL_MARA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DDL EXAMPLE-MARA TABLE'
define view ZPK_DDL_HW1 as select from mara
{
   matnr as Material_Number,
   meins as Base_Unit_Of_Measure,
   mbrsh as Industry_Sector,
   ernam as Name_of_a_person_fco,
   ersda as Created_on,
   laeda as Date_of_last_change,
   aenam as Name_of_person_wco,
   mtart as Material_type,
   matkl as Material_Group,
   kunnr as Comperitor
}
