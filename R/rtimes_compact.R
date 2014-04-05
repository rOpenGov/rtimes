#' Remove null elements from list
#' @param x Input list
#' @export
rtimes_compact <- function (x) Filter(Negate(is.null), x)