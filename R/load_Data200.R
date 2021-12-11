#' Load or save from Data200
#'
#' Load data from Data200 data source (\url{https://geoportal.cuzk.cz/(S(ijginumejzilvacbfijkylwj))/Default.aspx?mode=TextMeta&side=mapy_data200&text=dSady_mapyData200&head_tab=sekce-02-gp&menu=229}).
#' The data can be used only after correctly citing the creator (as per terms of use \url{https://geoportal.cuzk.cz/Dokumenty/Podminky_EN.pdf}).
#' The citation is in form "Mapový podklad – Data200, {{insert year}} © Český úřad zeměměřický a katastrální, www.cuzk.cz".
#'
#' @param layer identification of data to extract as character, see details.
#' @param WGS84 convert data to WGS-84 coordinate system? Default \code{FALSE}.
#'
#' @describeIn load_Data200 Loads single dataset
#'
#' @details
#' The \code{layer} can have values from following set, in the bracket is the name of general category
#' (can be used as type in saving the data):
#' \enumerate{
#'  \item \code{"AdministrativniHraniceLinie"} (\code{"Hranice"})
#'  \item \code{"AdministrativniUzemiCentroid"} (\code{"Hranice"})
#'  \item \code{"AdministrativniUzemiUTJ"} (\code{"Hranice"})
#'  \item \code{"AdministrativniUzemiObce"} (\code{"Hranice"})
#'  \item \code{"AdministrativniUzemiOkresy"} (\code{"Hranice"})
#'  \item \code{"AdministrativniUzemiKraje"} (\code{"Hranice"})
#'  \item \code{"HrazJezNad50m"} (\code{"Vodstvo"})
#'  \item \code{"HrazJezPod50m"} (\code{"Vodstvo"})
#'  \item \code{"JezeroRybnikVodniNadrz"} (\code{"Vodstvo"})
#'  \item \code{"VodniTokPod50m"} (\code{"Vodstvo"})
#'  \item \code{"VodniTokNad50m"} (\code{"Vodstvo"})
#'  \item \code{"Ostrovy"} (\code{"Vodstvo"})
#'  \item \code{"MokrinaBazina"} (\code{"Vodstvo"})
#'  \item \code{"Vodopad"} (\code{"Vodstvo"})
#'  \item \code{"Prameny1"} (\code{"Vodstvo"})
#'  \item \code{"Prameny2"} (\code{"Vodstvo"})
#'  \item \code{"OrografickeNazvy"} (\code{"Popis"})
#'  \item \code{"GeomorfologickeOblasti"} (\code{"Popis"})
#'  \item \code{"GeomorfologickeCelky"} (\code{"Popis"})
#'  \item \code{"GeomorfologickePodcelky"} (\code{"Popis"})
#'  \item \code{"NarodniParkPrirodniRezervace"} (\code{"RuzneObjekty"})
#'  \item \code{"Produktovod"} (\code{"RuzneObjekty"})
#'  \item \code{"Vysilac"} (\code{"RuzneObjekty"})
#'  \item \code{"VyznamneObjekty"} (\code{"RuzneObjekty"})
#'  \item \code{"ProduktovodVyznamneBody"} (\code{"RuzneObjekty"})
#'  \item \code{"Věž"} (\code{"RuzneObjekty"})
#'  \item \code{"DulLom"} (\code{"RuzneObjekty"})
#'  \item \code{"Budova"} (\code{"RuzneObjekty"})
#'  \item \code{"ElektrickeVedeni"} (\code{"RuzneObjekty"})
#'  \item \code{"Elektrarna"} (\code{"RuzneObjekty"})
#'  \item \code{"ObceBody"} (\code{"Sidla"})
#'  \item \code{"ObcePolygony"} (\code{"Sidla"})
#'  \item \code{"Privoz"} (\code{"Doprava"})
#'  \item \code{"PrivozStanice"} (\code{"Doprava"})
#'  \item \code{"ZeleznicniPrejezd"} (\code{"Doprava"})
#'  \item \code{"Heliport"} (\code{"Doprava"})
#'  \item \code{"LanovaDraha"} (\code{"Doprava"})
#'  \item \code{"DalnicniOdpocivka"} (\code{"Doprava"})
#'  \item \code{"KrizovatkaMimourovnova"} (\code{"Doprava"})
#'  \item \code{"LetisteNad40Ha"} (\code{"Doprava"})
#'  \item \code{"LetisteNad40HaBod"} (\code{"Doprava"})
#'  \item \code{"ZelezniceZastavky"} (\code{"Doprava"})
#'  \item \code{"LetistePod40Ha"} (\code{"Doprava"})
#'  \item \code{"LodniPristav"} (\code{"Doprava"})
#'  \item \code{"PristavaciDraha"} (\code{"Doprava"})
#'  \item \code{"Zeleznice"} (\code{"Doprava"})
#'  \item \code{"Silnice"} (\code{"Doprava"})
#'  \item \code{"LesyPlantaze"} (\code{"Vegetace"})
#'  \item \code{"KotovaneBody"} (\code{"Relief"})
#'  \item \code{"Vrstevnice"} (\code{"Relief"})
#'  \item \code{"SkalniStenaSraz"} (\code{"Relief"})
#'  \item \code{"Jeskyne"} (\code{"Relief"})
#'  \item \code{"DMR"} (\code{"Relief"})
#'  \item \code{"DMRShaded"} (\code{"Relief"})
#' }
#'
#' @return
#' \code{"load_Data200"} - \code{data.frame} with spatial objects (\code{\link[sf]{sf}}) of the specified layer.
#' For \code{layer} either \code{"DMR"} or \code{"DMRShaded"} the output is actually a (\code{\link[raster]{raster}}).
#' \code{"save_Data200"} - \code{path} to the unzipped files (for layer) or folder (for type),
#' the zipped file is also stored at path (mainly for further use)
#'
#' @importFrom glue glue
#' @importFrom utils data download.file unzip
#' @importFrom sf st_read st_transform st_crs
#' @importFrom stringr str_detect str_replace
#' @importFrom raster raster projectRaster
#' @importFrom usethis ui_info ui_done
#'
#' @export
#'
#' @examples
#' \dontrun{
#' waterfalls <- load_Data200(layer = "Vodopad")
#' }
load_Data200 <- function(layer, WGS84 = FALSE) {

  .check_internet()

  data200_layers <- data200layers

  if (!(layer %in% data200_layers$nazev)) {
    stop(glue::glue(
      "Unknown layer requested - {layer}. Please look at the documentation for allowed types."
    ))
  }

  index <- which(data200_layers$nazev == layer)

  temp_dir <- tempdir()

  file_zip <- file.path(temp_dir, glue::glue("{data200_layers$slozka[index]}.zip"))

  url <- data200_layers$url[index]

  if (!memoise::has_cache(m_GET)(url)) {
    usethis::ui_info(glue::glue(
      "Downloading roughly {data200_layers$size[index]}, this can take a while."
    ))
  } else {
    usethis::ui_info("Using cached data.")
  }

  m_GET(url) %>%
    write_zip_file(file_zip)

  utils::unzip(file_zip, exdir = temp_dir, junkpaths = TRUE)

  usethis::ui_done("Data downloaded and unpacked.")

  shp_file <- file.path(temp_dir, data200_layers$shpName[index])

  is_raster <- stringr::str_detect(shp_file, "\\.tif")

  if (is_raster) {
    data <- raster::raster(shp_file)

    if (WGS84) {
      data <- raster::projectRaster(shp_file, csr = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
    }
  } else {
    data <- sf::st_read(shp_file,
      stringsAsFactors = FALSE,
      quiet = TRUE
    )

    suppressWarnings(sf::st_crs(data) <- 5514)

    if (WGS84) {
      data <- data %>%
        sf::st_transform(4326)
    }
  }

  data
}

#' @describeIn load_Data200 Download and store layer (and zipped general category) or complete category
#'
#' @param path \code{character} path to store the files to.
#' @param type \code{character} type of layers to save. See details, types are listed in brackets.
#'
#' @importFrom purrr map_chr
#' @importFrom usethis ui_info ui_done ui_warn
#'
#' @export
#'
#' @examples
#' \dontrun{
#' folder_water_objects <- save_Data200("~/data/water", type = "Vodopad")
#' }
save_Data200 <- function(path, layer = NULL, type = NULL) {

  .check_internet()

  data200_layers <- data200layers

  if (is.null(layer) & is.null(type)) {
    stop(glue::glue(
      "Either layer or type of layers must be specified."
    ))
  }

  if (!is.null(layer)) {
    if (!(layer %in% data200_layers$nazev)) {
      stop(glue::glue(
        "Unknown layer requested - {layer}. Please look at the documentation for allowed types."
      ))
    }
  }

  if (!is.null(type)) {
    if (!(type %in% data200_layers$kategorie)) {
      stop(glue::glue(
        "Unknown layer set requested - {type}. Please look at the documentation for allowed types."
      ))
    }
  }

  if (!is.null(layer) & !is.null(type)) {
    usethis::ui_warn(glue::glue(
      "Both layer ({layer}) and type ({type}) specified. Type will be used to obtain the data."
    ))
  }

  if (!dir.exists(path)) {
    dir.create(path)
  }

  if (!is.null(type)) {
    index <- which(data200_layers$kategorie == type)[1]
    url <- data200_layers$url[index]

    file_zip <- file.path(path, glue::glue("{data200_layers$slozka[index]}.zip"))

    if (!file.exists(file_zip)) {
      usethis::ui_info(glue::glue(
        "Downloading roughly {data200_layers$size[index]}, this can take a while."
      ))

      m_GET(data200_layers$url[index]) %>%
        write_zip_file(file_zip)
    }

    utils::unzip(file_zip, exdir = path)

    usethis::ui_done("Data downloaded and unpacked.")

    return(file.path(path, data200_layers$slozka[index]))

  } else {
    index <- which(data200_layers$nazev == layer)
    url <- data200_layers$url[index]

    file_zip <- file.path(path, glue::glue("{data200_layers$slozka[index]}.zip"))

    if (!file.exists(file_zip)) {
      usethis::ui_info(glue::glue(
        "Downloading roughly {data200_layers$size[index]}, this can take a while."
      ))

      m_GET(data200_layers$url[index]) %>%
        write_zip_file(file_zip)
    }

    is_raster <- stringr::str_detect(data200_layers$shpName[index], "\\.tif")

    if (is_raster) {
      files_unzip <- glue::glue("{data200_layers$slozka[index]}/{data200_layers$shpName[index]}")

      files_return <- utils::unzip(file_zip, files = files_unzip, exdir = path, junkpaths = TRUE)
    } else {
      exts <- list(".cpg", ".dbf", ".prj", ".sbn", ".sbx", ".shp", ".shp.xml", ".shx")

      files_name <- stringr::str_replace(data200_layers$shpName[index], "\\.shp", "")

      files_unzip <- purrr::map_chr(exts, ~ glue::glue("{data200_layers$slozka[index]}/{files_name}{.x}"))

      files_return <- purrr::map_chr(files_unzip, ~ utils::unzip(file_zip,
        files = .x,
        exdir = path, junkpaths = TRUE
      ))
    }

    usethis::ui_done("Data downloaded and unpacked.")

    return(files_return)
  }
}

#' @describeIn load_Data200 Load information about layers in Data200.
#' @inheritParams load_Data50_info
#' @export
load_Data200_info <- function(english_names = FALSE) {
  d <- data200layers

  if (english_names) {
    names(d) <- c("layer", "shp_name", "url", "category", "folder", "size")
  } else {
    names(d) <- c("vrstva", "shp_nazev", "url", "kategorie", "slozka", "velikost")
  }

  d
}

#' @describeIn generate_Data50_citation Generate citation for Data200 datasource.
#' @export
generate_Data200_citation <- function() {
  year <- lubridate::year(lubridate::now())

  glue::glue("\u201eMapov\u00fd podklad \u2013 Data200, {year} \u00a9 \u010cesk\u00fd \u00fa\u0159ad zem\u011bm\u011b\u0159ick\u00fd a katastr\u00e1ln\u00ed, www.cuzk.cz.\u201c")
}
