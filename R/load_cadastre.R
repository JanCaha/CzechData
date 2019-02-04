#' Extract data from Cadastral map
#'
#' Extract specific layer, in form of spatial data, from cadastral map for given cadastral
#' territory in Czech Republic. Checks are performed to find out if the provided \code{id} is valid
#' for some cadastral territory in Czech Republic.
#'
#' @param id id of cadastral territory as character
#' @param layer identification of data to extract as character, see details.
#' Default value is \code{"katastralni území"}
#' @param WGS84 convert data to WGS-84 coordinate system? Default \code{FALSE}.
#'
#' @details
#' The \code{layer} can have values from following set, the value in brackets is alias to full layer
#' name:
#' \enumerate{
#'   \item \code{"BODOVE_POLE_B"}
#'   \item \code{"BODOVE_POLE_T"}
#'   \item \code{"BUDOVY_B"} (\code{"budovy body"})
#'   \item \code{"BUDOVY_DEF"}
#'   \item \code{"BUDOVY_P"} (\code{"budovy"})
#'   \item \code{"DALSI_PRVKY_MAPY_B"}
#'   \item \code{"DALSI_PRVKY_MAPY_L"}
#'   \item \code{"DALSI_PRVKY_MAPY_T"}
#'   \item \code{"HRANICE_PARCEL_L"} (\code{"hranice parcel"})
#'   \item \code{"KATASTRALNI_UZEMI_DEF"}
#'   \item \code{"KATASTRALNI_UZEMI_L"}
#'   \item \code{"KATASTRALNI_UZEMI_P"} (\code{"katastralni uzemi"})
#'   \item \code{"PARCELY_KN_B"}
#'   \item \code{"PARCELY_KN_DEF"}
#'   \item \code{"PARCELY_KN_L"}
#'   \item \code{"PARCELY_KN_P"} (\code{"parcely"})
#'   \item \code{"PRVKY_ORIENT_MAPY_B"}
#'   \item \code{"PRVKY_ORIENT_MAPY_L"}
#'   \item \code{"PRVKY_ORIENT_MAPY_T"}
#'   \item \code{"VB_P"}
#' }
#' So the codes \code{layer = "BUDOVY_B"} and \code{layer = "budovy body"} are equal.
#'
#' The values of \code{id} follow general pattern of six number with first number being 6,7 or 9.
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
#' @importFrom utils data download.file unzip
#' @importFrom dplyr case_when
#' @importFrom sf st_read st_transform
#' @importFrom janitor clean_names
#'
#' @examples
#' parcely_vyskov <- load_cadastral_territory("788571", layer = "parcely")
load_cadastral_territory <- function(id, layer = "katastralni uzemi", WGS84 = FALSE) {


  # verify and preprocess inputs ----------------------------------------------------------------


  if (!is.character(id)) {
    stop("Variable id must be a character.")
  }

  if (!stringr::str_detect(id, "^[6|7|9][[:digit:]]{5}")) {
    stop("Variable id must follow the general pattern of 6 digits and starting with 5.")
  }

  if (!(id %in% CzechData::katastralni_uzemi$kod)) {
    stop(glue::glue("There is no settlement in Czech Republic with code {id}."))
  }

  shp_name <- dplyr::case_when(
    layer == "BODOVE_POLE_B" ~ "BODOVE_POLE_B.shp",
    layer == "BODOVE_POLE_T" ~ "BODOVE_POLE_T.shp",
    layer == "budovy body" ~ "BUDOVY_B.shp",
    layer == "BUDOVY_B" ~ "BUDOVY_B.shp",
    layer == "BUDOVY_DEF" ~ "BUDOVY_DEF.shp",
    layer == "budovy" ~ "BUDOVY_P.shp",
    layer == "BUDOVY_P" ~ "BUDOVY_P.shp",
    layer == "DALSI_PRVKY_MAPY_B" ~ "DALSI_PRVKY_MAPY_B.shp",
    layer == "DALSI_PRVKY_MAPY_L" ~ "DALSI_PRVKY_MAPY_L.shp",
    layer == "DALSI_PRVKY_MAPY_T" ~ "DALSI_PRVKY_MAPY_T.shp",
    layer == "hranice parcel" ~ "HRANICE_PARCEL_L.shp",
    layer == "HRANICE_PARCEL_L" ~ "HRANICE_PARCEL_L.shp",
    layer == "KATASTRALNI_UZEMI_DEF" ~ "KATASTRALNI_UZEMI_DEF.shp",
    layer == "KATASTRALNI_UZEMI_L" ~ "KATASTRALNI_UZEMI_L.shp",
    layer == "katastralni uzemi" ~ "KATASTRALNI_UZEMI_P.shp",
    layer == "KATASTRALNI_UZEMI_P" ~ "KATASTRALNI_UZEMI_P.shp",
    layer == "PARCELY_KN_B" ~ "PARCELY_KN_B.shp",
    layer == "PARCELY_KN_DEF" ~ "PARCELY_KN_DEF.shp",
    layer == "PARCELY_KN_L" ~ "PARCELY_KN_L.shp",
    layer == "parcely" ~ "PARCELY_KN_P.shp",
    layer == "PARCELY_KN_P" ~ "PARCELY_KN_P.shp",
    layer == "PRVKY_ORIENT_MAPY_B" ~ "PRVKY_ORIENT_MAPY_B.shp",
    layer == "PRVKY_ORIENT_MAPY_L" ~ "PRVKY_ORIENT_MAPY_L.shp",
    layer == "PRVKY_ORIENT_MAPY_T" ~ "PRVKY_ORIENT_MAPY_T.shp",
    layer == "VB_P" ~ "VB_P.shp",
    TRUE ~ NA_character_
  )

  if (is.na(shp_name)) {
    stop(glue::glue(
      "Uknown layer name (or alias) - {layer}. Please look into documentation, ",
      "for allowed layer names."
    ))
  }

  # download and select the data ----------------------------------------------------------------

  dir <- tempdir()

  url <- glue::glue("http://services.cuzk.cz/shp/ku/epsg-5514/{id}.zip")

  ku_file <- file.path(dir, glue::glue("{id}.zip"))

  if (!file.exists(ku_file)) {
    utils::download.file(url, ku_file, quiet = TRUE)
  }

  unzip(ku_file, exdir = dir)

  data <- sf::st_read(
    file.path(dir, id, shp_name),
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
