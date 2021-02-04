test_that("bad api key correctly fails", {
  make <- "Mazda"
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
  url_ <- paste(url_, toString(make), "/count", sep = "")
  expect_error(call_vrd_api(url_,make, api_key="test"))
})

test_that("call_rd_api() returns the correct structure",{
    # uses an example from the site with out an api key
    test_url <- "http://data.tc.gc.ca/v1.3/api/eng/vehicle-recall-database/recall/make-name/volkswagen/count?format=json "
    response <- call_vrd_api(test_url, "", api_key="test")
    expect_type(response, "list")
})
