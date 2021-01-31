#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' get_recall_numr
#'
#' @param recall_number An integer
#'
#' @return text output
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

    # run helper function
    call_vrd_api(url_, recall_number)


}
#Provides S3 output.
print.get_recall_num <- function(x, ...){
    cat("<Recall_Number ", x$number, ">/n", sep = "") #Was not sure as to the exact notation of this part.  Wasn't clear in example.
    str(x$content)
    invisible(x)

}



