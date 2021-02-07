test_that("count_recall_by_make returns expected value", {
    query <- count_recall_by_make("Nissan", start_year = 1995, end_year = 1998)
    expect_type(query, "list")
    expect_equal(query[[1]], 43)
    expect_equal(nrow(query), 1)
    expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_make shape with default limits", {
    query <- count_recall_by_make("Nissan")
    expect_type(query, "list")
    expect_equal(nrow(query),1)
    expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_make with manufacturer", {
    query <- count_recall_by_make("Nissan", manufacturer = TRUE, start_year = 1995, end_year = 1998)
    expect_type(query, "list")
    expect_equal(query[[1]], 59)
    expect_equal(nrow(query), 1)
    expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_model returns expected value", {
    query <- count_recall_by_make("Altima", start_year = 1995, end_year = 1998)
    expect_type(query, "list")
    expect_equal(query[[1]], 43)
    expect_equal(nrow(query), 1)
    expect_equal(colnames(query), "Result Count")
})

test_that("count_recall_by_model shape with default limits", {
    query <- count_recall_by_make("Altima")
    expect_type(query, "list")
    expect_equal(nrow(query),1)
    expect_equal(colnames(query), "Result Count")
})


