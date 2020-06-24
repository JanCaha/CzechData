library(glue)

ids <- c("534048", "568457", "587788", "546593", "587443")

layers <- c("adresni mista", "casti obce", "obec",
            "stavebni objekty", "ulice", "volebni okrsky", "zakladni sidelni jednotky")

for (id in ids) {
  for (layer in layers) {

    test_that(glue::glue("Load RUIAN settlement - {id} - {layer}"), {

      data <- load_RUIAN_settlement(id, layer)

      expect_s3_class(data, "data.frame")
      expect_s3_class(data, "sf")
    })
  }
}

test_that("Load cadastral data - wrong layer", {
  expect_error(load_RUIAN_settlement("534048", "spatna vrstva", "Uknown layer name (or alias)"))
})

test_that("Load cadastral data - wrong id", {
  expect_error(load_RUIAN_settlement("3722910", "adresni mista", "Variable id must follow the general pattern"))
  expect_error(load_RUIAN_settlement("599999", "adresni mista", "There is no settlement in Czech Republic"))
})
