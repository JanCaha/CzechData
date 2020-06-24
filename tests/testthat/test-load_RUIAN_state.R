library(glue)

layers <- c("katastralni uzemi", "obce", "okresy", "orp", "pou", "regiony",
            "stat", "stavebni urady", "volebni okrsky", "kraje")

for (layer in layers) {

  test_that(glue::glue("Load RUIAN for Czech Republic works - {layer}"), {

      data <- load_RUIAN_state(layer)

      expect_s3_class(data, "data.frame")
      expect_s3_class(data, "sf")
  })

}

test_that("Load RUIAN for Czech Republic - wrong layer", {
  expect_error(load_RUIAN_state("spatna vrstva", "Uknown layer name (or alias)"))
})
