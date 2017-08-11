#' rtimes
#'
#' Interface to the Congress and Campaign Finance APIs from Propublica, and 
#' the Article Search and Geographic 'APIs' from the New York Times. 
#' 
#' Backstory is that the Congress and Campaign finance APIs used to be part of 
#' NYTimes, but were taken over by Propublica.
#'
#' @section rtimes API:
#' Functions that wrap these sets of APIs are prefixed by two letter
#' acronyms fo reach API endpoint + the function name itself as for example
#' `cg` + `fxn`
#'
#' \itemize{
#'   \item as - for the Article Search API (Docs: 
#'   <http://developer.nytimes.com/article_search_v2.json>)
#'   \item geo - for the Geographic API (Docs: 
#'   <http://developer.nytimes.com/geo_api_v2.json>)
#'   \item cg - for the Congress API (Docs: 
#'   <https://projects.propublica.org/api-docs/congress-api/>)
#'   \item cf - for the Campaign Finance API (Docs: 
#'   <https://propublica.github.io/campaign-finance-api-docs/>)
#' }
#'
#' See the vignette for help.
#'
#' @section Authentication:
#' Get your own API keys for NYTimes APIs at 
#' <http://developer.nytimes.com/signup> - you'll need a different key for 
#' each of the article saerch and geo NYTimes APIs.
#' 
#' Get your Propublica API key for Congress and Campaign Finance APIs at either
#' <https://www.propublica.org/datastore/api/propublica-congress-api> or 
#' <https://www.propublica.org/datastore/api/campaign-finance-api> - as far
#' as I know, you can use the same key for both APIs
#'
#' We set up the functions so that you can put the key in your `.Renviron`
#' file, which will be called on startup of R, and then you don't have to enter 
#' your API key for each run of a function. Add entries for an R session like
#'
#' \itemize{
#'  \item `Sys.setenv(NYTIMES_AS_KEY = "YOURKEYHERE")`
#'  \item `Sys.setenv(NYTIMES_GEO_KEY = "YOURKEYHERE")`
#'  \item `Sys.setenv(PROPUBLICA_API_KEY = "YOURKEYHERE")`
#' }
#'
#' Or set them across sessions by putting entries in your `.Renviron` file 
#' like
#'
#' \itemize{
#'  \item `NYTIMES_AS_KEY=<yourkey>`
#'  \item `NYTIMES_GEO_KEY=<yourkey>`
#'  \item `PROPUBLICA_API_KEY=<yourkey>`
#' }
#'
#' You can also pass in your key in a function call, but be careful not to 
#' expose your keys in code committed to public repositories. If you do pass 
#' in a function call, use e.g., `Sys.getenv("NYTIMES_AS_KEY")`
#'
#' @section Rate limits:
#' Rate limits vary for the different APIs:
#'
#' \itemize{
#'  \item Article Search API: 1/sec, 1,000/day
#'  \item Geographic API: 5/sec, 1,000/day
#'  \item Congress API: 2/sec, 5,000/day
#'  \item Campaign Finance API: 50/sec, 5,000/day
#' }
#'
#' @importFrom crul HttpClient
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr bind_rows
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @name rtimes-package
#' @aliases rtimes
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL
