#' data.frame of all cadastral territories in Czech Republic
#'
#' A dataset containing the names and other attributes of all 13,078
#'  cadastral territories in Czech Republic. The codes (every column with string kod in
#'  name) are treated as character strings even though that some of them are numbers. These codes,
#'  however, serve only as IDs.
#'  Colums with suffix _kod are various levels of self-government units in Czech Republic.
#'
#' @format A data frame with 13078 rows and 9 variables:
#' \describe{
#'   \item{kod}{id of the cadastral territory}
#'   \item{nazev}{name of the cadastral territory}
#'   \item{obec_kod}{}
#'   \item{pou_kod}{}
#'   \item{orp_kod}{}
#'   \item{okres_kod}{}
#'   \item{lau1_kod}{}
#'   \item{vusc_kod}{}
#'   \item{prares_kod}{}
#' }
#' @source \url{http://services.cuzk.cz/shp/stat/epsg-5514/1.zip}
"katastralni_uzemi"