#' Campaign finance - get new candidates
#'
#' @export
#' @template finance
#' @template nyt
#' @references \url{http://propublica.github.io/campaign-finance-api-docs}
#' @examples \dontrun{
#' cf_candidate_new(campaign_cycle = 2016)
#' cf_candidate_new(campaign_cycle = 2015)
#' cf_candidate_new(campaign_cycle = 2014)
#' }

`cf_candidate_new` <- function(campaign_cycle=NULL, key=NULL, ...) {
  url <- sprintf("%s/%s/candidates/new.json", cf_base(), campaign_cycle)
  res <- rtimes_GET(url, list(), FALSE, 
                    add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <-  lapply(res$results[[1]]$other_cycles, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- to_df(dat)
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res, "other_cycles"), data = df)
}
