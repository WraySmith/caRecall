#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' get_recall_by_number
#'
#' @param manufactuer: A car manufactuer name (ie. Honda, Nissan, etc.)
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
recall_manufactuer <- function(manufactuer, limit=25, page=1) {

    # refer to: https://httr.r-lib.org/articles/api-packages.html

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufactuer-name/"
    url_ <- paste(url_, toString(manufactuer), sep="")

    # query the api
    response <- httr::GET(url_, add_headers("user-key"=Sys.getenv("VRD_API"),"limit"=limit, "page"=page))

    #check to verify json response
    if (http_type(response) != "application/json") {
        stop("API did not return json", call. = FALSE)
    }

    #parses response
    parsed <- jsonlite::fromJSON(content(response, "text"), simplifyVector = FALSE)

    if (status_code(response) != 200) {
        stop(
            sprintf(
                "Vehicle Recall Database request failed [%s]\n%s\n<%s>",
                status_code(response),
                parsed$message,
                parsed$documentation_url
            ),
            call. = FALSE
        )
    }

    #httr::content(response)

    structure(
        list(
            content = parsed,
            name = manufactuer,
            response = response
        ),
        class = "recall_manufactuer"
    )

}
#Provides S3 output.
print.get_recall_by_number <- function(x, ...){
    cat("<Manufactuer ", x$name, ">/n", sep = "") #Was not sure as to the exact notation of this part.  Wasn't clear in example.
    str(x$content)
    invisible(x)
}



