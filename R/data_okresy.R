#' data.frame of all districts (LAU1) in Czech Republic
#'
#' A dataset containing the names and other attributes of all 77
#' districts in Czech Republic. The codes (every column with string kod in
#' name) are treated as character strings even though that some of them are numbers. These codes,
#' however, serve only as IDs.
#' Colums with suffix _kod are various levels of self-government units in Czech Republic.
#'
#' @format A data frame with 77 rows and 5 variables:
#' \describe{
#'   \item{kod}{id of the district}
#'   \item{nazev}{name of the district}
#'   \item{lau1_kod}{}
#'   \item{vusc_kod}{}
#'   \item{nuts3_kod}{}
#' }
#' @source \url{http://services.cuzk.cz/shp/stat/epsg-5514/1.zip}
"okresy"
