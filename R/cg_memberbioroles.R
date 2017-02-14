#' @title Member bio roles
#'
#' @description Get biographical and Congressional role information for a particular member of Congress.
#'
#' @export
#' @template propubkey
#' @param memberid The member's unique ID number (alphanumeric). To find a
#'    member's ID number, get the list of members for the appropriate House
#'    or Senate. You can also use the Biographical Directory of the United
#'    States Congress to get a member's ID. In search results, each member's
#'    name is linked to a record by index ID (e.g.,
#'    http://bioguide.congress.gov/scripts/biodisplay.pl?index=C001041).
#'    Use the index ID as member-id in your request.
#' @return List of members of a particular chamber in a particular Congress.
#' @examples \dontrun{
#' cg_memberbioroles(memberid = 'S001181')
#' }
`cg_memberbioroles` <- function(memberid = NULL, key = NULL, ...) {
  url <- sprintf("%s/members/%s.json", cg_base(), memberid)
  res <- rtimes_GET(url, list(), FALSE, add_key(check_key(key, "PROPUBLICA_API_KEY")), ...)
  dat <- lapply(res$results[[1]]$roles, function(z) {
    if (length(z$committees) == 0) {
      list(meta = tibble::as_data_frame(null_to_na(pop(z, "committees"))),
           data = tibble::data_frame())
    } else {
      list(meta = tibble::as_data_frame(null_to_na(pop(z, "committees"))),
           data = tibble::as_data_frame(rbind_all_df(z$committees)))
    }
  })
  meta <- pop(res$results[[1]], "roles")
  meta <- meta[!duplicated(names(meta))]
  meta <- tibble::as_data_frame(meta)
  list(copyright = cright(), meta = meta, data = dat)
}
