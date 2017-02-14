#' Get a list of members who have left the Senate or House or have announced
#' plans to do so.
#'
#' @export
#' @template propubkey
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
  url <- sprintf("%s/members/%s/votes.json", cg_base(), memberid)
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <-  lapply(res$results[[1]]$votes, function(z) {
    if (length(z$bill) == 0) z$bill <- NULL
    as.list(unlist(z, recursive = TRUE))
  })
  df <- tibble::as_data_frame(to_df(dat))
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res, "votes"), data = df)
}
