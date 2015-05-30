#' Search articles
#'
#' @export
#' @template articlesearch
#' @references \url{http://developer.nytimes.com/docs/article_search_api/}
#' @examples \dontrun{
#' as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
#' as_search(q="bailout", facet_field = 'section_name', begin_date = "20081001",
#'    end_date = '20081201', fl = 'word_count')
#' as_search(q="money", fq = 'The New York Times')
#' as_search(q="money", fq = 'news_desk:("Sports" "Foreign")')
#' as_search(q="bailout", hl = TRUE)
#'
#' library('httr')
#' as_search("iowa caucus", callopts = verbose())
#' }

`as_search` <- function(q, fq=NULL, sort=NULL, begin_date=NULL, end_date=NULL,
  key = NULL, fl = NULL, hl = FALSE,
  page = 0, facet_field = NULL, facet_filter = NULL, ..., callopts=list())
{
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
  args <- rc(list(q=q, fl=fl, fq=fq, sort=sort, hl=hl, page=page,
                begin_date=begin_date, end_date=end_date, `api-key`=check_key(key, "nytimes_as_key"),
                facet_field=facet_field, facet_filter=facet_filter))
  res <- rtimes_GET(paste0(t_base(), "search/v2/articlesearch.json"), c(args, ...), callopts, ...)
  dat <- if(is.null(fl)) lapply(res$response$docs, structure, class="as_search") else res$response
  list(copyright=cright(), meta=as_meta(res), data=dat)
}

#' @export
print.as_search <- function(x, ...){
  cat("<NYTimes article>", x$headline$main, "\n", sep = "")
  cat("  Type: ", x$type_of_material, "\n", sep = "")
  cat("  Published: ", x$pub_date, "\n", sep = "")
  cat("  Word count: ", x$word_count, "\n", sep = "")
  cat("  URL: ", x$web_url, "\n", sep = "")
  cat("  Snippet: ", x$snippet, "\n", sep = "")
}

# as_proc <- function(y){
#   tt <-
#     pop(y, c("web_url","snippet","lead_paragraph","abstract",""))
#   df <- data.frame(tt, stringsAsFactors = FALSE)
#   tmp <- data.frame(t(sapply(pop(y$geocode, "geocode_id"), nnlna, USE.NAMES = FALSE)), stringsAsFactors = FALSE)
#   cbind(df, tmp)
# }
