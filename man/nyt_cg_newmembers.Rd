\name{nyt_cg_newmembers}
\alias{nyt_cg_newmembers}
\title{Get a list of the most recent new members of the current Congress.}
\usage{
nyt_cg_newmembers(key = getOption("NYTCongressKey",
  stop("need an API key for the NYT Congress API")), callopts = list())
}
\arguments{
  \item{key}{your SunlightLabs API key; loads from
  .Rprofile}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}
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
nyt_cg_newmembers()
}
}

