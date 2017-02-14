#' Get a specific roll-call vote, including a complete list of member positions.
#'
#' @export
#' @template propubkey
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
#' cg_rollcallvote(congress_no = 105, chamber = 'house', session_no = 2, 
#'   rollcall_no = 38)
#' }
cg_rollcallvote <- function(congress_no = NULL, chamber = NULL, session_no = NULL,
                            rollcall_no = NULL, key = NULL, ...) {

  url <- sprintf('%s/%s/%s/sessions/%s/votes/%s.json', cg_base(), congress_no, 
                 chamber, session_no, rollcall_no)
  res <- rtimes_GET(url, list(), FALSE, 
                    add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <- tibble::as_data_frame(rbind_all_df(res$results$votes$vote$positions))
  meta <- tibble::as_data_frame(res$results$votes$vote[c('congress', 'session', 
                                                         'chamber', 'roll_call',
      'question', 'description', 'vote_type', 'date', 'time', 'result')])
  votes <- bind_rows(
    res$results$votes$vote[c('democratic', 'republican', 
                             'independent', 'total')], 
    .id = "category"
  )
  list(copyright = cright(),
       bill_info = res$results$votes$vote$bill,
       meta = meta,
       votes = votes)
}
