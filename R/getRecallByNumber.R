#' get_recall_by_number
#'
#' @param recall_number An integer
#'
#' @return url response
#' @export
#'
#' @examples
#' \dontrun{
#' get_recall_by_number(1977044)
#' }
get_recall_by_number <- function(recall_number) {
    # TODO : add error handeling, parsing, provide S3 output class, and setting a user agent
    # refer to: https://httr.r-lib.org/articles/api-packages.html

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep="")

    # query the api
    response <- httr::GET(url_, add_headers("user-key"=Sys.getenv("VRD_API")))
    httr::content(response)

}
