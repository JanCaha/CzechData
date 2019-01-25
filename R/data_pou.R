#' data.frame of all settlements of type II (pou) in Czech Republic
#'
#' A dataset containing the names and other attributes of all 393
#' settlements of type II (pou) in Czech Republic. The codes (every column with string kod in
#' name) are treated as character strings even though that some of them are numbers. These codes,
#' however, serve only as IDs.
#' Colums with suffix _kod are various levels of self-government units in Czech Republic.
#'
#' @format A data frame with 393 rows and 5 variables:
#' \describe{
#'   \item{kod}{id of the settlements of type II (pou)}
#'   \item{nazev}{name of the settlements of type II (pou)}
#'   \item{orp_kod}{}
#'   \item{vusc_kod}{}
#'   \item{nuts3_kod}{}
#' }
#' @source \url{http://services.cuzk.cz/shp/stat/epsg-5514/1.zip}
"pou"