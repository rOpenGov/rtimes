\name{nyt_cg_billscosponsor}
\alias{nyt_cg_billscosponsor}
\title{Get bill cosponsorship data for a particular member.}
\usage{
nyt_cg_billscosponsor(memberid = NULL, type = NULL,
  key = getOption("NYTCongressKey",
  stop("need an API key for the NYT Congress API")), callopts = list())
}
\arguments{
  \item{key}{your SunlightLabs API key; loads from
  .Rprofile}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}

  \item{memberid}{The member's unique ID number
  (alphanumeric). To find a member's ID number, get the
  list of members for the appropriate House or Senate. You
  can also use the Biographical Directory of the United
  States Congress to get a member's ID. In search results,
  each member's name is linked to a record by index ID
  (e.g.,
  http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041).
  Use the index ID as member-id in your request.}

  \item{type}{One of 'cosponsored' (the 20 bills most
  recently cosponsored by member-id) or 'withdrawn' (the 20
  most recently withdrawn cosponsorships for member-id).}
}
\value{
List of new members of he current Congress.
}
\description{
Get bill cosponsorship data for a particular member.
}
\examples{
\dontrun{
nyt_cg_billscosponsor(memberid='S001181', type='cosponsored')
}
}

