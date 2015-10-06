#' Campaign finance NYTimes API - candidate details
#'
#' @export
#' @template finance
#' @template nyt
#' @param fec_id FEC id
#' @references \url{http://developer.nytimes.com/docs/campaign_finance_api/}
#' @examples \dontrun{
#' cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#' cf_candidate_details(campaign_cycle = 2012, fec_id = 'P80003338')
#' }

`cf_candidate_details` <- function(campaign_cycle=NULL, fec_id=NULL, key=NULL, ...) {
  url <- sprintf("%s%s/candidates/%s.json", cf_base(), campaign_cycle, fec_id)
  args <- rc(list(`api-key` = check_key(key, "nytimes_cf_key")))
  res <- rtimes_GET(url, args, ...)
  dat <-  lapply(res$results[[1]]$other_cycles, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- to_df(dat)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res, "other_cycles"), data = df)
}
