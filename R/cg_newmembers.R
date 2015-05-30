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
  jsonlite::fromJSON(out, simplifyVector = FALSE)
}
