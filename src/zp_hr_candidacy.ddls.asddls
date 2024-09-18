@AbapCatalog.sqlViewName: 'ZP_SQL_CANDIDACY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Candidacy'
define view ZP_HR_Candidacy
  as select from zpcandidacy as a

  association [1..*] to zpapplication as _b on $projection.applicationid = _b.applicationid
  association [1..*] to zpjobposting  as _c on $projection.jobpostingid = _c.joppostingid
  association [1..1] to zpcandidate   as _d on $projection.candidateid = _d.candidateid
{
  a.candidateid,
  a.applicationid,
  a.jobpostingid,
  a.status,
  
  
 
  _b.applicationdate,
  _b.applicationstatus,
  _c.title,
  _c.description,
  _c.postingdate,
  _c.jobpostingstatus,
  
_d.firstname,
_d.lastname,
_d.email
  //   _Application      : association [1..*] to ZPApplication as _Application on $projection.ApplicationID = _Application.ApplicationID
  //   _JobPosting       : association [1..*] to ZPJobPosting as _JobPosting on $projection.JobPostingID = _JobPosting.JobPostingID,
  //   _Candidate        : association [1..1] to ZPCandidate as _Candidate on $projection.CandidateID = _Candidate.CandidateID
}
