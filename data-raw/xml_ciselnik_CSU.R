# https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---vdb.czso.cz-pll-eweb-package_show-id-cis101
library(XML)
library(tidyverse)

get_xml_data <- function(url, file_name) {
  temp_dir <- tempdir()

  xml_file <- file.path(temp_dir, file_name)

  download.file(url, destfile = xml_file)

  xmlParse(xml_file) %>%
    xmlToList()
}

# kraje ---------------------------------------------------------------------------------------

url <- "https://apl.czso.cz/iSMS/cisexp.jsp?kodcis=100&typdat=0&cisjaz=203&format=0"

xml_data <- get_xml_data(url, "ciselnik_kraje.xml")

ciselnik_kraje <- xml_data$DATA %>% {
  tibble(
    typ = "kraj",
    kod_csu = map_chr(., "CHODNOTA"),
    kod_ruian = map(., "ATRIBUTY") %>% map(2) %>% map_chr(1)
  )
}

# okresy --------------------------------------------------------------------------------------

url <- "https://apl.czso.cz/iSMS/cisexp.jsp?kodcis=101&typdat=0&cisjaz=203&format=0"

xml_data <- get_xml_data(url, "ciselnik_okresy.xml")

ciselnik_okresy <- xml_data$DATA %>% {
  tibble(
    typ = "okres",
    kod_csu = map_chr(., "CHODNOTA"),
    kod_ruian = map(., "ATRIBUTY") %>% map(4) %>% map_chr(1)
    # kod_ruian_cislo = as.numeric(kod_ruian)
  )
}

# orp -----------------------------------------------------------------------------------------

url <- "https://apl.czso.cz/iSMS/cisexp.jsp?kodcis=65&typdat=0&cisjaz=203&format=0"

xml_data <- get_xml_data(url, "ciselnik_orp.xml")

ciselnik_orp <- xml_data$DATA %>% {
  tibble(
    typ = "správní obvod ORP",
    kod_csu = map_chr(., "CHODNOTA"),
    kod_ruian = map(., "ATRIBUTY") %>% map(1) %>% map_chr(1)
  )
}



# slozeni seznamu -----------------------------------------------------------------------------

ciselnik_CSU <- ciselnik_kraje %>%
  bind_rows(ciselnik_okresy) %>%
  bind_rows(ciselnik_orp)

ciselnik_CSU <- ciselnik_CSU %>%
  mutate(kod_valid = as.numeric(kod_ruian)) %>%
  filter(!is.na(kod_valid)) %>%
  select(-kod_valid)

usethis::use_data(ciselnik_CSU, overwrite = TRUE)
