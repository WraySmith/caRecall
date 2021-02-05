#' count_recall_by_make
#'
#' @param make list string
#' @param manufacturer A bool, with this flag we are asking for the manufacturer not the make
#' @param start_year An integer
#' @param end_year An integer
#'
#' @return integer
#'
#' @examples
#' \dontrun{
#' count_recall_by_make('Nissan')
#' }
count_recall_by_make <- function(make, manufacturer = FALSE,
                                 start_year = NULL, end_year = NULL) {

    # create multiple requests from input list
    input_request <- paste(make, collapse = '|')

    # format the url string
    if (manufacturer) {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    } else {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
    }
    url_ <- paste(url_, input_request, "/count", sep = "")

    # append year range criteria to url if input by user
    if (!is.null(start_year) | !is.null(end_year)) {

        # add start or end year if value one of the values is NULL
        if (is.null(start_year)) start_year = 1900
        if (is.null(end_year)) end_year = 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make)

    #### THIS NEEDS TO BE EXTRACTED DIFFERNTLY ####

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' count_recall_by_model
#'
#' @param model list string
#' @param start_year An integer
#' @param end_year An integer
#'
#' @return integer
#'
#' @examples
#' \dontrun{
#' count_recall_by_model('488')
#' }
count_recall_by_model <- function(model, start_year = NULL, end_year = NULL) {

    # create multiple requests from input list
    input_request <- paste(model, collapse = '|')

        # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, input_request, "/count", sep = "")

    # append year range criteria to url if input by user
    if (!is.null(start_year) | !is.null(end_year)) {

        # add start or end year if value one of the values is NULL
        if (is.null(start_year)) start_year = 1900
        if (is.null(end_year)) end_year = 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model)

    #### THIS NEEDS TO BE EXTRACTED DIFFERNTLY ####

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' count_recall_by_years
#'
#' @param start_year An integer
#' @param end_year An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_years(2010, 2012)
#' }
count_recall_by_years <- function(start_year = 1900, end_year = 2100) {

    # format the url string
    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
    url_ <- paste(url_, year_range,  "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, year_range)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}



