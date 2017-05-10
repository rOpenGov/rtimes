#' Geographic search NYTimes API
#'
#' @export
#' @template geographic
#' @param key your New York Times API key; pass in, or loads from .Rprofile as
#' \code{nytimes_geo_key}, or from .Renviron as \code{NYTIMES_GEO_KEY}
#' @param ... Curl options (debugging tools mostly) passed to 
#' \code{\link[httr]{GET}}
#' @references \url{http://developer.nytimes.com/geo_api_v2.json}
#' @details BEWARE: the docs are a hot mess - the README page has examples that
#' include parameters that are not in their list of accepted query
#' parameters. Some query parameter that used to work don't work now. There
#' seems to be no way to get a response from them. So good luck. 
#' @examples \dontrun{
#' geo_search(country_code = 'US')
#' geo_search(feature_class='P', country_code='US', population='50000_')
#' 
#' # FIXME: these should work, but don't anymore
#' #geo_search(elevation = '2000_', feature_class='P')
#' #geo_search(elevation = '_3000', feature_class='P')
#' #geo_search(elevation = '2000_3000', feature_class='P')
#' # geo_search(nearby=c(38.920833,-94.622222), population='100000_', 
#' #   feature_class='P')
#'
#' # curl options
#' library("httr")
#' geo_search(country_code = 'US', config = verbose())
#' }

`geo_search` <- function(name = NULL, latitude = NULL, longitude = NULL, elevation = NULL,
  population = NULL, country_code = NULL, country_name = NULL, admin_code1 = NULL,
  admin_name1 = NULL, admin_code2 = NULL, admin_name2 = NULL, admin_code3 = NULL,
  admin_name3 = NULL, admin_code4 = NULL, admin_name4 = NULL, feature_class = NULL,
  feature_class_name = NULL, feature_code_name = NULL, time_zone_id = NULL, dst_offset = NULL,
  gmt_offset = NULL, bounding_box = NULL, nearby = NULL, offset = NULL, limit=100, key=NULL, ...) {

  nearby <- nnlcol(nearby)
  bounding_box <- nnlcol(bounding_box)
  args <- rc(list(name=name,latitude=latitude,longitude=longitude,elevation=elevation,
      population=population,country_code=country_code,country_name=country_name,
      admin_code1=admin_code1,admin_name1=admin_name1,
      admin_code2=admin_code2,admin_name2=admin_name2,admin_code3=admin_code3,
      admin_name3=admin_name3,admin_code4=admin_code4,
      admin_name4=admin_name4,feature_class=feature_class,feature_class_name=feature_class_name,
      feature_code_name=feature_code_name,
      time_zone_id=time_zone_id,dst_offset=dst_offset,gmt_offset=gmt_offset,
      bounding_box=bounding_box,nearby=nearby,
      offset=offset, perpage=limit, `api-key`=check_key(key)))

  res <- rtimes_GET(paste0(t_base(), "semantic/v2/geocodes/query.json"), args, ...)
  list(
    copyright = cright(),
    meta = meta(res),
    data = tibble::as_data_frame(res$results)
  )
}
