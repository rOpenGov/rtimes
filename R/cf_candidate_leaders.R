#' Campaign finance NYTimes API - candidate leaders
#' 
#' See \url{http://developer.nytimes.com/docs/campaign_finance_api/}
#' 
#' @import jsonlite httr 
#' @export
#' @template finance
#' @template nyt
#' @param category Category. Specify one of these categories:
#' \itemize{
#'  \item Candidate Loan `candidate-loan`
#'  \item Contribution Total `contribution-total`
#'  \item Debts Owed `debts-owed`
#'  \item Disbursements Total `disbursements-total`
#'  \item End Cash `end-cash`
#'  \item Individual Total `individual-total`
#'  \item PAC Total `pac-total`
#'  \item Receipts Total `receipts-total`
#'  \item Refund Total `refund-total`
#' }
#' @examples \dontrun{
#' cf_candidate_leaders(campaign_cycle = 2010, category='end-cash')
#' cf_candidate_leaders(campaign_cycle = 2008, category='receipts-total')
#' }

`cf_candidate_leaders` <- function(campaign_cycle=NULL, category=NULL, 
                                   key=getOption("nytimes_cf_key"), ...) {
  url <- sprintf("http://api.nytimes.com/svc/elections/us/v3/finances/%s/candidates/leaders/%s.json", campaign_cycle, category)
  args <- rtimes_compact(list(`api-key`=key))
  ans <- GET(url, query = args, ...)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  jsonlite::fromJSON(tt, simplifyVector = FALSE)
}
