#' Get a list of the most recent new members of the current Congress.
#'
#' @export
#' @template propubkey
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_newmembers()
#' }
cg_newmembers <- function(key = NULL, ...) {
  url <- file.path(cg_base(), "members/new.json")
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  df <- tibble::as_data_frame(to_df(res$results[[1]]$members))
  list(status = res$status, copyright = res$copyright,
       meta = do_data_frame(res), data = df)
}
