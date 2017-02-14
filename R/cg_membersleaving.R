#' Get a list of members who have left the Senate or House or have announced plans to do so.
#'
#' @export
#' @template propubkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_membersleaving(congress_no = 112, chamber = 'house')
#' }
cg_membersleaving <- function(congress_no = NULL, chamber = NULL, key = NULL, ...) {
  url <- sprintf('%s/%s/%s/members/leaving.json', cg_base(), congress_no, chamber)
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  df <- tibble::as_data_frame(to_df(res$results[[1]]$members))
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res), data = df)
}
