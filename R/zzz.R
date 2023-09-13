.onAttach <- function(libname, pkgname) {

  packageStartupMessage("CzechData package - clearing cache.")

  files <- fs::dir_ls(cache_path())

  files <- fs::file_info(files)

  files <- files %>%
    dplyr::mutate(delete = as.numeric(Sys.time() - modification_time) > get_cache_length()) %>%
    dplyr::filter(delete) %>%
    dplyr::pull(path)

  purrr::walk(files, fs::file_delete)
}