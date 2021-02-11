#' Count of recalls searching by make or manufacturer
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' make or manufacturer search term.
#'
#' @details
#' Asks the API for the number of recalls for a given make or manufacturer's name.
#' A year range can be specified. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment.
#'
#' @param make List of make or manufacturer names.
#' @param manufacturer Logical; if TRUE, manufacturer is searched on instead
#' of make.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' A data.frame of recall summary information from the Vehicle Recalls
#' Database. Includes six columns.
#'
#' @return A data.frame providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_make('Nissan')
#' count_recall_by_make(c('Mazda', 'Toyota'), start_year = 2008)
#' API_KEY <- 'xxxxxxxxxxx'
#' count_recall_by_make('Maz', end_year = 2000, api_key = API_KEY)
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

    # API call, returns class vrd_api
    api_output <- call_vrd_api(url_, make, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # outputs dataframe
    contents_df

}

#' Count of recalls searching by model
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' model search term.
#'
#' @details
#' Asks the API for the number of recalls for a given model name.
#' A year range can be specified. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment.
#'
#' @param model List of model names.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A data.frame providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_model('civic')
#' count_recall_by_model(c('Subaru', 'Toyota'), start_year = 2008)
#' API_KEY <- 'xxxxxxxxxxx'
#' count_recall_by_model('Sub', end_year = 2000, api_key = API_KEY)
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

    # API call, returns class vrd_api
    api_output <- call_vrd_api(url_, model, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # outputs dataframe
    contents_df

}

#' Count of recalls searching by year
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' year range search term.
#'
#' @details
#' Asks the API for the number of recalls for a given year range.
#' The year range can be specified, or the defaults can be used.
#' The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment.
#'
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A data.frame providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_years(2010, 2012)
#' API_KEY <- 'xxxxxxxxxxx'
#' count_recall_by_years(end_year = 1970, api_key = API_KEY)
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



