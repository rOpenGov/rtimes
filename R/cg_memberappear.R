#' Get information about a particular member's appearances on the House or
#' Senate floor.
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
#' @return Get information about a particular member's appearances on the
#'    House or Senate floor.
#' @examples \dontrun{
#' cg_memberappear(memberid='S001181')
#' }
cg_memberappear <- function(memberid = NULL, key = NULL, ...)  {
  url <- sprintf("%s/members/%s/floor_appearances.json", cg_base(), memberid)
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <- tibble::as_data_frame(rbind_all_df(res$results[[1]]$appearances))
  meta <- tibble::as_data_frame(res$results[[1]][c('member_id','name','api_uri','num_results')])
  list(copyright = cright(), meta = meta, data = dat)
}
