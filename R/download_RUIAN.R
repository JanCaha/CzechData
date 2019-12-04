#' @importFrom utils download.file unzip
#'
# simple function that downloads large zipped RUIAN file, extracts it and returns the path to the
#
# unzipped folder

.download_RUIAN <- function() {

  temp_dir <- tempdir()

  ruian_file <- file.path(temp_dir, "RUIAN.zip")

  if (!file.exists(ruian_file)) {
    message("Downloading roughly 190 MB, this can take a while.")
    utils::download.file("http://services.cuzk.cz/shp/stat/epsg-5514/1.zip",
                         ruian_file,
                         quiet = TRUE)
  }

  utils::unzip(ruian_file, exdir = temp_dir)

  file.path(temp_dir, "1")
}