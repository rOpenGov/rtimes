#' Get a list of the most recent new members of the current Congress.
#'
#' @export
#' @template propubkey
#' @param chamber One of 'house' or 'senate'.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you
#'    specify is higher than the total number of districts for that state,
#'    a 404 response will be returned.
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_memberbystatedistrict(chamber='senate', state='NH')
#' cg_memberbystatedistrict(chamber='senate', state='CA')
#' cg_memberbystatedistrict(chamber='senate', state='OR')
#' cg_memberbystatedistrict(chamber='house', state='OR', district=1)
#' }
`cg_memberbystatedistrict` <- function(chamber = NULL, state = NULL,
                                     district = NULL, key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), chamber, '/', state, '/',
                district, 'current.json', sep = '')
  if (is.null(district)) {
    url <- sprintf("%s/members/%s/%s/current.json", cg_base(), chamber, state)
  } else {
    stopifnot(!is.null(state))
    url <- sprintf("%s/members/%s/%s/%s/current.json", cg_base(), chamber, state, district)
  }
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <- tibble::as_data_frame(rbind_all_df(res$results[[1]]$bills))
  meta <- tibble::as_data_frame(pop(res$results[[1]], "bills"))
  list(copyright = cright(), meta = meta, data = dat)
}
