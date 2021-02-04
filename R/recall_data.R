#' recall_by_make
#'
#' @param make List string
#' @param manufacturer A bool, with this flag we are asking for the manufacturer not the make
#' @param start_year An integer
#' @param end_year An integer
#' @param limit An integer
#' @param partial A bool
#'
#' @return dataframe
#'
#' @examples
#' \dontrun{
#' recall_by_make('Nissan')
#' }
recall_by_make <- function(make, manufacturer = FALSE,
                           start_year = NULL, end_year = NULL,
                           limit = 25,
                           partial = FALSE) {

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
        if (is.null(start_year)) start_year = 1900
        if (is.null(end_year)) end_year = 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make, limit)

    # set database
    contents_df <- data.frame(matrix(ncol = length(api_output$content$ResultSet[[1]]$Name)))
    colnames(contents_df) <- api_output$content$ResultSet[[1]]$Name

    # convert content to a dataframe
    for (i in 1:length(api_output$content$ResultSet)){
        contents_df<-rbind(contents_df,api_output$content$ResultSet[[i]]$Value.Literal)
    }

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' recall_by_model
#'
#' @param model List string
#' @param start_year An integer
#' @param end_year An integer
#' @param limit An integer
#' @param partial A bool
#'
#' @return dataframe
#'
#' @examples
#' \dontrun{
#' recall_by_model('Civic')
#' }
recall_by_model <- function(model,
                           start_year = NULL, end_year = NULL,
                           limit = 25,
                           partial = FALSE) {

    # create multiple requests from input list
    input_request <- paste(model, collapse = '|')

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, input_request, sep = "")

    # append year range criteria to url if input by user
    if (!is.null(start_year) | !is.null(end_year)) {

        # add start or end year if value one of the values is NULL
        if (is.null(start_year)) start_year = 1900
        if (is.null(end_year)) end_year = 2100

        year_range <- paste(toString(start_year), toString(end_year), sep = "-")
        url_ <- paste(url_, '/year-range/', year_range, sep = "")
    }

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model, limit)

    # set database
    contents_df <- data.frame(matrix(ncol = length(api_output$content$ResultSet[[1]]$Name)))
    colnames(contents_df) <- api_output$content$ResultSet[[1]]$Name

    # convert content to a dataframe
    for (i in 1:length(api_output$content$ResultSet)){
        contents_df<-rbind(contents_df,api_output$content$ResultSet[[i]]$Value.Literal)
    }

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' recall_by_years
#'
#' @param start_year An integer
#' @param end_year An integer
#' @param limit An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_years(2010, 2012)
#' }
recall_by_years <- function(start_year = 1900, end_year = 2100, limit = 25) {

    # format the url string
    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
    url_ <- paste(url_, year_range, sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, year_range, limit)

    # set database
    contents_df <- data.frame(matrix(ncol = length(api_output$content$ResultSet[[1]]$Name)))
    colnames(contents_df) <- api_output$content$ResultSet[[1]]$Name

    # convert content to a dataframe
    for (i in 1:length(api_output$content$ResultSet)){
        contents_df<-rbind(contents_df,api_output$content$ResultSet[[i]]$Value.Literal)
    }

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' recall_by_number
#'
#' @param recall_number List integer
#' @param limit An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_number(1977044)
#' }
recall_by_number <- function(recall_number, limit = 25) {

    # create multiple requests from input list
    input_request <- paste(recall_number, collapse = '|')

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, input_request, sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, recall_number, limit)

    # set database
    contents_df <- data.frame(matrix(ncol = length(api_output$content$ResultSet[[1]]$Name)))
    colnames(contents_df) <- api_output$content$ResultSet[[1]]$Name

    # convert content to a dataframe
    for (i in 1:length(api_output$content$ResultSet)){
        contents_df<-rbind(contents_df,api_output$content$ResultSet[[i]]$Value.Literal)
    }

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' recall_details
#'
#' @param recall_number List integer
#' @param limit An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' recall_details(1977044)
#' }
recall_details <- function(recall_number, limit = 25) {

    # a limit of 60 calls are allowed per minute
    # this function rate limits and a call with 600 numbers would take > 10 min
    if (length(recall_number) > 600) {
        stop(
            print('Number of recall_numbers must be less than 600'),
            call. = FALSE)
    }

    compiled_df <- vector(mode = "list", length = length(recall_number))
    i <- 1
    for (single_number in recall_number) {

        # format the url string
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/"
        url_ <- paste(url_, toString(single_number), sep = "")

        # api call, returns class vrd_api
        api_output <- call_vrd_api(url_, single_number, limit)

        # convert content to a dataframe
        ### NOTE that it may make sense to do format differently here
        compiled_df[i] <- api_output$content

        Sys.sleep(1)
        i <- i + 1

    }

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    compiled_df

}

