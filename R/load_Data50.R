#' Load or save from Data50
#'
#' Load data from Data50 data source (\url{https://geoportal.cuzk.cz/(S(xbw0cmgh1cve4bciko2oo4e2))/Default.aspx?lng=EN&mode=TextMeta&side=mapy_data50&text=dSady_mapyData50&head_tab=sekce-02-gp&menu=2290}).
#' The data can be used only after correctly citing the creator (as per terms of use \url{https://geoportal.cuzk.cz/Dokumenty/Podminky_EN.pdf}).
#' The citation is in form "Mapový podklad – Data50, {{insert year}} © Český úřad zeměměřický a katastrální, www.cuzk.cz".
#'
#' @param layer identification of data to extract as character, see details.
#' @param WGS84 convert data to WGS-84 coordinate system? Default \code{FALSE}.
#'
#' @describeIn load_Data50 Loads single dataset
#'
#' @details
#' The \code{layer} can have values from following set, in the bracket is the name of general category
#' (can be used as type in saving the data):
#' \enumerate{
#'  \item \code{"BlokBudov"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Budova"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Hrad"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Hrbitov"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"ChatovaKolonie"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Kostel"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"LyzarskyMustek"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"RozhlednaVysilac"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Rozvalina"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Stadion"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"UsazovaciNadrzOdkaliste"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"VetrnyMotor"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"VezovitaStavba"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"VodojemVezovy"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Zamek"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Zricenina"} (\code{"sidelniKulturniHospodarskeObjekty"})
#'  \item \code{"Cesta"} (\code{"komunikace"})
#'  \item \code{"LanovaDraha"} (\code{"komunikace"})
#'  \item \code{"Lavka"} (\code{"komunikace"})
#'  \item \code{"Letiste"} (\code{"komunikace"})
#'  \item \code{"LetisteObvodovaLinie"} (\code{"komunikace"})
#'  \item \code{"Most"} (\code{"komunikace"})
#'  \item \code{"Pesina"} (\code{"komunikace"})
#'  \item \code{"Pristav"} (\code{"komunikace"})
#'  \item \code{"Privoz"} (\code{"komunikace"})
#'  \item \code{"SilniceDalnice"} (\code{"komunikace"})
#'  \item \code{"SilniceVeVystavbe"} (\code{"komunikace"})
#'  \item \code{"Tunel"} (\code{"komunikace"})
#'  \item \code{"Ulice"} (\code{"komunikace"})
#'  \item \code{"ZeleznicniStanice"} (\code{"komunikace"})
#'  \item \code{"ZeleznicniTrat"} (\code{"komunikace"})
#'  \item \code{"ZeleznicniVlecka"} (\code{"komunikace"})
#'  \item \code{"ElektrickeVedeni"} (\code{"produktovodyElektrickeVedeni"})
#'  \item \code{"Produktovod"} (\code{"produktovodyElektrickeVedeni"})
#'  \item \code{"Akvadukt"} (\code{"vodstvo"})
#'  \item \code{"Hraz"} (\code{"vodstvo"})
#'  \item \code{"Jez"} (\code{"vodstvo"})
#'  \item \code{"Shybka"} (\code{"vodstvo"})
#'  \item \code{"VodniPlocha"} (\code{"vodstvo"})
#'  \item \code{"VodniTok"} (\code{"vodstvo"})
#'  \item \code{"HraniceSpravniJednotkyaKU"} (\code{"hraniceUzemnichJednotek"})
#'  \item \code{"ChraneneUzemi"} (\code{"hraniceUzemnichJednotek"})
#'  \item \code{"Les"} (\code{"vegetacePovrch"})
#'  \item \code{"LoukaPastvina"} (\code{"vegetacePovrch"})
#'  \item \code{"RaselinisteMocalBazina"} (\code{"vegetacePovrch"})
#'  \item \code{"ZahradaSadParkViniceChmelnice"} (\code{"vegetacePovrch"})
#'  \item \code{"Jeskyne"} (\code{"terenniRelief"})
#'  \item \code{"KotovanyBod"} (\code{"terenniRelief"})
#'  \item \code{"SkalnatySraz"} (\code{"terenniRelief"})
#'  \item \code{"Skaly"} (\code{"terenniRelief"})
#'  \item \code{"TerenniStupen"} (\code{"terenniRelief"})
#'  \item \code{"TerenniStupenSpadnice"} (\code{"terenniRelief"})
#'  \item \code{"Vrstevnice"} (\code{"terenniRelief"})
#'  \item \code{"DefinicniBodCastiObce"} (\code{"popis"})
#'  \item \code{"DefinicniBodSpravnihoCelku"} (\code{"popis"})
#'  \item \code{"Jmeno_B"} (\code{"popis"})
#'  \item \code{"Jmeno_L"} (\code{"popis"})
#'  \item \code{"Jmeno_P"} (\code{"popis"})
#'  \item \code{"ObjektRuzny"} (\code{"popis"})
#' }
#'
#' @return
#' \code{"load_Data50"} - \code{data.frame} with spatial objects (\code{\link[sf]{sf}}) of the specified layer.
#' \code{"save_Data50"} - \code{path} to the unzipped files (for layer) or folder (for type),
#' the zipped file is also stored at path (mainly for further use)
#'
#' @importFrom glue glue
#' @importFrom utils data download.file unzip
#' @importFrom sf st_read st_transform st_crs
#' @importFrom usethis ui_info ui_done
#'
#' @export
#'
#' @examples
#' \dontrun{
#'     rivers <- load_Data50(layer = "VodniTok")
#'}
load_Data50 <- function(layer, WGS84 = FALSE){

  .check_internet()

  data50_layers <- data50layers # load_Data50_info()

  if (!(layer %in% data50_layers$nazev)) {
    stop(glue::glue(
      "Unknown layer requested - {layer}. Please look at the documentation for allowed types."
    ))
  }

  index <- which(data50_layers$nazev == layer)

  temp_dir <- tempdir()

  file_zip <- file.path(temp_dir, glue::glue("{data50_layers$kategorie[index]}.zip"))

  if (!file.exists(file_zip)) {

    usethis::ui_info(glue::glue(
      "Downloading roughly {data50_layers$size[index]}, this can take a while."
      ))

    m_GET(data50_layers$url[index]) %>%
      write_zip_file(file_zip)
  }

  utils::unzip(file_zip, exdir = temp_dir)

  usethis::ui_done("Data downloaded and unpacked.")

  shp_file <- file.path(temp_dir, data50_layers$kategorie[index], data50_layers$shpName[index])

  data <- sf::st_read(shp_file,
                      stringsAsFactors = FALSE,
                      quiet = TRUE)

  suppressWarnings(sf::st_crs(data) <- 5514)

  if (WGS84) {
    data <- data %>%
      sf::st_transform(4326)
  }

  data
}


#' @describeIn load_Data50 Download and store layer (and zipped general category) or complete category
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
#'     folder_communications <- save_Data50("~/data/coomunications", type = "komunikace")
#' }
save_Data50 <- function(path, layer = NULL, type = NULL){

  .check_internet()

  data50_layers <- data50layers # load_Data50_info()

  if (is.null(layer) & is.null(type)) {
    stop(glue::glue(
      "Either layer or type of layers must be specified."
    ))
  }

  if (!is.null(layer)) {
    if (!(layer %in% data50_layers$nazev)) {
      stop(glue::glue(
        "Unknown layer requested - {layer}. Please look at the documentation for allowed types."
      ))
    }
  }

  if (!is.null(type)) {
    if (!(type %in% data50_layers$kategorie)) {
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
    index <- which(data50_layers$kategorie == type)[1]
    url <- data50_layers$url[index]

    file_zip <- file.path(path, glue::glue("{data50_layers$kategorie[index]}.zip"))

    if (!file.exists(file_zip)) {

      usethis::ui_info(glue::glue(
        "Downloading roughly {data50_layers$size[index]}, this can take a while."
        ))

      m_GET(data50_layers$url[index]) %>%
        write_zip_file(file_zip)
    }

    utils::unzip(file_zip, exdir = path)

    usethis::ui_done("Data downloaded and unpacked.")

    return(file.path(path, data50_layers$kategorie[index]))

  } else {
    index <- which(data50_layers$nazev == layer)
    url <- data50_layers$url[index]

    file_zip <- file.path(path, glue::glue("{data50_layers$kategorie[index]}.zip"))

    if (!file.exists(file_zip)) {

      usethis::ui_info(glue::glue(
        "Downloading roughly {data50_layers$size[index]}, this can take a while."
        ))

      m_GET(data50_layers$url[index]) %>%
        write_zip_file(file_zip)
    }

    exts <- list(".cpg", ".dbf", ".prj", ".sbn", ".sbx", ".shp", ".shp.xml", ".shx")

    files_unzip <- purrr::map_chr(exts, ~ glue::glue("{data50_layers$kategorie[index]}/{layer}{.x}"))

    files_return <- purrr::map_chr(files_unzip, ~utils::unzip(file_zip, files = .x,
                                                              exdir = path, junkpaths = TRUE))

    usethis::ui_done("Data downloaded and unpacked.")

    return(files_return)
  }
}

#' Loads general info about Data50 or Data200 dataset
#'
#' Some basic description of the dataset Data50 or Data200. Most importantly names of layers and sizes
#' of files that need to be downloaded.
#'
#' @param english_names change the names of the columns to English. Default \code{FALSE}.
#'
#' @return
#' \code{data.frame} with description of layers.
#'
#' @describeIn load_Data50 Load information about layers in Data50.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'     info <- load_Data50_info(english_names = TRUE)
#'     info <- load_Data200_info(english_names = TRUE)
#'}
load_Data50_info <- function(english_names = FALSE){
  d <- data50layers

  if (english_names) {
    names(d) <- c("layer", "shp_name", "url", "category", "size")
  }else {
    names(d) <- c("vrstva", "shp_nazev", "url", "kategorie", "velikost")
  }

  d
}

#' Generate attribution for dataset Data50 od Data200
#'
#' Create citation string as per terms of use (\url{https://geoportal.cuzk.cz/Dokumenty/Podminky_EN.pdf}).
#' @importFrom glue glue
#'
#' @return \code{character} with citation.
#'
#' @describeIn generate_Data50_citation Generate citation for Data50 datasource.
#'
#' @export
#'
#' @examples
#' generate_Data50_citation()
#' generate_Data200_citation()
#'
generate_Data50_citation <- function(){

  year <- lubridate::year(lubridate::now())

  glue::glue('\u201eMapov\u00fd podklad \u2013 Data50, {year} \u00a9 \u010cesk\u00fd \u00fa\u0159ad zem\u011bm\u011b\u0159ick\u00fd a katastr\u00e1ln\u00ed, www.cuzk.cz.\u201c')
}