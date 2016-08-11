#' Campaign finance - candidates from a state
#'
#' @export
#' @template finance
#' @template nyt
#' @param state	(character) Two-letter state abbreviation
#' @param chamber	(character) house or senate (optional)
#' @param district (character) Specify the district number. Use 1 for states 
#' with a single representative. (House requests only - districts with 
#' Senate requests will be ignored.)
#' @references \url{http://propublica.github.io/campaign-finance-api-docs}
#' @examples \dontrun{
#' cf_candidate_state(campaign_cycle = 2016, state = "DE")
#' cf_candidate_state(campaign_cycle = 2016, state = "CA")
#' }

`cf_candidate_state` <- function(campaign_cycle=NULL, state=NULL, chamber=NULL, 
                                 district=NULL, key=NULL, ...) {
  
  url <- sprintf("%s/%s/seats/%s.json", cf_base(), campaign_cycle, state)
  res <- rtimes_GET(url, list(), add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <-  lapply(res$results[[1]]$other_cycles, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- to_df(dat)
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res, "other_cycles"), data = df)
}
