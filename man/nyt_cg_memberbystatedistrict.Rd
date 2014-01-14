\name{nyt_cg_memberbystatedistrict}
\alias{nyt_cg_memberbystatedistrict}
\title{Get a list of the most recent new members of the current Congress.}
\usage{
nyt_cg_memberbystatedistrict(chamber = NULL, state = NULL,
  district = NULL, key = getOption("NYTCongressKey",
  stop("need an API key for the NYT Congress API")), callopts = list())
}
\arguments{
  \item{key}{your SunlightLabs API key; loads from
  .Rprofile}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}

  \item{chamber}{One of 'house' or 'senate.}

  \item{state}{Limits the list of members by state;
  two-letter state code (e.g., CA).}

  \item{district}{Limits the list of members by district
  (House only). If you specify a district, you must also
  specify a state. If the district number you specify is
  higher than the total number of districts for that state,
  a 404 response will be returned.}
}
\value{
List of new members of he current Congress.
}
\description{
Get a list of the most recent new members of the current
Congress.
}
\examples{
\dontrun{
nyt_cg_memberbystatedistrict('senate', 'NH')
}
}

