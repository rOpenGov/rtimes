#' Campaign finance - candidates from a state
#'
#' @export
#' @template finance
#' @template nyt
#' @param state	(character) Two-letter state abbreviation. required.
#' @param chamber	(character) house or senate. required.
#' @param district (character) Specify the district number. Use 1 for states 
#' with a single representative. (House requests only - districts with 
#' Senate requests will be ignored.). required.
#' @references <http://propublica.github.io/campaign-finance-api-docs>
#' @family campaign-finance
#' @examples \dontrun{
#' cf_candidate_state(campaign_cycle = 2014, state = "TX")
#' cf_candidate_state(campaign_cycle = 2012, state = "NM")
#' cf_candidate_state(campaign_cycle = 2016, state = "OR", chamber = "senate")
#' cf_candidate_state(campaign_cycle = 2016, state = "CA", 
#'   chamber = "house", district = 2)
#' }

`cf_candidate_state` <- function(campaign_cycle, state, chamber = NULL, 
                                 district = NULL, key = NULL, ...) {
  
  url <- sprintf("%s/%s/races/%s", cf_base(), campaign_cycle, 
                 state)
  if (!is.null(chamber)) url <- file.path(url, chamber)
  if (!is.null(district)) {
    if (is.null(chamber)) {
      stop("if 'district' given, 'chamber' must also be given")
    }
    url <- file.path(url, district)
  }
  url <- paste0(url, ".json")
  res <- rtimes_GET(url, list(), FALSE, 
                    list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  dat <-  lapply(res$results[[1]]$other_cycles, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- to_df(dat)
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res, "other_cycles"), data = df)
}
