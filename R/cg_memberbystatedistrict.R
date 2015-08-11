#' Get a list of the most recent new members of the current Congress.
#' 
#' @export
#' @template nytcgkey
#' @param chamber One of 'house' or 'senate.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you 
#'    specify is higher than the total number of districts for that state, 
#'    a 404 response will be returned.
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_memberbystatedistrict(chamber='senate', state='NH')
#' }
`cg_memberbystatedistrict` <- function(chamber = NULL, state = NULL, 
                                     district = NULL, key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), chamber, '/', state, '/', 
                district, 'current.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  tt <- GET(url2, query = args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  res <- jsonlite::fromJSON(out, simplifyVector = FALSE)
  dat <- rbind_all_df(res$results[[1]]$bills)
  meta <- data.frame(pop(res$results[[1]], "bills"), stringsAsFactors = FALSE)
  list(copyright = cright(), meta = meta, data = dat)
}
