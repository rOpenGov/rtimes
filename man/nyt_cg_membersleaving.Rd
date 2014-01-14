\name{nyt_cg_membersleaving}
\alias{nyt_cg_membersleaving}
\title{Get a list of members who have left the Senate or House or have announced plans to do so.}
\usage{
nyt_cg_membersleaving(congress_no = NULL, chamber = NULL,
  key = getOption("NYTCongressKey",
  stop("need an API key for the NYT Congress API")), callopts = list())
}
\arguments{
  \item{key}{your SunlightLabs API key; loads from
  .Rprofile}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}

  \item{congress_no}{The number of the Congress during
  which the members served.}

  \item{chamber}{One of 'house' or 'senate.}
}
\value{
List of new members of he current Congress.
}
\description{
Get a list of members who have left the Senate or House or
have announced plans to do so.
}
\examples{
\dontrun{
nyt_cg_membersleaving(112, 'house')
}
}

