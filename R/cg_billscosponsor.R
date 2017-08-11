#' Get bill cosponsorship data for a particular member.
#'
#' @export
#'
#' @template propubkey
#' @param memberid The member's unique ID number (alphanumeric). To find a
#'    member's ID number, get the list of members for the appropriate House
#'    or Senate. You can also use the Biographical Directory of the United
#'    States Congress to get a member's ID. In search results, each member's
#'    name is linked to a record by index ID (e.g.,
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041).
#'    Use the index ID as member-id in your request.
#' @param type One of 'cosponsored' (the 20 bills most recently cosponsored
#'    by member-id) or 'withdrawn' (the 20 most recently withdrawn
#'    cosponsorships for member-id).
#' @return List of new members of he current Congress.
#' @references Congress API docs 
#' <https://projects.propublica.org/api-docs/congress-api/>
#' @family congress
#' @examples \dontrun{
#' cg_billscosponsor(memberid='B001260', type='cosponsored')
#' }

`cg_billscosponsor` <- function(memberid = NULL, type = NULL, key = NULL, ...) {
  url <- sprintf("%s/members/%s/bills/%s.json", cg_base(), memberid, type)
  res <- rtimes_GET(url, list(), FALSE, 
                    list(...), add_key(check_key(key, "PROPUBLICA_API_KEY")))
  res$results[[1]]$bills <- 
    lapply(res$results[[1]]$bills, rc)
  dat <- tibble::as_data_frame(rbind_all_df(res$results[[1]]$bills))
  meta <- tibble::as_data_frame(pop(res$results[[1]], "bills"))
  list(copyright = cright(), meta = meta, data = dat)
}
