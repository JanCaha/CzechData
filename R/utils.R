#' @importFrom curl has_internet
#' @importFrom usethis ui_stop
#'
.check_internet <- function(){
  if (!curl::has_internet()) {
    usethis::ui_stop("No internet connection. Can not download data. Try again when you are online.")
  }
}

cache_path <- function(){
  path <- file.path(tempdir(), "..", ".CzechDataPackageCache")

  path <- normalizePath(path)

  if (!dir.exists(path)){
    dir.create(path)
  }

  path
}

#' @importFrom memoise cache_filesystem
cache_CzechData <- memoise::cache_filesystem(cache_path())

cache_length <- 7 * 24 * 60 * 60 # cache time set to 7 days

#' @importFrom httr GET
#' @importFrom memoise memoise timeout
m_GET <- memoise::memoise(httr::GET,
                          ~ memoise::timeout(cache_length),
                          cache = cache_CzechData)

#' @importFrom httr content
write_zip_file <- function(response, file){
  bin <- httr::content(response, "raw")
  writeBin(bin, file)
}

