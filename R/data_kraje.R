#' data.frame of all regions(NUTS3) in Czech Republic
#'
#' A dataset containing the names and other attributes of all 14
#' regions in Czech Republic. The codes (every column with string kod in
#'  name) are treated as character strings even though that some of them are numbers. These codes,
#'  however, serve only as IDs.
#'  Colums with suffix _kod are various levels of self-government units in Czech Republic.
#'
#' @format A data frame with 14 rows and 4 variables:
#' \describe{
#'   \item{kod}{id of the region}
#'   \item{nazev}{name of the region}
#'   \item{sou_kod}{}
#'   \item{nuts3_kod}{}
#' }
#' @source \url{http://services.cuzk.cz/shp/stat/epsg-5514/1.zip}
"kraje"
