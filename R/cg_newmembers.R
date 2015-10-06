#' Get a list of the most recent new members of the current Congress.
#' 
#' @export
#' @template nytcgkey
#' @return List of new members of he current Congress.
#' @examples \dontrun{
#' cg_newmembers()
#' }
cg_newmembers <- function(key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/new"), '.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  df <- to_df(res$results[[1]]$members)
  list(status = res$status, copyright = res$copyright, 
       meta = do_data_frame(res), data = df)
}
