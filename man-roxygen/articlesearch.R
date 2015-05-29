#' @param q Search query term. Search is performed on the article body, headline 
#' and byline.
#' @param fq Filtered search query using standard Lucene syntax. The filter query 
#' can be specified with or without a limiting field: label. See fq_fields for the 
#' filter query fields.
#' @param sort (character) Default NULL. One of newest or oldest . By default, search 
#' results are sorted by their relevance to the query term (q). Use the sort parameter 
#' to sort by pub_date.
#' @param begin_date Begin date - Restricts responses to results with publication 
#' dates of the date specified or later. In the form YYYYMMDD
#' @param end_date End date - Restricts responses to results with publication dates 
#' of the date specified or earlier. In the form YYYYMMDD
#' @param fl Fields to get back, as vector. See Details for the.
#' @param hl (logical) Highlight or not, default is FALSE
#' @param page Page number. The value of page corresponds to a set of 10 results 
#' (it does not indicate the starting number of the result set). For example, page=0 
#' corresponds to records 0-9. To return records 10-19, set page to 1, not 10.
#' @param facet_field (character) Specifies the sets of facet values to include in the 
#' facets array at the end of response, which collects the facet values from all the 
#' search results. By default no facet fields will be returned. See details for options.
#' @param facet_filter (logical) Fields to facet on, as vector. When set to true, 
#' facet counts will respect any applied filters (fq, date range, etc.) in addition to 
#' the main query term. To filter facet counts, specifying at least one facet_field 
#' is required.
#' @param ... Futher args pass into query
#' @param callopts Curl options (debugging tools mostly) passed to \code{\link[httr]{GET}}
#' @details 
#' fl parameter options are: web_url, snippet, lead_paragraph, abstract, print_page, 
#' blog, source, multimedia, headline, keywords, pub_date, document_type, news_desk, 
#' byline, type_of_material, _id, word_count.
#' 
#' facet_field param options are: section_name, document_type, type_of_material, 
#' source, day_of_week
