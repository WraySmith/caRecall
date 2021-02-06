context("Helper Functions")

test_that("API key is retreived", {
  expect_type(get_vrd_key(), 'character')
})

test_that("Bad API key correctly fails", {
  # valid url
  url_test <- 'https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford'
  query_test <- 'ford'
  bad_key <- 'test'
  expect_error(call_vrd_api(url_test, query = query_test, api_key = bad_key))
})

test_that("API call returns correct structure", {
    url_test <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
    query_test <- 'ford'
    response <- call_vrd_api(url_test, query = query_test)
    expect_s3_class(response, 'vrd_api', exact = FALSE)
    expect_type(response$response, 'list')
    expect_equal(response$response$status_code, 200)
})

test_that("Clean API returns formatted dataframe", {
    url_test <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
    query_test <- 'ford'
    response <- call_vrd_api(url_test, query = query_test)
    expect_s3_class(response, 'vrd_api', exact = FALSE)
    expect_type(response$response, 'list')
    expect_equal(response$response$status_code, 200)
})

