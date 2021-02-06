test_that("recall_by_make returns the correct shape",{
    result <- recall_by_make('Nissan', limit=25)
    expect_type(result, "list")
    expect_equal(nrow(result), 25)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
})


