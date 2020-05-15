#' @importFrom curl has_internet
#' @importFrom usethis ui_stop
#'
.check_internet <- function(){
  if (!curl::has_internet()) {
    usethis::ui_stop("No internet connection. Can not download data. Try again when you are online.")
  }
}