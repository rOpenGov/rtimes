#' Get information about a particular member's appearances on the House or 
#' Senate floor.
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
#' @return Get information about a particular member's appearances on the 
#'    House or Senate floor. 
#' @examples \dontrun{
#' cg_memberappear(memberid='S001181')
#' }
cg_memberappear <- function(memberid = NULL, key = NULL, ...)  {
  url2 <- paste(paste0(cg_base(), "members/"), memberid, '/floor_appearances.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  tt <- GET(url2, query = args, ...)
  stop_for_status(tt)
  out <- content(tt, as = 'text')
  res <- jsonlite::fromJSON(out, simplifyVector = FALSE)
  dat <- rbind_all_df(res$results[[1]]$appearances)
  meta <- data.frame(res$results[[1]][c('member_id','name','api_uri','num_results')], 
                     stringsAsFactors = FALSE)
  list(copyright = cright(), meta = meta, data = dat)
}
