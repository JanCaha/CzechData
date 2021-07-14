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
#'   \item \code{"KATUZE_P"} (\code{"katastralni uzemi"})
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
#' @return \code{data.frame} with spatial objects (\code{\link[sf]{sf}}) of the specified layer
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
#' @importFrom dplyr pull filter
#' @importFrom sf st_read st_transform
#' @importFrom janitor clean_names
#' @importFrom curl curl_fetch_memory
#' @importFrom readr read_delim cols
#' @importFrom rlang .data set_names call2 eval_bare
#' @importFrom usethis ui_info
#' @importFrom purrr map list_modify
#'
#' @examples
#' \dontrun{
#'     adresy_vyskov <- load_RUIAN_settlement("592889", layer = "adresni mista")
#' }
load_RUIAN_settlement <- function(id, layer = "obec", WGS84 = FALSE) {

  .check_internet()

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

  shp_name <- .settlement_RUIAN_layers() %>%
    dplyr::filter(.data$alias == layer) %>%
    dplyr::pull(.data$shpName)

  if (length(shp_name) == 0) {
    stop(glue::glue(
      "Uknown layer name (or alias) - {layer}. Please look into documentation, ",
      "for allowed layer names."
    ))
  }

  # download and select the data ----------------------------------------------------------------

  dir <- tempdir()

  url <- glue::glue("http://services.cuzk.cz/shp/obec/epsg-5514/{id}.zip")
  ruian_file <- file.path(dir, glue::glue("{id}.zip"))

  if (!file.exists(ruian_file)) {
    m_GET(url) %>%
      write_zip_file(ruian_file)
  }

  utils::unzip(ruian_file, exdir = dir)

  usethis::ui_done("Data downloaded and unpacked.")

  shp_file <- file.path(dir, id, shp_name)

  if (!file.exists(shp_file)) {
    stop(glue::glue(
      "There is no layer {layer} for settlement with id {id}. ",
      "Not all settlements have necessarily all the layers."
    ))
  }

  data <- sf::st_read(shp_file,
    stringsAsFactors = FALSE,
    options = "ENCODING=Windows-1250",
    quiet = TRUE
  )

  if (WGS84) {
    data <- data %>%
      sf::st_transform(4326)
  }

  data <- data %>%
    janitor::clean_names()

  if (layer == "adresni mista") {

    date <- {lubridate::floor_date(lubridate::today(), unit = "month") - lubridate::days(1)} %>%
      as.character() %>%
      stringr::str_replace_all("-", "")

    url_adresni_mista <- glue::glue(
      "http://vdp.cuzk.cz/vymenny_format/csv/{date}_OB_{id}_ADR.csv.zip"
      )

    adresni_mista_file <- file.path(dir, glue::glue("{date}_OB_{id}_ADR.csv.zip"))

    utils::download.file(url_adresni_mista, adresni_mista_file, quiet = TRUE)

    utils::unzip(adresni_mista_file, exdir = dir)

    names_cols <- c("Název obce", "Název MOMC", "Název MOP", "Název části obce", "Název ulice",
                    "Kód ulice")

    cols_types <- purrr::map(rlang::set_names(names_cols),
                             function(x) rlang::call2("col_character", .ns = "readr"))

    cols_types <- purrr::list_modify(cols_types, .default = rlang::call2("col_guess", .ns = "readr"))

    function_call <- rlang::call2("cols", !!!cols_types, .ns = "readr")

    cols_function <- rlang::eval_bare(function_call)

    adresni_mista <- readr::read_delim(adresni_mista_file %>%
                                         stringr::str_replace(".zip", ""),
                                       ";",
                                       locale = readr::locale(encoding = "Windows-1250",
                                                              decimal_mark = "."),
                                       col_types = cols_function)

    colnames(adresni_mista) <- c("kod_adm", "kod_obce", "nazev_obce", "kod_momc", "název_momc", "kod_obvodu_prahy", "nazev_obvodu_prahy",
                                 "kod_casti_obce", "nazev_casti_obce", "kod_ulice", "nazev_ulice", "typ_so", "cislo_domovni",
                                 "cislo_orientacni", "znak_cisla_orientacniho", "psc", "souradnice_y", "souradnice_x", "plati_od")
    adresni_mista <- adresni_mista %>%
      dplyr::select(-.data$souradnice_y, -.data$souradnice_x) %>%
      dplyr::mutate(kod_adm = as.character(.data$kod_adm)) %>%
      dplyr::select(-.data$kod_casti_obce, -.data$kod_ulice)

    if (("psc" %in% names(data))) {
      adresni_mista <- adresni_mista %>%
        dplyr::select(-.data$psc)
    }else{
      adresni_mista <- adresni_mista %>%
        dplyr::mutate(psc = as.character(.data$psc))
    }

    data <- data %>%
      dplyr::left_join(adresni_mista, by = c("kod" = "kod_adm"))

  }

  data
}

#' @importFrom tibble tribble
.settlement_RUIAN_layers <- function(){
  dplyr::tribble(
    ~alias, ~shpName,
    "adresni mista", "ADRM_B.shp",
    "ADRM_B", "ADRM_B.shp",
    "casti obce", "CO_B.shp",
    "CO_B", "CO_B.shp",
    "katastralni uzemi", "KATUZE_P.shp",
    "KATUZE_P", "KATUZE_P.shp",
    "obec", "OBEC_P.shp",
    "OBEC_P", "OBEC_P.shp",
    "stavebni objekty", "SO_B.shp",
    "SO_B", "SO_B.shp",
    "UL_B", "UL_B.shp",
    "ulice", "UL_L.shp",
    "UL_L", "UL_L.shp",
    "volebni okrsky", "VO_P.shp",
    "VO_P", "VO_P.shp",
    "zakladni sidelni jednotky", "ZSJ_P.shp",
    "ZSJ_P", "ZSJ_P.shp",
    "MOMC_P", "MOMC_P.shp",
    "MOP_P", "MOP_P.shp",
    "SOP_P", "SOP_P.shp"
    )
}

