package_env <- new.env(parent = emptyenv())

# default cache_length
cache_length_default <- 7 * 24 * 60 * 60 # cache time set to 7 days

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

#' Set and get cache validity time
#'
#' Set and get how long the cache is valid and the files are downloaded only once and then returned from the cache.
#'
#' @param length \code{numeric} time in seconds how long the cache is valid.
#'
#' @describeIn cache_functions Set cache length
#'
#' @export
#'
set_cache_length <- function(length){
  assign("cache_length", length, envir=package_env)
}

#' @describeIn cache_functions Get cache length
#'
#' @return
#' \code{get_cache_length()} \code{numeric} length of cache validity (default value is 7 days)
#'
#' @export
get_cache_length <- function(){

  if (exists("cache_length", envir=package_env)){
    return(get("cache_length", envir=package_env))
  }

  cache_length_default
}
