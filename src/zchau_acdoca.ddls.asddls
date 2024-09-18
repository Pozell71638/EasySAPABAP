@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCHAU_ACDOCA as select from I_JournalEntryItem
{
  key CompanyCode             as BUKRS,
    key AccountingDocument      as BELNR,
    key FiscalYear              as GJAHR,
    key LedgerGLLineItem        as DOCLN,
        GLAccount               as RACCT,
        CostCenter              as RCNTR,
        ProfitCenter            as PRCTR 
  
  
    
}
where SourceLedger = '0L' and Ledger = '0L'
