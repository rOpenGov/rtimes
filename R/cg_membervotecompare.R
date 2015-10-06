#' Get a list of members who have left the Senate or House or have announced plans to do so.
#' 
#' @template nytcgkey
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
#' cg_membervotecompare('S001181', 'A000368', 112, 'senate')
#' }
cg_membervotecompare <- function(memberid_1 = NULL, memberid_2 = NULL, 
  congress_no = NULL, chamber = NULL,  key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), memberid_1, '/votes/', 
                memberid_2, '/', congress_no, '/', chamber, '.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  df <- data.frame(res$results[[1]], stringsAsFactors = FALSE)
  list(status = res$status, copyright = res$copyright, meta = NULL, data = df)
}
