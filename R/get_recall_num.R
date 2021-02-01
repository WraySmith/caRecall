#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' get_recall_num
#'
#' @param recall_number An integer
#'
#' @return dataframe
#' @export
#'
#' @examples
#' \dontrun{
#' get_recall_num(1977044)
#' }
get_recall_num <- function(recall_number) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep="")

    # api call, returns class vrd_api
    api_output <- call_vrd_api(url_, recall_number)

    # convert content to a dataframe
    contents_df <- as.data.frame(api_output$content)

    # currently just provides raw dataframe output, needs to be cleaned up
    # any repetitive clean-up should go into helper functions
    contents_df

}




