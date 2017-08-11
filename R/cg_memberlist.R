#' Get a list of members of a particular chamber in a particular Congress
#'
#' @export
#' @template propubkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @param state Limits the list of members by state; two-letter state code (e.g., CA).
#' @param district Limits the list of members by district (House only). If you specify
#'    a district, you must also specify a state. If the district number you
#'    specify is higher than the total number of districts for that state,
#'    a 404 response will be returned.
#' @return List of members of a particular chamber in a particular Congress.
#' @references Congress API docs 
#' <https://projects.propublica.org/api-docs/congress-api/>
#' @family congress
#' @examples \dontrun{
#' cg_memberslist(congress_no = 112, chamber = 'senate', state = "TX")
#' cg_memberslist(112, 'senate', 'NH')
#' cg_memberslist(110, 'senate', 'NH')
#' }
`cg_memberslist` <- function(congress_no = NULL, chamber = NULL, state = NULL,
  district = NULL, key = NULL, ...) {
  
  url <- sprintf("%s/%s/%s/members.json", cg_base(), congress_no, chamber)
  args <- rc(list(state = state, district = district))
  res <- rtimes_GET(url, args, FALSE, 
                    list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  df <- tibble::as_data_frame(to_df(res$results[[1]]$members))
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res), data = df)
}
