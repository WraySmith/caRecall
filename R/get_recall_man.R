#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' get_recall_man
#'
#' @param manufacturer A string
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' get_recall_manu('Nissan')
#' }
get_recall_manu <- function(manufacturer) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    url_ <- paste(url_, toString(manufacturer), sep="")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, manufacturer)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}



