#' Search articles
#' 
#' See \url{http://developer.nytimes.com/docs/article_search_api/}
#' 
#' @import RJSONIO httr 
#' @importFrom plyr compact
#' @export
#' @template articlesearch
#' @examples \dontrun{
#' as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
#' as_search(q="bailout", facet_field = 'section_name', begin_date = "20081001", 
#'    end_date = '20081201', fl = 'word_count')
#' as_search(q="money", fq = 'The New York Times')
#' as_search(q="money", fq = 'news_desk:("Sports" "Foreign")')
#' as_search(q="bailout", hl = TRUE)
#' 
#' library(httr)
#' as_search("iowa caucus", curlopts = verbose())
#' }

`as_search` <- function(q, fq=NULL, sort=NULL, begin_date=NULL, end_date=NULL, 
  key = getOption("nytimes_as_key"), fl = NULL, hl = FALSE, 
  page = 0, facet_field = NULL, facet_filter = NULL, ..., curlopts=list())
{
  url <- "http://api.nytimes.com/svc/search/v2/articlesearch.json"
  if(!is.null(begin_date)) {
    if(is.null(end_date))
         end_date = Sys.Date()
    if(inherits(begin_date, "POSIXt") )
       begin_date = format(begin_date, "%Y%m%d")
    if(inherits(end_date, "POSIXt") )
       end_date = format(end_date, "%Y%m%d")    
  }
  if(!is.null(fl)) fl = paste(fl, collapse = ",")
  if(!is.null(facet_field)){
    if(length(facet_field)) {
      if(length(facet_field) > 5)
        stop("Only 5 facets allowed")
      facet_field = paste(facet_field, collapse = ",")
    }
  }
  if(!is.logical(hl)) stop("hl parameter must be logical")
  if(hl){ hl = 'true' } else { hl = NULL }
  args <- rtimes_compact(list(q=q, fl=fl, fq=fq, sort=sort, hl=hl, page=page,
                       begin_date=begin_date, end_date=end_date, `api-key`=key, 
                       facet_field=facet_field, facet_filter=facet_filter))
  args <- c(args, ...)
  ans <- GET(url, query = args, curlopts)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  RJSONIO::fromJSON(tt)
}