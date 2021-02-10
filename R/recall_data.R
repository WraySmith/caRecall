#' recall_by_make
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @details
#' This function asks the VRD api for recalls for a specific make or manufacturer.
#' The API can be asked for vehicle names, car seats, tires, etc.
#' This function can be given a partial name with the partial boolean parameter set to true, and
#' the year range can be specified. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment, required to be set to VRD_API.
#'
#' @param make List string, a list of make names for vehicles
#' @param manufacturer A boolean, flag indicating if manufacturer should be used instead of make for the API call
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param limit An integer, how many entries to get from the website, default is no limit.
#' @param partial A boolean, to ask the API for partial matches on the model name.
#' @param api_key A string, optional
#'
#' @return A dataframe, collection of responses from the api
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_make('Nissan')
#' recall_by_make('Maz', end_year=2000, limit=100, partial=TRUE, api_key=API_KEY)
#' }
recall_by_make <- function(make, manufacturer = FALSE,
                           start_year = NULL, end_year = NULL,
                           limit = 25, partial = FALSE,
                           api_key = NULL) {

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

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make, limit, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # filters for exact result
    if (partial == FALSE & manufacturer == FALSE){
        contents_df <- contents_df[contents_df$`Make name`==toupper(toString(make)),]
    }
    if (partial == FALSE & manufacturer == TRUE){
        contents_df <- contents_df[contents_df$`Manufacturer Name`==toupper(toString(make)),]
    }


    # outputs dataframe
    contents_df

}

#' recall_by_model
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @details
#' This function asks the VRD api for recalls for a specific model.
#' The API can be asked for model names of vehicle , car seats, tires, etc.
#' This function can be given a partial name with the partial boolean parameter set to true, and
#' the year range can be specified. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment, required to be set to VRD_API.
#'
#' @param model List string, a list of make names
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param limit An integer, how many entries to get from the website, default is no limit.
#' @param partial A bool, to ask the API for partial matches on the model name.
#' @param api_key A string, optional
#'
#' @return A dataframe, collection of responses from the api
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_model('Civic')
#' recall_by_model('Sub', limit=100, partial=TRUE, api_key=API_KEY)
#' }
recall_by_model <- function(model,
                           start_year = NULL, end_year = NULL,
                           limit = 25, partial = FALSE,
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
    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model, limit, api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # filters for exact result
    if (partial == FALSE) {
        contents_df <- contents_df[contents_df$`Model name`==toupper(toString(model)),]
    }

    # outputs dataframe
    contents_df

}

#' recall_by_years
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @details
#' This function asks the VRD api for recalls for a year range.
#' It will return a list of vehicles, car seats, tires, etc. Can be given a start year
#' and or a end year. The default for the start and end year are 1900 and 2100.
#' The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment, required to be set to VRD_API.
#'
#' @param start_year An integer, start of year range, defaults to 1900.
#' @param end_year An integer, end of year range, defaults to 2100.
#' @param limit An integer, how many entries to get from the website, default is no limit.
#' @param api_key A string, optional
#'
#' @return A dataframe, collection of responses from the api
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_years(2010, 2012, limit=100)
#' recall_by_years(2010, 2012, api_key=API_KEY)
#' }
recall_by_years <- function(start_year = 1900, end_year = 2100,
                            limit = 25, api_key = NULL) {

    # format the url string
    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
    url_ <- paste(url_, year_range, sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, year_range, limit,
                               api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)


    # output dataframe
    contents_df

}

#' recall_by_number
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @details
#' This function asks the VRD api for recalls for list of given recall numbers. It can be given
#' either a single recall number or a list of recall numbers. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment, required to be set to VRD_API.
#'
#' @param recall_number List integer, list of recalls numbers to get information on
#' @param limit An integer, how many entries to get from the website, default is no limit.
#' @param api_key A string, optional
#'
#' @return A dataframe, collection of responses from the api
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_number(1977044)
#' recall_by_number(c(2014216, 2013022))
#' }
recall_by_number <- function(recall_number, limit = 25, api_key = NULL) {

    # create multiple requests from input list
    input_request <- paste(recall_number, collapse = '|')

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, input_request, sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, recall_number, limit,
                               api_key = api_key)

    # convert content to a dataframe
    contents_df <- clean_vrd_api(api_output)

    # output dataframe
    contents_df

}

#' recall_details
#'
#' Queries the API with a url that it generates from it's parameters.
#'
#' @details
#' This function asks the API for details for recall numbers. Recall numbers can be
#' passed as an integer or a list of integers. Response detail columns are given in
#' English and in French. The API key can be passed manually, or if it is not passed
#' it will use the API key in the R environment, required to be set to VRD_API.
#'
#' @param recall_number List integer
#' @param limit An integer, how many entries to get from the website, default is no limit.
#' @param api_key A string, optional
#'
#' @return A dataframe, collection of responses from the api
#' @export
#'
#' @examples
#' \dontrun{
#' recall_details(1977044)
#' recall_details(c(2014216, 2013022))
#' }
recall_details <- function(recall_number, limit = 25, api_key = NULL) {

    # a limit of 60 calls are allowed per minute
    # this function rate limits and a call with 600 numbers would take > 10 min
    if (length(recall_number) > 600) {
        stop(
            print('Number of recall_numbers must be less than 600'),
            call. = FALSE)
    }


    i <- 1
    for (single_number in recall_number) {

        # format the url string
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/"
        url_ <- paste(url_, toString(single_number), sep = "")

        # api call, returns class vrd_api
        api_output <- call_vrd_api(url_, single_number,
                                   api_key = api_key)

        if (i == 1) {
            # initialize dataframe
            compiled_df <- clean_vrd_api(api_output)

        } else {
            # append to dataframe
            compiled_df <- rbind(compiled_df, clean_vrd_api(api_output))
        }

        Sys.sleep(1)
        i <- i + 1

    }
    # output dataframe
    compiled_df

}

