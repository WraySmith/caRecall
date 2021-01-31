#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' recall_by_number
#'
#' @param recall_number An integer
#'
#' @return text output
#' @export
#'
#' @examples
#' \dontrun{
#' get_recall_by_number(1977044)
#' }
recall_by_number <- function(recall_number) {

    # refer to: https://httr.r-lib.org/articles/api-packages.html

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep="")

    # run helper function
    call_vrd_api(url_, recall_number)
}
#Provides S3 output.
print.recall_by_number <- function(x, ...){
    cat("<Recall_Number ", x$number, ">/n", sep = "") #Was not sure as to the exact notation of this part.  Wasn't clear in example.
    str(x$content)
    invisible(x)
}



