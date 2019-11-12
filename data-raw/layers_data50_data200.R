library(tidyverse)


# data50 --------------------------------------------------------------------------------------

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


# data200 -------------------------------------------------------------------------------------

layers_hranice = dplyr::tibble(
  nazev = c("AdministrativniHraniceLinie", "AdministrativniUzemiCentroid", "AdministrativniUzemiUTJ", "AdministrativniUzemiObce", "AdministrativniUzemiOkresy", "AdministrativniUzemiKraje"),
  shpName = c("PolbndL.shp", "PolbndP.shp", "PolbndDA.shp", "PolbndMunDA.shp", "PolbndDistDA.shp", "PolbndRegDA.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/BND.zip",
  kategorie = "Hranice",
  slozka = "BND",
  size = "32 MB"
)

layers_vodstvo = dplyr::tibble(
  nazev = c("HrazJezNad50m", "HrazJezPod50m", "JezeroRybnikVodniNadrz", "VodniTokPod50m", "VodniTokNad50m", "Ostrovy", "MokrinaBazina", "Vodopad", "Prameny1", "Prameny2"),
  shpName = c("DamL.shp", "DamC.shp", "LakeresA.shp", "WatrcrsA.shp", "WatrcrsL.shp", "IslandA.shp", "SwampA.shp", "RapidsC.shp", "SpringC.shp", "SpringP.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/HYDRO.zip",
  kategorie = "Vodstvo",
  slozka = "HYDRO",
  size = "7 MB"
)

layers_popis = dplyr::tibble(
  nazev = c("OrografickeNazvy", "GeomorfologickeOblasti", "GeomorfologickeCelky", "GeomorfologickePodcelky"),
  shpName = c("GNameT.shp", "GName5A.shp", "GName6A.shp", "GName7A.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/NAME.zip",
  kategorie = "Popis",
  slozka = "NAME",
  size = "8 MB"
)

layers_ruzne = dplyr::tibble(
  nazev = c("NarodniParkPrirodniRezervace", "Produktovod", "Vysilac", "VyznamneObjekty", "ProduktovodVyznamneBody", "Věž", "DulLom", "Budova", "ElektrickeVedeni", "Elektrarna"),
  shpName = c("ParkA.shp", "IndprodP.shp", "CtowerP.shp", "LandmrkP.shp", "IndprodL.shp", "TowerP.shp", "ExtractP.shp", "BuildP.shp", "PowerL.shp", "PowerP.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/MISC.zip",
  kategorie = "RuzneObjekty",
  slozka = "MISC",
  size = "1 MB"
)

layers_sidla = dplyr::tibble(
  nazev = c("ObceBody", "ObcePolygony"),
  shpName = c("BuiltupP.shp", "BuiltupA.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/POP.zip",
  kategorie = "Sidla",
  slozka = "POP",
  size = "10 MB"
)

layers_doprava = dplyr::tibble(
  nazev = c("Privoz", "PrivozStanice", "ZeleznicniPrejezd", "Heliport", "LanovaDraha", "DalnicniOdpocivka", "KrizovatkaMimourovnova", "LetisteNad40Ha", "LetisteNad40HaBod", "ZelezniceZastavky", "LetistePod40Ha", "LodniPristav", "PristavaciDraha", "Zeleznice", "Silnice"),
  shpName = c("FerryL.shp", "FerryC.shp", "LevelcC.shp", "HeliP.shp", "CablecL.shp", "RestC.shp", "IntercC.shp", "AirfldA.shp", "AirfldC.shp", "RailrdC.shp", "AirfldP.shp", "HarborP.shp", "RunwayL.shp", "RailrdL.shp", "RoadL.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/TRANS.zip",
  kategorie = "Doprava",
  slozka = "TRANS",
  size = "10 MB"
)

layers_vegetace = dplyr::tibble(
  nazev = c("LesyPlantaze"),
  shpName = c("VegA.shp"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/VEG.zip",
  kategorie = "Vegetace",
  slozka = "VEG",
  size = "7 MB"
)

layers_relief = dplyr::tibble(
  nazev = c("KotovaneBody", "Vrstevnice", "SkalniStenaSraz", "Jeskyne" , "DMR", "DMRShaded"),
  shpName = c("ElevP.shp", "ElevL.shp", "PhysL.shp", "PhysP.shp", "DigterR.tif", "HilshaR.tif"),
  url = "http://geoportal.cuzk.cz/ZAKAZKY/Data200/REL.zip",
  kategorie = "Relief",
  slozka = "REL",
  size = "231 MB"
)

data200layers <- bind_rows(layers_hranice, layers_vodstvo, layers_popis,
                           layers_ruzne, layers_sidla, layers_doprava,
                           layers_vegetace, layers_relief)

usethis::use_data(data50layers, data200layers, overwrite = TRUE, internal = TRUE)
