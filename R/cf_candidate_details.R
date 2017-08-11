#' Campaign finance - candidate details
#'
#' @export
#' @template finance
#' @template nyt
#' @param fec_id FEC id
#' @references <http://propublica.github.io/campaign-finance-api-docs>
#' @family campaign-finance
#' @examples \dontrun{
#' cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#' cf_candidate_details(campaign_cycle = 2012, fec_id = 'P80003338')
#' }
`cf_candidate_details` <- function(campaign_cycle=NULL, fec_id=NULL, key=NULL, ...) {
  url <- sprintf("%s/%s/candidates/%s.json", cf_base(), campaign_cycle, fec_id)
  res <- rtimes_GET(url, list(), FALSE, list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  list(status = res$status, copyright = res$copyright,
       data = do_data_frame(res, "other_cycles"))
}
