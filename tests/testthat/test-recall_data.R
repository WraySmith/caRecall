test_that("recall_by_make returns the correct shape",{

    result <- recall_by_make('Nissan', partial=FALSE)
    expect_type(result, "list")
    expect_equal(nrow(result), 25)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- c("character", "character", "character",
                         "character", "integer",   "Date")
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)
    names <- unique(result$`Make name`)
    expect_equal(length(names), 1)

    Sys.sleep(1.5)

})

test_that("recall_by_make by year range has the correct shape",{

    result <- recall_by_make('Nissan', start_year = 1980, end_year=2005)
    expect_gt(nrow(result), 0)
    filtered <- subset(result, Year >= 1980 & Year <= 2005)
    expect_equal(nrow(result), nrow(filtered))
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- c("character", "character", "character",
                         "character", "integer",   "Date")
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)

    result <- recall_by_make('Nissan', start_year = 1980)
    expect_gt(nrow(result), 0)

    result <- recall_by_make('Nissan', end_year = 1980)
    expect_gt(nrow(result), 0)

    Sys.sleep(1.5)

})

test_that("recall_by_make using partial has the correct shape",{

    result <- recall_by_make('N', partial = TRUE, manufacturer = FALSE)
    names <- unique(result$`Make name`)
    expect_gt(length(names), 1)

    Sys.sleep(1.5)

    result <- recall_by_make('Nissan', partial = FALSE, manufacturer = TRUE)
    names <- unique(result$`Manufacturer Name`)
    expect_equal(length(names), 1)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- c("character", "character", "character",
                         "character", "integer",   "Date")
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)

    Sys.sleep(1.5)

})

test_that("recall_by_model has the correct shape",{

    result <- recall_by_model('Civic', limit=25, partial=TRUE)
    expect_type(result, "list")
    expect_equal(nrow(result), 25)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- c("character", "character", "character",
                         "character", "integer",   "Date")
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)
    names <- unique(result$`Model name`)
    expect_gt(length(names), 1)

    Sys.sleep(1.5)

    result <- recall_by_model('Civic', start_year = 1980)
    expect_gt(nrow(result), 0)
    filtered <- subset(result, Year >= 1980)
    expect_equal(nrow(result), nrow(filtered))

    Sys.sleep(1.5)

    result <- recall_by_model('Civic', end_year = 1980)
    expect_gt(nrow(result), 0)
    filtered <- subset(result, Year <= 1980)
    expect_equal(nrow(result), nrow(filtered))

    Sys.sleep(1.5)

})

test_that("recall_by_year returns the correct shape",{

    result <- recall_by_years(2010, 2012)
    expect_type(result, "list")
    expect_equal(nrow(result), 25)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    filtered <- subset(result, Year >= 2010 & Year <= 2012)
    expect_equal(nrow(result), nrow(filtered))
    expected_dtypes <- c("character", "character", "character",
                         "character", "integer",   "Date")
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)

    Sys.sleep(1.5)

})

test_that("recall_by_number returns the correct shape",{

    result <- recall_by_number(1977044)
    expect_type(result, "list")
    expect_equal(nrow(result), 1)
    expected_col_names <- c("Recall number","Manufacturer Name",
                            "Model name", "Make name", "Year","Recall date")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- append(rep("character", 4), c("integer", "Date"))
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)

    Sys.sleep(1.5)

})

test_that("recall_details returns the correct shape when given a list",{

    recall_numbers <- c(1977044, 2009097)
    result <- recall_details(recall_numbers)
    expect_type(result, "list")
    expect_gt(nrow(result), 1)
    expected_col_names <- c("RECALL_NUMBER_NUM","MANUFACTURER_RECALL_NO_TXT", "CATEGORY_ETXT",
                            "CATEGORY_FTXT", "MODEL_NAME_NM", "MAKE_NAME_NM",
                            "UNIT_AFFECTED_NBR", "SYSTEM_TYPE_ETXT", "SYSTEM_TYPE_FTXT",
                            "NOTIFICATION_TYPE_ETXT", "NOTIFICATION_TYPE_FTXT", "COMMENT_ETXT",
                            "COMMENT_FTXT", "DATE_YEAR_CD", "RECALL_DATE_DTE")
    expect_equal(colnames(result), expected_col_names)
    expected_dtypes <- c(rep("character", 6),
                         c("integer"),
                         rep("character", 6),
                         c("integer", "Date"))
    returned_dtypes <- as.vector(sapply(result, class))
    expect_equal(returned_dtypes, expected_dtypes)

    Sys.sleep(1.5)

    recall_numbers <- seq(1, 700, by=1)
    expect_error(recall_details(recall_numbers))
})
