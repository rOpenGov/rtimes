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
  tt <- GET(url2, query = args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  res <- jsonlite::fromJSON(out, simplifyVector = FALSE)
  dat <- rbind_all(lapply(res$results[[1]]$members, data.frame, stringsAsFactors = FALSE))
  list(copyright = cright(), meta = do_data_frame(res), data = dat)
}
