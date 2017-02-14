#' Get a list of members who have left the Senate or House or have announced plans to do so.
#'
#' @template propubkey
#' @param memberid_1,memberid_2 The member's unique ID number (alphanumeric). To find a
#'    member's ID number, get the list of members for the appropriate House
#'    or Senate. You can also use the Biographical Directory of the United
#'    States Congress to get a member's ID. In search results, each member's
#'    name is linked to a record by index ID (e.g.,
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041).
#'    Use the index ID as member-id in your request.
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return List of new members of he current Congress.
#' @export
#' @examples \dontrun{
#' cg_membervotecompare(memberid_1 = 'S001181', memberid_2 = 'A000368', 
#'  congress_no = 112, chamber = 'senate')
#' }
cg_membervotecompare <- function(memberid_1 = NULL, memberid_2 = NULL,
  congress_no = NULL, chamber = NULL,  key = NULL, ...) {
  
  url <- sprintf('%s/members/%s/votes/%s/%s/%s.json', cg_base(), memberid_1, 
                 memberid_2, congress_no, chamber)
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  df <- tibble::as_data_frame(res$results[[1]])
  list(status = res$status, copyright = res$copyright, meta = NULL, data = df)
}
