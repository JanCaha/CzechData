library(glue)

layers <- c("DefinicniBodCastiObce", "HraniceSpravniJednotkyaKU", "ElektrickeVedeni", "Hrad")

for (layer in layers) {

  test_that(glue::glue("Load Data 50 - {layer}"), {

    data <- load_Data50(layer)

    expect_s3_class(data, "data.frame")
    expect_s3_class(data, "sf")
  })
}

test_that("Load Data 50 - wrong layer", {
  expect_error(load_Data50("spatna vrstva", "Unknown layer requested"))
})
