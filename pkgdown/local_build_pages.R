library(pkgdown)

pkgdown::clean_site()

pkgdown::build_article()

build_site(lazy = TRUE,
           devel = TRUE)

preview_site()
