#' Load average salary for specific spatial units
#'
#' Load average salary for specific spatial units for years 2011 to 2017.
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
load_average_salary <- function(){
  data <- readr::read_csv("https://www.czso.cz/documents/62353418/109720808/110080-19data053119.csv/4a23da3d-1eae-4c88-979a-6d5d083dbb82?version=1.1",
                          col_types = readr::cols()) %>%
    janitor::clean_names()

  data
}

#' @describeIn load_average_salary Load description for columns
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
load_average_salary_col_explanations <- function() {
  json_file <- jsonlite::fromJSON("https://www.czso.cz/documents/62353418/109720808/110080-19schema053119.json/799879d7-b578-4712-8f33-0bd033efed9a?version=1.1")

  data <- json_file$tableSchema$columns[, c(2, 3)]

  names(data) <- c("sloupec", "popis")

  data
}