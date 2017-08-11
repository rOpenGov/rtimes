#' Campaign finance - candidate leaders
#'
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
#' @references <http://propublica.github.io/campaign-finance-api-docs>
#' @family campaign-finance
#' @examples \dontrun{
#' cf_candidate_leaders(campaign_cycle = 2010, category='end-cash')
#' cf_candidate_leaders(campaign_cycle = 2008, category='receipts-total')
#' }

`cf_candidate_leaders` <- function(campaign_cycle=NULL, category=NULL, key=NULL, ...) {
  url <- sprintf("%s/%s/candidates/leaders/%s.json", cf_base(), campaign_cycle, category)
  res <- rtimes_GET(url, list(), FALSE, list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  df <- to_df(res$results)
  list(status = res$status, copyright = res$copyright, meta = NULL, data = df)
}
