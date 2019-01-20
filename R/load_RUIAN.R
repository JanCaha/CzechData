#' Extract data from RUIAN
#'
#' Extract specific layer from RUIAN for given settlement in Czech Republic. Checks are performed to
#' find out if the provided \code{id} is valid for some settlement in Czech Republic.
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
#'   \item ADRM_B (adresni mista)
#'   \item CO_B (casti obce)
#'   \item KU_P (katastralni uzemi)
#'   \item OBEC_P (obec)
#'   \item SO_B (stavebni objekty)
#'   \item UL_L (ulice)
#'   \item VO_P (volebni okrsky)
#'   \item ZSJ_P (zakladni sidelni jednotky)
#' }
#' So the codes \code{layer = "CO_B"} and \code{layer = "casti obce"} are equal.
#'
#' The values of \code{id} follow general pattern of six number with first number being 5.
#'
#' @return \code{data.frame} with spatail objects (\code{\link[sf]{sf}}) of the specified layer
#'
#' @export
#'
#' @importFrom glue glue
#' @importFrom stringr str_detect
#' @importFrom utils data download.file unzip
#' @importFrom dplyr case_when
#' @importFrom sf st_read st_transform
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
    # UL_B is allways empty
    #layer == "UL_B" ~ "UL_B.shp",
    layer == "ulice" ~ "UL_L.shp",
    layer == "UL_L" ~ "UL_L.shp",
    layer == "volebni okrsky" ~ "VO_P.shp",
    layer == "VO_P" ~ "VO_P.shp",
    layer == "zakladni sidelni jednotky" ~ "ZSJ_P.shp",
    layer == "ZSJ_P" ~ "ZSJ_P.shp",
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


  data <- sf::st_read(file.path(dir, id, shp_name),
                      stringsAsFactors = FALSE,
                      options = "ENCODING=Windows-1250",
                      quiet = TRUE)

  if (WGS84) {
    data <- data %>%
      sf::st_transform(4326)
  }

  data
}
