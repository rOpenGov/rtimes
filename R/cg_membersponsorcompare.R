#' Compare bill sponsorship between two members who served in the same Congress
#' and chamber.
#'
#' @export
#' @template propubkey
#' @param memberid_1 The member's unique ID number (alphanumeric). To find a
#'    member's ID number, get the list of members for the appropriate House
#'    or Senate. You can also use the Biographical Directory of the United
#'    States Congress to get a member's ID. In search results, each member's
#'    name is linked to a record by index ID (e.g.,
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041).
#'    Use the index ID as member-id in your request.
#' @param memberid_2 See description for memberid_1.
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return Compare bill sponsorship between two members who served in the same
#'    Congress and chamber.
#' @references Congress API docs 
#' <https://projects.propublica.org/api-docs/congress-api/>
#' @family congress
#' @examples \dontrun{
#' cg_membersponsorcompare(memberid_1 = 'S001181', memberid_2 = 'A000368', 
#'  congress_no = 112, chamber = 'senate')
#' }
cg_membersponsorcompare <- function(memberid_1 = NULL, memberid_2 = NULL,
  congress_no = NULL, chamber = NULL,  key = NULL, ...) {
  
  url <- sprintf('%s/members/%s/bills/%s/%s/%s.json', cg_base(), memberid_1, memberid_2, 
                 congress_no, chamber)
  res <- rtimes_GET(url, list(), FALSE, 
                    list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  df <- tibble::as_data_frame(to_df(res$results[[1]]$bills))
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res, "bills"), data = df)
}
