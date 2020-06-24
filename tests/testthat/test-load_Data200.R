library(glue)

layers <- c("JezeroRybnikVodniNadrz", "GeomorfologickeOblasti", "NarodniParkPrirodniRezervace", "LesyPlantaze")

for (layer in layers) {

  test_that(glue::glue("Load Data 200 - {layer}"), {

    data <- load_Data200(layer)

    expect_s3_class(data, "data.frame")
    expect_s3_class(data, "sf")
  })
}

test_that("Load Data 200 - wrong layer", {
  expect_error(load_Data200("spatna vrstva", "Unknown layer requested"))
})


