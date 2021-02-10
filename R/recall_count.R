#' count_recall_by_make
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @param make List string, make or manufacturer name(s)
#' @param manufacturer A boolean, with this flag we are asking for the manufacturer not the make.
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param api_key A string, optional
#'
#' @return An integer, the number of recalls for input make in given year range.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_make('Nissan')
#' count_recall_by_make('Firestone', manufacturer=TRUE)
#' count_recall_by_make('Firestone', api_key=API_KEY)
#' }
count_recall_by_make <- function(make, manufacturer = FALSE, start_year = NULL,
                                 end_year = NULL, api_key = NULL) {

    # create multiple requests from input list
    input_request <- paste(make, collapse = '|')

    # format the url string
    if (manufacturer) {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    } else {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
    }

    url_ <- paste(url_, input_request, sep = "")

    # append year range criteria to url if input by user
    if (!is.null(start_year) | !is.null(end_year)) {

        # add start or end year if value one of the values is NULL
        if (is.null(start_year)) start_year <- 1900
        if (is.null(end_year)) end_year <- 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }

    # add count to url
    url_ <- paste (url_, "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # outputs dataframe
    contents_df

}

#' count_recall_by_model
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @param model List string, make or manufacturer name(s)
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param api_key A string, optional.
#'
#' @return integer, the number of recalls for input model in given year range.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_model('488')
#' count_recall_by_model('911', start_year=1980, end_year=2005)
#' }
count_recall_by_model <- function(model, start_year = NULL, end_year = NULL,
                                  api_key = NULL) {

    # create multiple requests from input list
    input_request <- paste(model, collapse = '|')

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, input_request, sep = "")

    # append year range criteria to url if input by user
    if (!is.null(start_year) | !is.null(end_year)) {

        # add start or end year if value one of the values is NULL
        if (is.null(start_year)) start_year <- 1900
        if (is.null(end_year)) end_year <- 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }
    # add count to url
    url_ <- paste (url_, "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # outputs dataframe
    contents_df

}

#' count_recall_by_years
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param api_key A string, optional.
#'
#' @return A dataframe of vehicles for the year range.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_years(2010, 2012)
#' count_recall_by_years(2010, 2012, api_key=API_KEY)
#' }
count_recall_by_years <- function(start_year = 1900, end_year = 2100,
                                  api_key = NULL) {

    # format the url string
    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
    url_ <- paste(url_, year_range,  "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, year_range, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # outputs dataframe
    contents_df

}



