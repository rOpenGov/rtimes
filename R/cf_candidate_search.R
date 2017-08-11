#' Campaign finance - candidate search
#'
#' @keywords internal
#' @template finance
#' @template nyt
#' @param query Last name of a candidate
#' @references <http://propublica.github.io/campaign-finance-api-docs>
#' @family campaign-finance
#' @examples \dontrun{
#' cf_candidate_search(campaign_cycle = 2016, query='Wilson')
#' cf_candidate_search(campaign_cycle = 2008, query='obama')
#' }

`cf_candidate_search` <- function(campaign_cycle=NULL, query=NULL, key = NULL, ...) {
  url <- sprintf("%s/%s/candidates/search.json", cf_base(), campaign_cycle)
  args <- rc(list(query = query))
  res <- rtimes_GET(url, args, FALSE, list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  tmp <- pop(res, "results")
  tmp$data <- dplyr::bind_rows(lapply(res$results, function(x){
    x[sapply(x, is.null)] <- NA
    data.frame(x, stringsAsFactors = FALSE)
  }))
  tmp
}
