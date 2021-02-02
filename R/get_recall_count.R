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
    url_ <- paste(url_, toString(make), sep = "")

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

#' get_recall_model
#'
#' @param model A string
#'
#' @return integer
#'
#' @examples
#' \dontrun{
#' get_recall_model('488')
#' }
get_recall_model <- function(model) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
    url_ <- paste(url_, toString(model), sep = "")

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



