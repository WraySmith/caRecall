test_that("bad api key correctly fails", {

  make <- "Mazda"
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
  url_ <- paste(url_, toString(make), "/count", sep = "")
  expect_error(call_vrd_api(url_,make, api_key="test"))


})
