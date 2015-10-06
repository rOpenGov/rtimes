#' Get a list of members who have left the Senate or House or have announced plans to do so.
#' 
#' @export
#' @template nytcgkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_membersleaving(112, 'house')
#' }
cg_membersleaving <- function(congress_no = NULL, chamber = NULL, key = NULL, ...) {
  url2 <- paste(cg_base(), congress_no, '/', chamber, '/members/leaving.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  df <- to_df(res$results[[1]]$members)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res), data = df)
}
