#' @importFrom utils download.file unzip
#' @importFrom usethis ui_info ui_done
#'
# simple function that downloads large zipped RUIAN file, extracts it and returns the path to the
#
# unzipped folder

.download_RUIAN <- function() {

  temp_dir <- tempdir()

  ruian_file <- file.path(temp_dir, "RUIAN.zip")

  if (!file.exists(ruian_file)) {
    usethis::ui_info("Downloading roughly 243 MB, this can take a while.")

    m_GET("http://services.cuzk.cz/shp/stat/epsg-5514/1.zip") %>%
      write_zip_file(ruian_file)
  }

  utils::unzip(ruian_file, exdir = temp_dir)

  usethis::ui_done("Data downloaded and unpacked.")

  file.path(temp_dir, "1")
}
