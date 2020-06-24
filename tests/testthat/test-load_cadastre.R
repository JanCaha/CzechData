library(glue)

ids <- c("780014", "705497", "652067", "722910", "655848")

layers <- c("BODOVE_POLE_B", "BODOVE_POLE_T", "budovy body", "BUDOVY_DEF",
            "budovy", "DALSI_PRVKY_MAPY_B", "DALSI_PRVKY_MAPY_L", "DALSI_PRVKY_MAPY_T",
            "hranice parcel", "KATASTRALNI_UZEMI_DEF", "KATASTRALNI_UZEMI_L",
            "katastralni uzemi", "PARCELY_KN_B", "PARCELY_KN_DEF", "PARCELY_KN_L",
            "parcely", "PRVKY_ORIENT_MAPY_B", "PRVKY_ORIENT_MAPY_L", "PRVKY_ORIENT_MAPY_T",
            "VB_P")

for (id in ids) {
  for (layer in layers) {

    test_that(glue::glue("Load cadastral data - cadastral territory {id} - {layer}"), {

      data <- load_cadastral_territory(id, layer)

      expect_s3_class(data, "data.frame")
      expect_s3_class(data, "sf")
    })
  }
}

test_that("Load cadastral data - wrong layer", {
  expect_error(load_cadastral_territory("722910", "spatna vrstva", "Uknown layer name (or alias)"))
})

test_that("Load cadastral data - wrong id", {
  expect_error(load_cadastral_territory("3722910", "budovy body", "Variable id must follow the general pattern"))
  expect_error(load_cadastral_territory("722999", "budovy body", "There is no cadastral territory in Czech Republic"))
})
