#' R interface to some of the New York Times APIs.
#' 
#' Functions that wrap these sets of APIs are prefixed by two letter 
#' acronyms fo reach API endpoint + the function name itself as for example 
#' `cg` + `fxn`
#' 
#' \describe{
#'   \item{cg}{for the Congress API}
#'   \item{as}{for the Article Search API}
#'   \item{cf}{for the Campaign Finance API}
#'   \item{geo}{for the Geographic API}
#' }
#' 
#' See the vignette for help.
#' 
#' Please get your own API keys at http://developer.nytimes.com/apps/register - you'll 
#' need a different key for each API.
#' 
#' I set up the functions so that you can put the key in your .Rprofile file, which will 
#' be called on startup of R, and then you don't have to enter your API key for each run 
#' of a function. Put these entries in your .Rprofile file 
#' 
#' \itemize{
#'  \item \code{options(nytimes_cg_key = "YOURKEYHERE")}
#'  \item \code{options(nytimes_as_key = "YOURKEYHERE")}
#'  \item \code{options(nytimes_cf_key = "YOURKEYHERE")}
#'  \item \code{options(nytimes_geo_key = "YOURKEYHERE")}
#' }
#' 
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr rbind_all
#' @name rtimes-package
#' @aliases rtimes
#' @docType package
#' @title R interface to some of the New York Times APIs.
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL
