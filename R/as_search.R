#' Article search
#' 
#' @export
#' @template articlesearch
#' @references 
#' <http://developer.nytimes.com/docs/read/article_search_api_v2>
#' <http://developer.nytimes.com/article_search_v2.json#/README>
#' @examples \dontrun{
#' # basic search - copyright, metadata, data, and facet slots
#' (x <- as_search(q="bailout", begin_date = "20081001", 
#'   end_date = '20081005'))
#' x$copyright
#' x$meta
#' x$data
#' x$facet
#' Sys.sleep(1)
#' 
#' as_search(q="money", fq = 'The New York Times', fl = c('word_count', 
#'   'snippet', 'headline'))
#' Sys.sleep(1)
#' x <- as_search(q="bailout", hl = TRUE)
#' x$data$snippet
#' Sys.sleep(1)
#' 
#' # all results
#' (x <- as_search(q="bailout", begin_date = "20081001", 
#'   end_date = '20081003', all_results = TRUE))
#' x$meta
#' x$data
#' Sys.sleep(1)
#' 
#' # facetting
#' as_search(q="bailout", facet_field = 'section_name', begin_date = "20081001",
#'    end_date = '20081201')
#' Sys.sleep(1)
#' ## with facet filtering
#' as_search(q="bailout", facet_field = 'section_name', begin_date = "20081001",
#'    end_date = '20081201', facet_filter = TRUE)
#'    
#' # curl options
#' x <- as_search(q="bailout", begin_date = "20081001", 
#'   end_date = '20081005', callopts = list(verbose = TRUE))
#' }
`as_search` <- function(
  q, fq=NULL, sort=NULL, begin_date=NULL, end_date=NULL,
  key = NULL, fl = NULL, hl = FALSE, page = 0, all_results = FALSE, 
  try_flatten = FALSE, facet_field = NULL, facet_filter = NULL, 
  sleep = 2, ..., callopts = list()) {
  
  if (!is.null(begin_date)) {
    if (is.null(end_date))
      end_date = Sys.Date()
    if (inherits(begin_date, "POSIXt") )
      begin_date = format(begin_date, "%Y%m%d")
    if (inherits(end_date, "POSIXt") )
      end_date = format(end_date, "%Y%m%d")
  }
  if (!is.null(fl)) fl = paste(fl, collapse = ",")
  if (!is.null(facet_field)) {
    if (length(facet_field)) {
      if (length(facet_field) > 5) stop("Only 5 facets allowed")
      facet_field <- paste(facet_field, collapse = ",")
    }
  }
  if (!is.logical(hl)) stop("hl parameter must be logical")
  hl <- if (hl) 'true' else NULL
  args <- rc(list(q = q, fq = fq, fl = fl, sort = sort, hl = hl, page = page,
                  begin_date = begin_date, end_date = end_date, 
                  `api-key` = check_key(key, "NYTIMES_AS_KEY"),
                  facet_field = facet_field, facet_filter = facet_filter))
  res <- rtimes_GET(paste0(t_base(), "search/v2/articlesearch.json"), 
                    c(args, ...), TRUE, callopts)
  
  if (all_results) {
    hits <- res$response$meta$hits
    pgs <- 1:floor(hits/10)
    out <- list()
    pb <- txtProgressBar(min = 0, max = length(pgs), initial = 0, style = 3)
    on.exit(close(pb))
    for (i in seq_along(pgs)) {
      Sys.sleep(sleep)
      setTxtProgressBar(pb, i)
      args$page <- pgs[i]
      out[[i]] <- rtimes_GET(paste0(t_base(), "search/v2/articlesearch.json"), 
                             c(args, ...), TRUE, callopts)
    }
    
    dat <- bind(lapply(out, function(z) z$response$docs))
  } else {
    dat <- res$response$docs
  }
  
  if (try_flatten) {
    # completely flatten dataframe
    dat$.id <- seq_len(NROW(dat))
    todo <- which(vapply(dat, class, "") == "list")
    databin <- list()
    for (i in seq_along(todo)) {
      tmp <- dat[, todo[[i]]]
      clzz <- unique(vapply(tmp, class, character(1)))
      if (all("list" %in% clzz)) {
        tmp[vapply(tmp, length, 1) == 0] <- NA_character_
        dat[[todo[[i]]]] <- unlist(tmp)
      } else if ("data.frame" %in% clzz) {
        ncol_ <- vapply(tmp, NCOL, 1)
        if (any(ncol_  > 0)) {
          col_names <- paste(names(todo)[i], names(tmp[which.max(ncol_)][[1]]), 
                             sep = "_")
          z <- lapply(tmp, function(w) {
            if (NCOL(w) > 0 && inherits(w, "data.frame")) {
              stats::setNames(
                w, 
                paste(names(todo)[i], names(w), sep = "_")
              )
            } else {
              df <- tibble::as_tibble(t(rep(NA_character_, times = max(ncol_))))
              stats::setNames(df, col_names)
            }
          })
          zdat <- bind(z, idcol = TRUE)
          databin[[i]] <- zdat
        }
      } else {
        databin[[i]] <- todo[[i]]
      }
    }
    
    # remove old columns
    if (length(databin)) {
      for (i in seq_along(todo)) {
        if (!is.null(databin[[i]])) {
          dat <- merge(dat, databin[[i]], by = ".id")
        }
        dat[[ names(todo)[i] ]] <- NULL
      }
    }
    dat$.id <- NULL
  }
  
  # tibblize
  dat <- tibble::as_tibble(dat)
  
  list(copyright = cright(), meta = tibble::as_tibble(res$response$meta), 
       data = dat, facets = res$response$facet)
}

bind <- function(x, ...) {
  (xx <- data.table::setDF(
    data.table::rbindlist(x, use.names = TRUE, fill = TRUE, ...)
  ))
}
