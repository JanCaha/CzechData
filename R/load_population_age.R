#' Defunct: Load population by age
#'
#' @description
#'
#' \lifecycle{defunct}
#'
#' Load population by sex and five-year age categories for years 2010 to 2018.
#'
#' Use package \code{czso} and specifically function \code{czso::czso_get_table(dataset_id = "130142")}
#' to obtain the data and \code{czso::czso_get_table_schema(dataset_id = "130142")} to get the columns
#' description.
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
#' @importFrom lifecycle deprecate_stop
#'
load_population_age <- function(year = NA, area_type = NA) {

  lifecycle::deprecate_stop("0.4.0",
                            "load_population_age()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table(dataset_id = "130142")` to obtain the data.')

}

#' @describeIn load_population_age Load description for columns
#'
#' @importFrom lifecycle deprecate_stop
#'
#' @export

load_population_age_col_explanations <- function() {

  lifecycle::deprecate_stop("0.4.0",
                            "load_population_age_col_explanations()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table_schema(dataset_id = "130142")` to obtain the data.')


}
