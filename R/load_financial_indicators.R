#' Defunct: Load financial indicators for specific spatial units
#'
#' @description
#'
#' \lifecycle{defunct}
#'
#' Load financial indicators for specific spatial units (NUTS2 and NUTS3) for years 1995 to 2018.
#'
#' Use package \code{czso} and specifically function \code{czso::czso_get_table(dataset_id = "050101")}
#' to obtain the data and \code{czso::czso_get_table_schema(dataset_id = "050101")} to get the columns
#' description.
#'
#' @return data.frame containg the requested data
#' @export
#'
#' @importFrom lifecycle deprecate_stop
#'
load_financial_indicators <- function(){

  lifecycle::deprecate_stop("0.4.0",
                            "load_financial_indicators()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table(dataset_id = "050101")` to obtain the data.')

}

#' @describeIn load_financial_indicators Load description for columns
#'
#' @importFrom lifecycle deprecate_stop
#'
#' @export
#'
load_financial_indicators_col_explanations <- function() {

  lifecycle::deprecate_stop("0.4.0",
                            "load_financial_indicators_col_explanations()",
                            details = 'Use package `czso` and specifically function `czso::czso_get_table_schema(dataset_id = "050101")` to obtain the data.')


}
