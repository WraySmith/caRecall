#ua <- user_agent("http://github.com/WrathSmith/caRecall")
#ua
#' get_recall_by_number
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
get_recall_by_number <- function(recall_number) {

    # refer to: https://httr.r-lib.org/articles/api-packages.html

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
    url_ <- paste(url_, toString(recall_number), sep="")

    # query the api
    response <- httr::GET(url_, add_headers("user-key"=Sys.getenv("VRD_API")))

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
            number = recall_number,
            response = response
        ),
        class = "vrd_api"
    )

}
#Provides S3 output.
print.get_recall_by_number <- function(x, ...){
    cat("<Recall_Number ", x$number, ">/n", sep = "") #Was not sure as to the exact notation of this part.  Wasn't clear in example.
    str(x$content)
    invisible(x)
}



