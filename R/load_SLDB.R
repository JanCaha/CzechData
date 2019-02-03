#' Get information from Czech census in 2011
#'
#' Data from Czech census in year 2011 by four main topics. The data are provided at various
#' aggregation levels that can be filtered.
#'
#' @param type type of requested information as character. Default value is "obyvatelstvo".
#' See details for more.
#' @param load_names boolean value if the column names should be loaded from external source.
#' Default TRUE as the column names do no make any sense otherwise.
#'
#' @details
#' Types of data that can be downloaded, and used as \code{type} parameter in the function call:
#' \enumerate{
#'   \item \code{"obyvatelstvo"}
#'   \item \code{"domy-byty"}
#'   \item \code{"domacnosti"}
#'   \item \code{"vyjizdka"}
#'   }
#'
#' @describeIn load_SLDB_2011 Load the data
#'
#' @section Information about dataset:
#'  More detailed information about data can be found at the provider's website
#'  \url{https://www.czso.cz/csu/sldb}.
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom glue glue
#' @importFrom readr read_csv locale
#' @importFrom janitor clean_names
#'
#' @examples
#' sldb <- load_SLDB_2011(type = "obyvatelstvo")
load_SLDB_2011 <- function(type = "obyvatelstvo", load_names = TRUE) {
  type_info <- .sldb_type_info()

  if (!(type %in% type_info$type)) {
    stop(glue::glue(
      "Unknown type of data requested - {type}. Please look at the documentation for allowed types."
    ))
  }

  index <- which(type_info$type == type)

  temp_dir <- tempdir()

  sldb_file_zip <- file.path(temp_dir, glue::glue("{type}.zip"))

  if (!file.exists(sldb_file_zip)) {
    download.file(type_info$url[index], sldb_file_zip)
  }

  sldb_file <- unzip(sldb_file_zip, exdir = temp_dir)

  data <- readr::read_csv(sldb_file, locale = readr::locale(encoding = "Windows-1250")) %>%
    mutate(uzkod = as.character(uzkod))

  if (load_names) {
    col_names <- load_SLDB_2011_col_explanations(type)[[2]]

    colnames(data) <- col_names
  }

  data <- data %>%
    janitor::clean_names()
}


#' @describeIn load_SLDB_2011 Get names of columns for SLDB of specific type as data.frame
#'
#' @importFrom curl curl_download
#' @importFrom readxl read_xls
#' @importFrom janitor clean_names
#' @importFrom dplyr mutate
#' @importFrom stringr str_to_lower
#'
#' @export
load_SLDB_2011_col_explanations <- function(type = "obyvatelstvo") {
  type_info <- .sldb_type_info()

  index <- which(type_info$type == type)

  header_file <- file.path(tempdir(), "sldb2011_vou.xls")

  if (!file.exists(header_file)) {
    curl::curl_download("https://www.czso.cz/documents/10180/25233177/sldb2011_vou.xls",
      destfile = header_file
    )
  }

  readxl::read_xls(header_file,
    sheet = type_info$sheet[index],
    range = type_info$range[index]
  ) %>%
    janitor::clean_names() %>%
    dplyr::mutate(polozka = stringr::str_to_lower(polozka))
}


#' @importFrom dplyr tibble
.sldb_type_info <- function() {
  dplyr::tibble(
    type = c("obyvatelstvo", "domy-byty", "domacnosti", "vyjizdka"),
    url = c(
      "https://www.czso.cz/documents/10180/25233177/sldb_obyvatelstvo.zip",
      "https://www.czso.cz/documents/10180/25233177/sldb_domybyty.zip",
      "https://www.czso.cz/documents/10180/25233177/sldb_domacnosti.zip",
      "https://www.czso.cz/documents/10180/25233177/sldb_vyjizdka.zip"
    ),
    sheet = c("Obyvatelstvo", "DomyByty", "Domacnosti", "Vyjizdka"),
    range = c("A6:B181", "A6:B98", "A6:B19", "A6:B20")
  )
}
