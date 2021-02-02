#' count_recall_make
#'
#' @param make A string
#'
#' @return integer
#'
#' @examples
#' \dontrun{
#' count_recall_make('Nissan')
#' }
count_recall_make <- function(make, manufacturer = FALSE) {

    # format the url string
    if (manufacturer) {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    } else {
        url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
    }
    url_ <- paste(url_, toString(make), "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, make)

    #### THIS NEEDS TO BE EXTRACTED DIFFERNTLY ####

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' count_recall_model
#'
#' @param model A string
#'
#' @return integer
#'
#' @examples
#' \dontrun{
#' count_recall_model('488')
#' }
count_recall_model <- function(model) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, toString(model), "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, model)

    #### THIS NEEDS TO BE EXTRACTED DIFFERNTLY ####

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    # if partial = FALSE need to filter data, if partial = TRUE return all data
    contents_df

}

#' count_recall_years
#'
#' @param start_year An integer
#' @param end_year An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_years(2010, 2012)
#' }
count_recall_years <- function(start_year = 1900, end_year = 2100) {

    # format the url string
    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, year_range,  "/count", sep = "")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, year_range)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}



