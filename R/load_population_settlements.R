#' Load populations from settlements
#'
#' Load population by sex for settlements for each years from 2000 to 2017.
#'
#' @param year year for which the data should be obtained. Default value is \code{NA}, which means
#' all the years. Values from range (including both limits) 2000 - 2017 are accepted.
#'
#' @describeIn load_population_settlements Load the data
#'
#' @section Information about dataset:
#'  More detailed information about data can be found at the provider's website
#'  \url{https://www.czso.cz/csu/czso/obyvatelstvo-podle-petiletych-vekovych-skupin-a-pohlavi-v-krajich-a-okresech}.
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom utils download.file unzip
#' @importFrom readr read_csv cols
#' @importFrom glue glue
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#'     # population for all years
#'     population <- load_population_settlements()
#'
#'     # population for year 2015
#'     population_2015 <- load_population_settlements(year = 2015)
#' }
load_population_settlements <- function(year = NA) {
  year_valid <- FALSE

  if (!is.na(year)) {
    if (is.numeric(year)) {
      if (2000 <= year & year <= 2017) {
        year_valid <- TRUE
      } else {
        stop(glue::glue(
          "Year has to be from range 2000 - 2017. ",
          "{year} does not fall in this range."
        ))
      }
    } else {
      stop(glue::glue("Variable year has to be numeric. It is {typeof(year)}."))
    }
  }

  temp_dir <- tempdir()

  obyvatelstvo_file <- file.path(temp_dir, "obyvatelstvo_obce.zip")

  if (!file.exists(obyvatelstvo_file)) {
    utils::download.file(
      "https://www.czso.cz/documents/62353418/74123173/130149-18data051818.zip",
      obyvatelstvo_file,
      quiet = TRUE
    )
  }

  obyvatelstvo_file <- utils::unzip(obyvatelstvo_file, exdir = temp_dir)

  obyvatelstvo <- readr::read_csv(obyvatelstvo_file, col_types = readr::cols())

  if (year_valid) {
    obyvatelstvo <- obyvatelstvo %>%
      filter(.data$rok == year)
  }

  obyvatelstvo
}

#' @describeIn load_population_settlements Load description for columns
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
load_population_settlements_col_explanations <- function() {
  json_file <- jsonlite::fromJSON("https://www.czso.cz/documents/62353418/74123173/130149-18schema051818.json")

  data <- json_file$tableSchema$columns[, c(2, 3)]

  names(data) <- c("sloupec", "popis")

  data
}
