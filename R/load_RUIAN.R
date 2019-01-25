#' Extract data from RUIAN
#'
#' Extract specific layer, in form of spatial data, from RUIAN for given settlement in
#' Czech Republic. Checks are performed to find out if the provided \code{id} is valid for some
#' settlement in Czech Republic.
#'
#' In case of adress places (using ADRM_B or adresni mista as layer) are checked, the csv file with
#' more attributes is also downloaded and linked to the spatial data layer.
#'
#' @param id id of settlement as character
#' @param layer identification of data to extract as character, see details.
#' Default value is \code{"obec"}
#' @param WGS84 convert data to WGS-84 coordinate system? Default \code{FALSE}.
#'
#' @details
#' The \code{layer} can have values from following set, the value in brackets is alias to full layer
#' name:
#' \enumerate{
#'   \item \code{"ADRM_B"} (\code{"adresni mista"})
#'   \item \code{"CO_B"} (\code{"casti obce"})
#'   \item \code{"KU_P"} (\code{"katastralni uzemi"})
#'   \item \code{"OBEC_P"} (\code{"obec"})
#'   \item \code{"SO_B"} (\code{"stavebni objekty"})
#'   \item \code{"UL_L"} (\code{"ulice"})
#'   \item \code{"VO_P"} (\code{"volebni okrsky"})
#'   \item \code{"ZSJ_P"} (\code{"zakladni sidelni jednotky"})
#'   \item \code{"MOMC_P"}
#'   \item \code{"MOP_P"}
#'   \item \code{"SOP_P"}
#' }
#' So the codes \code{layer = "CO_B"} and \code{layer = "casti obce"} are equal.
#'
#' The values of \code{id} follow general pattern of six number with first number being 5.
#'
#' @return \code{data.frame} with spatail objects (\code{\link[sf]{sf}}) of the specified layer
#'
#' @section Information about dataset:
#'  More detailed information about data can be found at the provider website
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
#' adresy_vyskov <- load_RUIAN_settlement("592889", layer = "adresni mista")

load_RUIAN_settlement <- function(id, layer = "obec", WGS84 = FALSE){


  # verify and preprocess inputs ----------------------------------------------------------------


  if (!is.character(id)) {
    stop("Variable id must be a character.")
  }

  if (!stringr::str_detect(id, "^5[[:digit:]]{5}")) {
    stop("Variable id must follow the general pattern of 6 digits and starting with 5.")
  }

  if (!(id %in% CzechData::obce$kod)) {
    stop(glue::glue("There is no settlement in Czech Republic with code {id}."))
  }

  shp_name <- dplyr::case_when(
    layer == "adresni mista" ~ "ADRM_B.shp",
    layer == "ADRM_B" ~ "ADRM_B.shp",
    layer == "casti obce" ~ "CO_B.shp",
    layer == "CO_B" ~ "CO_B.shp",
    layer == "katastralni uzemi" ~ "KU_P.shp",
    layer == "KU_P" ~ "KU_P.shp",
    layer == "obec" ~ "OBEC_P.shp",
    layer == "OBEC_P" ~ "OBEC_P.shp",
    layer == "stavebni objekty" ~ "SO_B.shp",
    layer == "SO_B" ~ "SO_B.shp",
    # UL_B is always empty
    #layer == "UL_B" ~ "UL_B.shp",
    layer == "ulice" ~ "UL_L.shp",
    layer == "UL_L" ~ "UL_L.shp",
    layer == "volebni okrsky" ~ "VO_P.shp",
    layer == "VO_P" ~ "VO_P.shp",
    layer == "zakladni sidelni jednotky" ~ "ZSJ_P.shp",
    layer == "ZSJ_P" ~ "ZSJ_P.shp",
    # not for every settlement
    layer == "MOMC_P" ~ "MOMC_P.shp",
    layer == "MOP_P" ~ "MOP_P.shp",
    layer == "SOP_P" ~ "SOP_P.shp",
    TRUE ~ NA_character_
  )

  if (is.na(shp_name)) {
    stop(glue::glue("Uknown layer name (or alias) - {layer}. Please look into documentation, ",
                    "for allowed layer names."))
  }


  # download and select the data ----------------------------------------------------------------

  dir <- tempdir()

  url <- glue::glue("http://services.cuzk.cz/shp/obec/epsg-5514/{id}.zip")
  ruian_file <- file.path(dir, glue::glue("{id}.zip"))

  if (!file.exists(ruian_file)) {

    download.file(url, ruian_file)
  }

  unzip(ruian_file, exdir = dir)

  shp_file <- file.path(dir, id, shp_name)

  if (!file.exists(shp_file)) {
    stop(glue::glue("There is no layer {layer} for settlement with id {id}. ",
                    "Not all settlements have necessarily all the layers."))
  }


  data <- sf::st_read(shp_file,
                      stringsAsFactors = FALSE,
                      options = "ENCODING=Windows-1250",
                      quiet = TRUE)

  if (WGS84) {
    data <- data %>%
      sf::st_transform(4326)
  }

  data <- data %>%
    janitor::clean_names()

  if (layer == "adresni mista") {

    url_adresni_mista <- glue::glue("http://vdp.cuzk.cz/vymenny_format/csv/20181130_OB_{id}_ADR.csv.gz")

    adresni_mista <- readr::read_delim(url_adresni_mista,
                                       ";", locale = readr::locale(encoding = "Windows-1250")) %>%
      janitor::clean_names() %>%
      dplyr::mutate(kod_adm = as.character(kod_adm)) %>%
      dplyr::select(-kod_casti_obce, -kod_ulice)

    data <- data %>%
      dplyr::left_join(adresni_mista, by = c("ADRM_KOD" = "kod_adm"))
  }

  data
}
