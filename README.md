# CzechData


The aim of the package is to provide interface from R to download various data relevant to Czech Republic directly into R. The data will be classic tabular as well as other types (e.g. spatial data). 

Unfortunately, it is unlikely that the data will make sense for you, unless you speak Czech or are highly familiar with Czech data sources.

## Installation

You can install the current version of the package from GitHub using package remotes:

``` r
remotes::install_github("JanCaha/CzechData")
```

## Website

[Available here.](https://jancaha.github.io/CzechData/index.html)

## Example

```r
# simple RUIAN data for whole state
obce_CR <- load_RUIAN_state(layer = "obce")

# RUIAN data for single settlement
adresy_vyskov <- load_RUIAN_settlement("592889", layer = "adresní místa")


# cadastral data for single cadastral territory
parcely_vyskov <- load_cadastral_territory("788571", layer = "parcely")

# data SLDB
sldb_data_obyvatele <- load_SLDB_2011(type = "obyvatelstvo")

# population data for settlements
population_2015 <- load_population(year = 2015)

# population data by age category 
population_2011_kraje <- load_population_age(year = 2011, area_type = "kraje")

# load or save Data50
rivers <- load_Data50(layer = "VodniTok")
folder_communications <- save_Data50("~/data/coomunications", type = "komunikace")

# load or save Data200
waterfalls <- load_Data200(layer = "Vodopad")
folder_water_objects <- save_Data200("~/data/water", type = "Vodopad")
```

## Data sources

Main source of the datasets is portal of Czech open data - [https://data.gov.cz](https://data.gov.cz). 

Currently implemented data sources are:

* RUIAN on the state level [described here](https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---atom.cuzk.cz-api-3-action-package_show-id-cz-00025712-cuzk_ruian-staty-shp_1)
* RUIAN on settlement level [example here](https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---atom.cuzk.cz-api-3-action-package_show-id-cz-00025712-cuzk_ruian-obce-shp_554979)
* Cadastral map for cadastral territory [example here](https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---atom.cuzk.cz-api-3-action-package_show-id-cz-00025712-cuzk_km-ku-shp_600016)
* SLDB (census) subsections [individual datasets here](https://data.gov.cz/datov%C3%A9-sady?dotaz=SLDB) 
* yearly data about population by sex [for settlements](https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---vdb.czso.cz-pll-eweb-package_show-id-130149), [by age categories](https://data.gov.cz/datov%C3%A1-sada?iri=https%3A%2F%2Fdata.gov.cz%2Fzdroj%2Fdatov%C3%A1-sada%2Fhttp---vdb.czso.cz-pll-eweb-package_show-id-130142)
* [Data50](https://geoportal.cuzk.cz/(S(2ugpect2xdu0ksih3crtpxd0))/Default.aspx?lng=CZ&mode=TextMeta&text=dSady_mapyData50&side=mapy_data50&menu=2290&head_tab=sekce-02-gp)
* [Data200](https://geoportal.cuzk.cz/(S(ijginumejzilvacbfijkylwj))/Default.aspx?mode=TextMeta&side=mapy_data200&text=dSady_mapyData200&head_tab=sekce-02-gp&menu=229)

### Details about datasets

RUIAN is described in detail: [https://www.cuzk.cz/](https://www.cuzk.cz/Uvod/Produkty-a-sluzby/RUIAN/2-Poskytovani-udaju-RUIAN-ISUI-VDP/Vymenny-format-RUIAN/Vymenny-format-RUIAN-(VFR)/Struktura-a-popis-VFR-1_8_0.aspx)
