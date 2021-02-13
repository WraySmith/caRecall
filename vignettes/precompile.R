# Precompiled vignettes that depend on API key
# Must manually move image files from caRecall/ to caRecall/vignettes/ after knit

library(knitr)
knit("vignettes/vrd_vignette.Rmd.orig", "vignettes/vrd_vignette.Rmd")