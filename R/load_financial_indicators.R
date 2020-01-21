a <- read_csv("https://www.czso.cz/documents/62353418/92011130/050101-19data011420.csv/8c4b94b2-911e-4f41-8f7f-7cbdfc16f288?version=1.1")

#' Load financial indicators for specific spatial units
#'
#' Load financial indicators for specific spatial units (NUTS2 and NUTS3) for years 1995 to 2018.
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom readr read_csv cols
#' @importFrom janitor clean_names
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#'     average_salary <- load_average_salary()
#' }
load_financial_indicators <- function(){
  data <- readr::read_csv("https://www.czso.cz/documents/62353418/92011130/050101-19data011420.csv/8c4b94b2-911e-4f41-8f7f-7cbdfc16f288?version=1.1",
                          col_types = readr::cols()) %>%
    janitor::clean_names()

  data
}

#' @describeIn load_financial_indicators Load description for columns
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
load_financial_indicators_col_explanations <- function() {
  json_file <- jsonlite::fromJSON("https://www.czso.cz/documents/62353418/92011130/050101-19schema011420.json/d1d86ec7-2e8d-4319-ac74-f291c5283bbe?version=1.1")

  data <- json_file$tableSchema$columns[, c(2, 3)]

  names(data) <- c("sloupec", "popis")

  data
}