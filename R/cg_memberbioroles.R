#' @title Member bio roles
#' 
#' @description Get biographical and Congressional role information for a particular member of Congress.
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
#' @return List of members of a particular chamber in a particular Congress.
#' @examples \dontrun{
#' cg_memberbioroles('S001181')
#' }
`cg_memberbioroles` <- function(memberid = NULL, key = NULL, ...) {
  url2 <- paste(paste0(cg_base(), "members/"), memberid, '.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  tt <- GET(url2, query = args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  res <- jsonlite::fromJSON(out, simplifyVector = FALSE)
  dat <- lapply(res$results[[1]]$roles, function(z) {
    if (length(z$committees) == 0) {
      list(meta = data.frame(null_to_na(pop(z, "committees")), stringsAsFactors = FALSE),
           data = NULL)
    } else {
      list(meta = data.frame(null_to_na(pop(z, "committees")), stringsAsFactors = FALSE),
           data = rbind_all_df(z$committees))
    }
  })
  meta <- data.frame(pop(res$results[[1]], "roles"), stringsAsFactors = FALSE)
  list(copyright = cright(), meta = meta, data = dat)
}
