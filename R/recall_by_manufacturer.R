#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' recall_by_manufacturer
#'
#' @param manufacturer: A car manufacturer name (ie. Honda, Nissan, etc.)
#' limit: Number of records to return (default is 25)
#' page: the serach page result to return (default is 1)
#'
#'
#' @return text output
#' @export
#'
#' @examples
#' \dontrun{
#' get_recall_by_number(1977044)
#' }
recall_manufacturer <- function(manufacturer, limit=25, page=1) {

    # refer to: https://httr.r-lib.org/articles/api-packages.html

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
    url_ <- paste(url_, toString(manufactuer), sep="")

    # run helper function
    call_vrd_api(url_, manufacturer, limit, page)

}
#Provides S3 output.
print.recall_manufacturer <- function(x, ...){
    cat("<Manufacturer ", x$name, ">/n", sep = "") #Was not sure as to the exact notation of this part.  Wasn't clear in example.
    str(x$content)
    invisible(x)
}



