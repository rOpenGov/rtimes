#' @param q Search query term. Search is performed on the article body, 
#' headline and byline.
#' @param fq Filtered search query using standard Lucene syntax. The filter 
#' query can be specified with or without a limiting field: label. See 
#' \code{fq_fields} for the filter query fields.
#' @param sort (character) Default NULL. One of newest or oldest . By default, 
#' search results are sorted by their relevance to the query term (q). Use the 
#' sort parameter to sort by pub_date.
#' @param begin_date Begin date - Restricts responses to results with publication
#' dates of the date specified or later. In the form YYYYMMDD
#' @param end_date End date - Restricts responses to results with publication 
#' dates of the date specified or earlier. In the form YYYYMMDD
#' @param fl (character) Vector of fields to return. default: all fields
#' @param hl (logical) Highlight or not, default: \code{FALSE}
#' @param page Page number. The value of page corresponds to a set of 10 
#' results (it does not indicate the starting number of the result set). For 
#' example, page=0 corresponds to records 0-9. To return records 10-19, set 
#' page to 1, not 10.
#' @param facet_field (character) Specifies the sets of facet values to include 
#' in the facets array at the end of response, which collects the facet values 
#' from all the search results. By default no facet fields will be returned. 
#' See Details for options.
#' @param facet_filter (logical) Fields to facet on, as vector. When set to 
#' \code{TRUE}, facet counts will respect any applied filters (fq, date range, 
#' etc.) in addition to the main query term. To filter facet counts, specifying 
#' at least one facet_field is required.
#' @param key your New York Times API key; pass in, or loads from .Renviron as 
#' \code{NYTIMES_AS_KEY}. See \code{\link{rtimes-package}} for info on rate 
#' limits.
#' @param ... Futher args pass into query
#' @param callopts Curl options (debugging tools mostly) passed to 
#' \code{\link[httr]{GET}}
#' @param all_results (logical) return all results. Default: \code{FALSE} 
#' @param sleep (integer) seconds to sleep between successive requests, only
#' used when \code{all_results=TRUE}
#' 
#' @details
#' \code{fl} parameter options are: 
#' \itemize{
#'  \item web_url
#'  \item snippet
#'  \item lead_paragraph
#'  \item abstract
#'  \item print_page
#'  \item blog
#'  \item source
#'  \item multimedia
#'  \item headline
#'  \item keywords
#'  \item pub_date 
#'  \item document_type
#'  \item news_desk
#'  \item byline
#'  \item type_of_material
#'  \item _id
#'  \item word_count
#' }
#'
#' \code{facet_field} param options are: 
#' \itemize{
#'  \item section_name
#'  \item document_type
#'  \item type_of_material
#'  \item source
#'  \item day_of_week
#' }
#' 
