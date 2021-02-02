#' recall_by_make
#'
#' @param make A string
#' @param limit An integer
#' @param partial A bool
#'
#' @return dataframe
#'
#' @examples
#' \dontrun{
#' recall_by_make('Nissan')
#' }
recall_by_make <- function(make, manufacturer = FALSE, limit = 25, partial = FALSE) {

    # format the url string
    if (manufacturer) {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    } else {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
    }
    url_ <- paste(url_, toString(make), sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make, limit)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' recall_by_model
#'
#' @param model A string
#' @param limit An integer
#' @param partial A bool
#'
#' @return dataframe
#'
#' @examples
#' \dontrun{
#' recall_by_model('Civic')
#' }
recall_by_model <- function(model, limit = 25, partial = FALSE) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, toString(model), sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model, limit)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

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

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}

#' recall_by_number
#'
#' @param recall_number An integer
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

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, recall_number, limit)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}

#' recall_details
#'
#' @param recall_number An integer
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

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, recall_number, limit)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}

