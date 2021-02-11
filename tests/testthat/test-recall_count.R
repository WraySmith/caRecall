test_that("count_recall_by_make returns expected value", {
  query <- count_recall_by_make("Nissan", start_year = 1995, end_year = 1998)
  expect_type(query, "list")
  expect_equal(query[[1]], 43L)
  expect_equal(nrow(query), 1)
  expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_make with manufacturer", {
  query <- count_recall_by_make("Nissan", manufacturer = TRUE, start_year = 1995, end_year = 1998)
  expect_type(query, "list")
  expect_equal(query[[1]], 59L)
  expect_equal(nrow(query), 1)
  expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_model returns expected value", {
  query <- count_recall_by_model("Altima", start_year = 1995, end_year = 1998)
  expect_type(query, "list")
  expect_equal(query[[1]], 2L)
  expect_equal(nrow(query), 1)
  expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_years returns expected value", {
  query <- count_recall_by_years(start_year = 1995, end_year = 1998)
  expect_type(query, "list")
  expect_equal(query[[1]], 5597L)
  expect_equal(nrow(query), 1)
  expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_years returns expected value", {
  query <- count_recall_by_years()
  expect_type(query, "list")
  expect_type(query[[1]], "integer")
  expect_equal(nrow(query), 1)
  expect_equal(colnames(query), "Result Count")
})
