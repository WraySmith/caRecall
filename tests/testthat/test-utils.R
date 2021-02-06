<<<<<<< HEAD
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
=======
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

<<<<<<< HEAD
test_that("API call returns correctly",{
>>>>>>> 6b2e748 (add tests for get_vrd_api and call_vrd_api)
=======
test_that("Clean API returns formatted dataframe", {
>>>>>>> 0b8185f (clean-up recall_details())
    url_test <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
    query_test <- 'ford'
    response <- call_vrd_api(url_test, query = query_test)
    expect_s3_class(response, 'vrd_api', exact = FALSE)
    expect_type(response$response, 'list')
    expect_equal(response$response$status_code, 200)
})

<<<<<<< HEAD
test_that("Clean API returns formatted dataframe", {
    url_test1 <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
    query_test1 <- 'ford'
    response1 <- call_vrd_api(url_test1, query = query_test1, limit = 25)
    url_test2 <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/1977044"
    query_test2 <- '1977044'
    response2 <- call_vrd_api(url_test2, query = query_test2)
    expect_s3_class(clean_vrd_api(response1), 'data.frame')
    expect_equal(nrow(clean_vrd_api(response1)), 25)
    expect_s3_class(clean_vrd_api(response2), 'data.frame')
    expect_equal(nrow(clean_vrd_api(response2)), 1)
})

=======
>>>>>>> 6b2e748 (add tests for get_vrd_api and call_vrd_api)
