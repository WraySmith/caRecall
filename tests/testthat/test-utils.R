test_that("bad api key correctly fails", {

  make <- "Mazda"
  working_api <- Sys.getenv("VRD_API")
  Sys.setenv(VRD_API = "test")
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
  url_ <- paste(url_, toString(make), "/count", sep = "")
  expect_error(call_vrd_api(url_,make))
  Sys.setenv(VRD_API = working_api)

})
