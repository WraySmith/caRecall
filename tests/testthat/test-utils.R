test_that("bad api key correctly fails", {
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
  expect_error(call_vrd_api(url_, 'ford', api_key="test"))
})

test_that("call_rd_api() returns the correct structure",{
    # uses an example from the site with out an api key
    test_url <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
    response <- call_vrd_api(test_url, "ford")
    expect_type(response, "list")
})
