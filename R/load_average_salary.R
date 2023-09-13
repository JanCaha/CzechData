#' Defunct: Load average salary for specific spatial units
#'
#' @description
#'
#' \lifecycle{defunct}
#'
#' Load average salary for specific spatial units for years 2011 to 2017.
#'
#' Use package \code{czso} and specifically function \code{czso::czso_get_table(dataset_id = "110080")}
#' to obtain the data and \code{czso::czso_get_table_schema(dataset_id = "110080")} to get the columns
#' description.
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom lifecycle deprecate_stop
#'
load_average_salary <- function(){

  lifecycle::deprecate_stop("0.4.0",
                            "load_average_salary()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table(dataset_id = "110080")` to obtain the data.')

}

#' @describeIn load_average_salary Load description for columns
#'
#' @importFrom lifecycle deprecate_stop
#'
#' @export
#'
load_average_salary_col_explanations <- function() {

  lifecycle::deprecate_stop("0.4.0",
                            "load_average_salary_col_explanations()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table_schema(dataset_id = "110080")` to obtain the data.')


}