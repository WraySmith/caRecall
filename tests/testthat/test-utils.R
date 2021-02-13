test_that("API key is retreived", {
  expect_type(get_vrd_key(), "character")
})

test_that("Bad API key correctly fails", {
  # valid url
  url_test <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
  query_test <- "ford"
  bad_key <- "test"
  expect_error(call_vrd_api(url_test, query = query_test, api_key = bad_key))
})

test_that("API call returns correct structure", {
  url_test <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
  query_test <- "ford"
  response <- call_vrd_api(url_test, query = query_test)
  expect_s3_class(response, "vrd_api", exact = FALSE)
  expect_type(response$response, "list")
  expect_equal(response$response$status_code, 200)
})

test_that("Clean API returns formatted dataframe", {
  # setup for one of the output structures
  # used for all functions except `recall_details()`
  url_test1 <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/ford"
  query_test1 <- "ford"
  response1 <- call_vrd_api(url_test1, query = query_test1, limit = 25)
  coltype1 <- c(rep("character", 4), "integer", "double")
  # setup for other output structures, used by `recall_detils()`
  url_test2 <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/1977044"
  query_test2 <- "1977045"
  response2 <- call_vrd_api(url_test2, query = query_test2)
  coltype2 <- c(rep("character", 6), "integer", rep("character", 6), "integer", "double")
  # tests for first structure
  expect_s3_class(clean_vrd_api(response1), "data.frame")
  expect_equal(nrow(clean_vrd_api(response1)), 25)
  expect_equal(as.vector(sapply(clean_vrd_api(response1), typeof)), coltype1)
  # tests for second structure
  expect_s3_class(clean_vrd_api(response2), "data.frame")
  expect_equal(nrow(clean_vrd_api(response2)), 1)
  expect_equal(as.vector(sapply(clean_vrd_api(response2), typeof)), coltype2)
})

test_that("Url format is correct",{
  url_with_broken_years <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/Maz/year-range/2005-2000/count"
  expect_error(check_url(url_with_broken_years))

  url_with_bad_limit <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/911|ranger/year-range/2008-2100?limit=-10"
  expect_error(check_url(url_with_bad_limit))

  url_with_proper_format <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/Maz/year-range/1995-2000/count"
  check_url(url_with_proper_format)
  url_with_limit <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/Maz/year-range/1995-2000/count?limit=10"
  check_url(url_with_limit)
  url_with_null_limit <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/Maz/year-range/1995-2000/count?limit="
  check_url(url_with_null_limit)
  url_with_no_years <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/Maz/count"
  check_url(url_with_no_years)
})
