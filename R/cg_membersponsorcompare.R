#' Compare bill sponsorship between two members who served in the same Congress 
#' and chamber.
#'    
#' @template nytcgkey
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
#' @export
#' @examples \dontrun{
#' cg_membersponsorcompare('S001181', 'A000368', 112, 'senate')
#' }
cg_membersponsorcompare <- function(memberid_1 = NULL, memberid_2 = NULL, 
  congress_no = NULL, chamber = NULL,  key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), memberid_1, '/bills/', memberid_2, '/',
                congress_no, '/', chamber, '.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  df <- to_df(res$results[[1]]$bills)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res, "bills"), data = df)  
}
