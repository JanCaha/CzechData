library(tidyverse)

layers_sidla = dplyr::tibble(
  nazev = c("BlokBudov", "Budova", "Hrad", "Hrbitov", "ChatovaKolonie", "Kostel", "LyzarskyMustek", "RozhlednaVysilac", "Rozvalina", "Stadion", "UsazovaciNadrzOdkaliste", "VetrnyMotor", "VezovitaStavba", "VodojemVezovy", "Zamek", "Zricenina"),
  shpName = c("BlokBudov.shp", "Budova.shp", "Hrad.shp", "Hrbitov.shp", "ChatovaKolonie.shp", "Kostel.shp", "LyzarskyMustek.shp", "RozhlednaVysilac.shp", "Rozvalina.shp", "Stadion.shp", "UsazovaciNadrzOdkaliste.shp", "VetrnyMotor.shp", "VezovitaStavba.shp", "VodojemVezovy.shp", "Zamek.shp", "Zricenina.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/sidelniKulturniHospodarskeObjekty.zip",
  kategorie = "sidelniKulturniHospodarskeObjekty",
  size = "24 MB"
)

layers_komunikace = dplyr::tibble(
  nazev = c("Cesta", "LanovaDraha", "Lavka", "Letiste", "LetisteObvodovaLinie", "Most", "Pesina", "Pristav", "Privoz", "SilniceDalnice", "SilniceVeVystavbe", "Tunel", "Ulice", "ZeleznicniStanice", "ZeleznicniTrat", "ZeleznicniVlecka"),
  shpName = c("Cesta.shp", "LanovaDraha.shp", "Lavka.shp", "Letiste.shp", "LetisteObvodovaLinie.shp", "Most.shp", "Pesina.shp", "Pristav.shp", "Privoz.shp", "SilniceDalnice.shp", "SilniceVeVystavbe.shp", "Tunel.shp", "Ulice.shp", "ZeleznicniStanice.shp", "ZeleznicniTrat.shp", "ZeleznicniVlecka.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/komunikace.zip",
  kategorie = "komunikace",
  size = "44 MB"
)

layers_produktovody = dplyr::tibble(
  nazev = c("ElektrickeVedeni", "Produktovod"),
  shpName = c("ElektrickeVedeni.shp", "Produktovod.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/produktovodyElektrickeVedeni.zip",
  kategorie = "produktovodyElektrickeVedeni",
  size = "449 kB"
)

layers_vodstvo = dplyr::tibble(
  nazev = c("Akvadukt", "Hraz", "Jez", "Shybka", "VodniPlocha", "VodniTok"),
  shpName = c("Akvadukt.shp", "Hraz.shp", "Jez.shp", "Shybka.shp", "VodniPlocha.shp", "VodniTok.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/vodstvo.zip",
  kategorie = "vodstvo",
  size = "37 MB"
)

layers_hranice = dplyr::tibble(
  nazev = c("HraniceSpravniJednotkyaKU", "ChraneneUzemi"),
  shpName = c("HraniceSpravniJednotkyaKU.shp", "ChraneneUzemi.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/hraniceUzemnichJednotek.zip",
  kategorie = "hraniceUzemnichJednotek",
  size = "16 MB"
)

layers_vegetace = dplyr::tibble(
  nazev = c("Les", "LoukaPastvina", "RaselinisteMocalBazina", "ZahradaSadParkViniceChmelnice"),
  shpName = c("Les.shp", "LoukaPastvina.shp", "RaselinisteMocalBazina.shp", "ZahradaSadParkViniceChmelnice.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/vegetacePovrch.zip",
  kategorie = "vegetacePovrch",
  size = "100 MB"
)

layers_teren = dplyr::tibble(
  nazev = c("Jeskyne", "KotovanyBod", "SkalnatySraz", "Skaly", "TerenniStupen", "TerenniStupenSpadnice", "Vrstevnice"),
  shpName = c("Jeskyne.shp", "KotovanyBod.shp", "SkalnatySraz.shp", "Skaly.shp", "TerenniStupen.shp", "TerenniStupenSpadnice.shp", "Vrstevnice.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/terenniRelief.zip",
  kategorie = "terenniRelief",
  size = "233 MB"
)

layers_popis = dplyr::tibble(
  nazev = c("DefinicniBodCastiObce", "DefinicniBodSpravnihoCelku", "Jmeno_B", "Jmeno_L", "Jmeno_P", "ObjektRuzny"),
  shpName = c("DefinicniBodCastiObce.shp", "DefinicniBodSpravnihoCelku.shp", "Jmeno_B.shp", "Jmeno_L.shp", "Jmeno_P.shp", "ObjektRuzny.shp"),
  url = "https://geoportal.cuzk.cz/ZAKAZKY/Data50/popis.zip",
  kategorie = "popis",
  size = "4 MB"
)

data50layers <- bind_rows(layers_sidla, layers_komunikace, layers_produktovody,
                    layers_vodstvo, layers_hranice, layers_vegetace,
                    layers_teren, layers_popis)



usethis::use_data(data50layers, overwrite = TRUE, internal = TRUE)
