#' Defunct: Load populations from settlements
#'
#' @description
#'
#' \lifecycle{defunct}
#'
#' Load population by sex for settlements for each years from 2000 to 2018.
#'
#' Use package \code{czso} and specifically function \code{czso::czso_get_table(dataset_id = "130149")}
#' to obtain the data and \code{czso::czso_get_table_schema(dataset_id = "130149")} to get the columns
#' description.
#'
#' @param year year for which the data should be obtained. Default value is \code{NA}, which means
#' all the years. Values from range (including both limits) 2000 - 2018 are accepted.
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
#' @importFrom lifecycle deprecate_stop
#'
load_population_settlements <- function(year = NA) {

  lifecycle::deprecate_stop("0.4.0",
                            "load_population_settlements()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table(dataset_id = "130149")` to obtain the data.')

}

#' @describeIn load_population_settlements Load description for columns
#'
#' @importFrom lifecycle deprecate_stop
#'
#' @export
#'
load_population_settlements_col_explanations <- function() {

  lifecycle::deprecate_stop("0.4.0",
                            "load_population_settlements_col_explanations()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table_schema(dataset_id = "130149")` to obtain the data.')

}
