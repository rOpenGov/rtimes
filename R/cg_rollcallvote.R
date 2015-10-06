#' Get a specific roll-call vote, including a complete list of member positions.
#' 
#' @export
#' @template nytcgkey
#' @param congress_no The number of the Congress during which the members served.
#' @param chamber One of 'house' or 'senate.
#' @param session_no 1, 2, or special session number (For a detailed list of 
#'    Congressional sessions, see 
#'    http://www.senate.gov/reference/resources/pdf/congresses2.pdf).
#' @param rollcall_no Integer. To get roll-call numbers, see the official sites 
#'    of the US Senate 
#'    (http://www.senate.gov/pagelayout/legislative/a_three_sections_with_teasers/votes.htm),
#'    and US House (http://artandhistory.house.gov/house_history/index.aspx).
#' @return Get a specific roll-call vote, including a complete list of member 
#'    positions. A list with metadata about the bill, and vote results.
#' @examples \dontrun{
#' cg_rollcallvote(105, 'house', 2, 38)
#' }
cg_rollcallvote <- function(congress_no = NULL, chamber = NULL, session_no = NULL, 
                            rollcall_no = NULL, key = NULL, ...) {
  
  url2 <- paste(cg_base(), congress_no, '/', chamber, '/sessions/', session_no, 
                '/votes/', rollcall_no, '.json', sep = '')
  args <- list('api-key' = check_key(key, "nytimes_cg_key"))
  res <- rtimes_GET(url2, args, ...)
  dat <- rbind_all_df(res$results$votes$vote$positions)
  meta <- data.frame(res$results$votes$vote[c('congress', 'session', 'chamber', 'roll_call', 
      'question', 'description', 'vote_type', 'date', 'time', 'result')], stringsAsFactors = FALSE)
  votes <- rbind_all_df(res$results$votes$vote[c('democratic', 'republican', 'independent', 'total')])
  list(copyright = cright(), 
       bill_info = res$results$votes$vote$bill, 
       meta = meta, 
       votes = votes)
}
