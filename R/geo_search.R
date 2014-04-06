#' Geographic search NYTimes API
#' 
#' See \url{http://developer.nytimes.com/docs/geographic_api}
#' 
#' @import jsonlite httr 
#' @export
#' @template geographic
#' @template nyt
#' @examples \dontrun{
#' geo_search(country_code = 'US')
#' geo_search(elevation = '2000_', feature_class='P')
#' geo_search(elevation = '_3000', feature_class='P')
#' geo_search(elevation = '2000_3000', feature_class='P')
#' geo_search(feature_class='P', country_code='US', population='50000_')
#' geo_search(nearby=c(38.920833,-94.622222), population='100000_', feature_class='P')
#' }

`geo_search` <- function(name = NULL,latitude = NULL,longitude = NULL,elevation = NULL,
  population = NULL,country_code = NULL,country_name = NULL,admin_code1 = NULL,admin_name1 = NULL,
  admin_code2 = NULL,admin_name2 = NULL,admin_code3 = NULL,admin_name3 = NULL,admin_code4 = NULL,
  admin_name4 = NULL,feature_class = NULL,feature_class_name = NULL,feature_code_name = NULL,
  time_zone_id = NULL,dst_offset = NULL,gmt_offset = NULL,bounding_box = NULL,nearby = NULL,
  offset = NULL,limit=20,key=getOption("nytimes_geo_key"),callopts=list())
{
  url <- "http://api.nytimes.com/svc/semantic/v2/geocodes/query.json"
  nearby <- ifnotnullcollapse(nearby)
  bounding_box <- ifnotnullcollapse(bounding_box)
  args <- rtimes_compact(list(name=name,latitude=latitude,longitude=longitude,elevation=elevation,
      population=population,country_code=country_code,country_name=country_name,
      admin_code1=admin_code1,admin_name1=admin_name1,
      admin_code2=admin_code2,admin_name2=admin_name2,admin_code3=admin_code3,
      admin_name3=admin_name3,admin_code4=admin_code4,
      admin_name4=admin_name4,feature_class=feature_class,feature_class_name=feature_class_name,
      feature_code_name=feature_code_name,
      time_zone_id=time_zone_id,dst_offset=dst_offset,gmt_offset=gmt_offset,
      bounding_box=bounding_box,nearby=nearby,
      offset=offset,limit=limit,`api-key`=key))
  ans <- GET(url, query = args, callopts)
  stop_for_status(ans)
  tt <- content(ans, as = "text")
  jsonlite::fromJSON(tt, simplifyVector = FALSE)
}

ifnotnullcollapse <- function(x) if(!is.null(x)){ paste(x, collapse = ",")} else { NULL }