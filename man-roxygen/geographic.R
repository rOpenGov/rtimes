#' @param name (character) A displayable name for the specified place.
#' @param latitude (numeric) The latitude of the specified place.
#' @param longitude (numeric) The longitude of the specified place.
#' @param elevation (character) The elevation of the specified place, in meters.
#' @param population (numeric) Te population of the specified place.
#' @param country_code (character) The country code, as given in ISO-3611, of the specified place.
#' @param country_name (character) The country name of the specified place.
#' @param admin_code1 (character) A code for the first level administrative division containing 
#' the specified place. In the case of US locations this will be the containing state’s postal 
#' code. All geonames admin_code1 records can be found at 
#' http://download.geonames.org/export/dump/admin1Codes.txt.
#' @param admin_name1 (character) The name of the first level administrative division containing 
#' the specified place. In the case of US locations this will be the full name of the containing 
#' State.
#' @param admin_code2 (character) A code for the second level administrative division containing 
#' the specified place. In the case of US locations this will be a code for the containing county. 
#' All geonames admin_code2 records can be found at 
#' http://download.geonames.org/export/dump/admin2Codes.txt
#' @param admin_name2 (character) The name of the second level administrative division containing 
#' the specified place. In the case of US locations this will be the name of the containing county.
#' @param admin_code3 (character) A code for the third level administrative division containing the 
#' specified place. This is infrequently used and never used for US locations.
#' @param admin_name3 (character) The name of the third level administrative division containing 
#' the specified place. This is infrequently used and never used for US locations.
#' @param admin_code4 (character) A code for the fourth level administrative division containing 
#' the specified place. This is infrequently used and never used for US locations.
#' @param admin_name4 (character) The name of the fourth level administrative division containing 
#' the specified place. This is infrequently used and never used for US locations.
#' @param feature_class	(character) The high-level feature class of the location. The feature 
#' classes are as follows:
#' \itemize{
#'  \item A - Administrative Boundary Features
#'  \item H - Hydrographic Features
#'  \item L - Area Features
#'  \item P - Populated Place Features
#'  \item R - Road / Railroad Features
#'  \item S - Spot Features
#'  \item T - Hypsographic Features
#'  \item U - Undersea Features
#'  \item V - Vegetation Features
#' }
#' @param feature_class_name (character) See list of name values associated with feature_class 
#' above.
#' @param feature_code_name (character) A code for the type of feature represented by this geonames 
#' record. The complete list of feature codes can be found at 
#' http://download.geonames.org/export/dump/featureCodes_en.txt.
#' @param time_zone_id (character) The time zone containing this geonames record.
#' @param dst_offset (numeric) The offset from GMT during daylight savings time.
#' @param gmt_offset (numeric) The offset from GMT during standard time.
#' @param bounding_box (numeric) List of coordinates in the following format <North East Latitude>,
#' <North East Longitude>,<South West Latitude>,<South West Longitude>. For example: 
#' 39.985417852135356,-93.18850617968747,37.84003257271992,-95.94607453906247.
#' @param nearby (numeric) A latitude longitude pair (e.g. 41.9,12.5). When provided with this 
#' parameter, the geocodes API will return the 20 results that are geographically nearest to the 
#' specified latitude/longitude pair.
#' @param offset (numeric) The offset in the results.
#' @param limit	(numeric) If not specified 20 results are returned. Otherwise the specified number 
#' of results or a maximum of 20 results are returned. 