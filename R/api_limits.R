#' API limits
#' 
#' Check NYT API limits and current usage.
#'
#' @param api Which API to check, either "as" or "geo".
#' @param key Your New York Times API key; pass in, or loads from .Renviron as 
#'   \code{NYTIMES_AS_KEY}.
#' 
#' @details 
#' Check the API daily limit and how many calls have already been consumed.
#' Each check consumes one API call by itself.
#' 
#' @export
#' @references 
#' <https://developer.nytimes.com/faq#9>
#' 
#' @examples 
#' \dontrun{
#' api_limits("as")
#' }
api_limits <- function(api = "as", key = NULL) {
  if (!api %in% c("as", "geo")) {
    stop("api_limits() only works for NYT article search and geo APIs ('as', 'geo')")
  }
  
  api_url <- switch(api, 
                    as = "search/v2/articlesearch.json",
                    geo = "semantic/v2/geocodes/query.json")
  api_key <- switch(api,
                    as = check_key(key, "NYTIMES_AS_KEY"),
                    geo = check_key(key, "NYTIMES_GEO_KEY"))
  
  client_url <- paste0(t_base(), api_url)
  head_path  <- switch(api,
                       as = sprintf("svc/%s?api-key=%s", api_url, api_key),
                       geo = sprintf("svc/%s?api-key=%s&country_code=EE", api_url, api_key))
  
  cli <- crul::HttpClient$new(url = client_url, opts = list(), headers = list())
  ans <- cli$head(path = head_path)
  ans$raise_for_status()
  
  resp_headers <- ans$response_headers
  out <- list(
    limit_per_day = as.numeric(resp_headers$`x-ratelimit-limit-day`),
    remaining_today = as.numeric(resp_headers$`x-ratelimit-remaining-day`)
  )
  out[["used_today"]] <- out[["limit_per_day"]] - out[["remaining_today"]]
  out
}
