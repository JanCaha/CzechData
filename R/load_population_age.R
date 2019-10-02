#' Load population by age
#'
#' Load population by sex and five-year age categories for years 2010 to 2018.
#'
#' @param year for which the data should be obtained. Default value is \code{NA}, which means
#' all the years. Values from range (including both limits) 2010 - 2018 are accepted.
#' @param area_type type of are for which the data should be obtained. Default value is \code{NA},
#' which means all areas. Accepted values are in Description.
#'
#' @describeIn load_population_age Load the data
#'
#' @section Information about dataset:
#'  More detailed information about data can be found at the provider's website
#'  \url{https://www.czso.cz/csu/czso/obyvatelstvo-k-3112-podle-pohlavi-v-obcich}.
#'
#' @details
#' The \code{area_type} can have values from following set:
#' \enumerate{
#'   \item \code{"okresy"}
#'   \item \code{"kraje"}
#'   \item \code{"republika"}
#' }
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom glue glue glue_collapse
#' @importFrom dplyr case_when mutate filter select
#' @importFrom readr read_csv cols
#' @importFrom lubridate year
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#'     population_age <- load_population_age(area_type = "okresy")
#' }
load_population_age <- function(year = NA, area_type = NA) {
  area_types <- c("okresy", "kraje", "republika")

  if (!is.na(area_type)) {
    if (!area_type %in% area_types) {
      stop(glue::glue(
        "Unknow area_type - {area_type}. Allowed values are: ",
        glue::glue_collapse(area_types, sep = ", "), "."
      ))
    }
  }

  year_valid <- FALSE

  if (!is.na(year)) {
    if (is.numeric(year)) {
      if (2010 <= year & year <= 2018) {
        year_valid <- TRUE
      } else {
        stop(glue::glue(
          "Year has to be from range 2010 - 2018. ",
          "{year} does not fall in this range."
        ))
      }
    } else {
      stop(glue::glue("Variable year has to be numeric. It is {typeof(year)}."))
    }
  }

  area_id <- dplyr::case_when(
    area_type == "okresy" ~ 101,
    area_type == "kraje" ~ 100,
    area_type == "republika" ~ 97
  )

  data <- readr::read_csv("https://www.czso.cz/documents/62353418/92011126/130142-19data051719.csv",
    col_types = readr::cols()
  )

  data <- data %>%
    dplyr::mutate(rok = lubridate::year(.data$casref_do))

  if (!is.na(year_valid)) {
    data <- data %>%
      dplyr::filter(.data$rok == year)
  }

  if (!is.na(area_type)) {
    data <- data %>%
      dplyr::filter(.data$vuzemi_cis == area_id)
  }

  data %>%
    dplyr::select(-.data$rok)
}

#' @describeIn load_population_age Load description for columns
#'
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
load_population_age_col_explanations <- function() {
  json_file <- jsonlite::fromJSON("https://www.czso.cz/documents/62353418/92011126/130142-19schema051719.json")

  data <- json_file$tableSchema$columns[, c(2, 3)]

  names(data) <- c("sloupec", "popis")

  data
}
