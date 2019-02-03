#' data.frame linking codes of CSU to RUIAN codes
#'
#' Czech statistical office uses different codes to identify RUIAN elemnts. This dataset should act
#' as converter of codes from data from CSU to link them with spatial data of RUIAN.
#'
#' @format A data frame with 206 rows and 4 variables:
#' \describe{
#'   \item{typ}{type of spatail unit}
#'   \item{kod_csu}{id of spatial unit used by csu}
#'   \item{kod_ruian}{id of spatial unit used by ruian}
#'   \item{nuts3_kod}{}
#' }
#' @source \url{https://www.czso.cz/csu/czso/ciselniky}
"ciselnik_CSU"
