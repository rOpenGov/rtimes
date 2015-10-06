#' Get a list of members who have left the Senate or House or have announced 
#' plans to do so.
#' 
#' @export
#' @template nytcgkey
#' @param memberid The member's unique ID number (alphanumeric). To find a 
#'    member's ID number, get the list of members for the appropriate House 
#'    or Senate. You can also use the Biographical Directory of the United 
#'    States Congress to get a member's ID. In search results, each member's 
#'    name is linked to a record by index ID (e.g., 
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041). 
#'    Use the index ID as member-id in your request.
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_membervotepositions('S001181')
#' }
cg_membervotepositions <- function(memberid = NULL, key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), memberid, '/votes.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  dat <-  lapply(res$results[[1]]$votes, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- to_df(dat)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res, "votes"), data = df)  
}
