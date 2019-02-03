#' Extract data from RUIAN for whole Czech Republic
#'
#' Extract specific layer, in form of spatial data, from RUIAN for whole Czech Republic.
#' The minor issue with these data is the size, the datasets that needs to be downloaded is roughly
#' 190 MB.
#'
#' @param layer identification of data to extract as character, see details.
#' Default value is \code{"stát"}
#' @param WGS84 convert data to WGS-84 coordinate system? Default \code{FALSE}.
#'
#' @details
#' The \code{layer} can have values from following set, the value in brackets is alias to full layer
#' name:
#' \enumerate{
#'   \item \code{"KATUZE_P"} (\code{"katastralni uzemi"})
#'   \item \code{"OBCE_P"} (\code{"obce"})
#'   \item \code{"OKRESY_P"} (\code{"okresy"})
#'   \item \code{"ORP_P"} (\code{"orp"})
#'   \item \code{"POU_P"} (\code{"pou"})
#'   \item \code{"PRARES_P"}
#'   \item \code{"REGION_P"} (\code{"regiony"})
#'   \item \code{"STATY_P"} (\code{"stat"})
#'   \item \code{"STU_P"} (\code{"stavebni úrady"})
#'   \item \code{"VO_P"} (\code{"volebni okrsky"})
#'   \item \code{"VUSC_P"} (\code{"kraje"})
#' }
#'
#' So the codes \code{layer = "OKRESY_P"} and \code{layer = "okresy"} are equal.
#'
#' @return \code{data.frame} with spatail objects (\code{\link[sf]{sf}}) of the specified layer
#'
#' @section Information about dataset:
#'  More detailed information about data can be found at the provider's website
#'  \url{http://atom.cuzk.cz/}.
#'
#' @export
#'
#' @importFrom glue glue
#' @importFrom stringr str_detect
#' @importFrom utils download.file unzip
#' @importFrom dplyr case_when
#' @importFrom sf st_read st_transform
#' @importFrom janitor clean_names
#'
#' @examples
#' obce_CR <- load_RUIAN_state(layer = "obce")
load_RUIAN_state <- function(layer = "stat", WGS84 = FALSE) {
  shp_name <- dplyr::case_when(
    layer == "katastralni uzemi" ~ "KATUZE_P.shp",
    layer == "KATUZE_P" ~ "KATUZE_P.shp",
    layer == "obce" ~ "OBCE_P.shp",
    layer == "OBCE_P" ~ "OBCE_P.shp",
    layer == "okresy" ~ "OKRESY_P.shp",
    layer == "OKRESY_P" ~ "OKRESY_P.shp",
    layer == "orp" ~ "ORP_P.shp",
    layer == "ORP_P" ~ "ORP_P.shp",
    layer == "pou" ~ "POU_P.shp",
    layer == "POU_P" ~ "POU_P.shp",
    # co je prares?
    layer == "PRARES_P" ~ "PRARES_P.shp",
    layer == "regiony" ~ "REGION_P.shp",
    layer == "REGION_P" ~ "REGION_P.shp",
    layer == "stat" ~ "STATY_P.shp",
    layer == "STATY_P" ~ "STATY_P.shp",
    layer == "stavebni urady" ~ "STU_P.shp",
    layer == "STU_P" ~ "STU_P.shp",
    layer == "volebni okrsky" ~ "VO_P.shp",
    layer == "VO_P" ~ "VO_P.shp",
    layer == "kraje" ~ "VUSC_P.shp",
    layer == "VUSC_P" ~ "VUSC_P.shp",
    TRUE ~ NA_character_
  )

  if (is.na(shp_name)) {
    stop(glue::glue(
      "Uknown layer name (or alias) - {layer}. Please look into documentation, ",
      "for allowed layer names."
    ))
  }

  dir <- .download_RUIAN()

  data <- sf::st_read(
    file.path(dir, shp_name),
    stringsAsFactors = FALSE,
    options = "ENCODING=Windows-1250",
    quiet = TRUE
  )

  if (WGS84) {
    data <- data %>%
      sf::st_transform(4326)
  }

  data %>%
    janitor::clean_names()
}
