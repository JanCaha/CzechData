# script to prepare data included with the package
library(sf)
library(dplyr)
library(janitor)
library(here)

source(here::here("R", "download_RUIAN.R"))

# set uu directory with ruian -----------------------------------------------------------------

ruian_dir <- .download_RUIAN()

# obce ----------------------------------------------------------------------------------------

data <- st_read(file.path(ruian_dir, "OBCE_P.shp"), stringsAsFactors = FALSE,
                options = "ENCODING=Windows-1250", quiet = TRUE)

st_geometry(data) <- NULL

obce <- data %>%
  janitor::clean_names()

usethis::use_data(obce, overwrite = TRUE)


# katastralni uzemi ---------------------------------------------------------------------------


data <- st_read(file.path(ruian_dir, "KATUZE_P.shp"), stringsAsFactors = FALSE,
                options = "ENCODING=Windows-1250", quiet = TRUE)

st_geometry(data) <- NULL

katastralni_uzemi <- data %>%
  janitor::clean_names()

usethis::use_data(katastralni_uzemi, overwrite = TRUE)
