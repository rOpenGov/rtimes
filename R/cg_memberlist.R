#' Get a list of members of a particular chamber in a particular Congress
#' 
#' @export
#' @template nytcgkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you 
#'    specify is higher than the total number of districts for that state, 
#'    a 404 response will be returned.
#' @return List of members of a particular chamber in a particular Congress.
#' @examples \dontrun{
#' cg_memberslist(112, 'senate', "TX")
#' cg_memberslist(112, 'senate', 'NH')
#' cg_memberslist(110, 'senate', 'NH')
#' }
`cg_memberslist` <- function(congress_no = NULL, chamber = NULL, state = NULL, 
  district = NULL, key = NULL, ...) {
  url2 <- paste(cg_base(), congress_no, '/', chamber, '/members.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"), state = state, district = district)
  res <- rtimes_GET(url2, args, ...)
  df <- to_df(res$results[[1]]$members)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res), data = df)
}
