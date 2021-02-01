#' get_vrd_api
#'
#' @return A string that is your VRD_API key
#' @export
#'
#' @examples
#' get_vrd_api()
get_vrd_api <- function() {
    x <- Sys.getenv("VRD_API")
    if (x == "") {
        stop("You must set your VRD_API with `Sys.setenv(VRD_API = 'your_api_key_here')`")
    }
    x
}


#' call_vrd_api()
#'
#'helper function for querying api database
#'
#' @return vrd_api class
#' @export
#'
#' @examples
#' \dontrun{
#' call_vrd_api()
#' }
call_vrd_api <- function(url_, query, limit=25, page=1){

    # query the api
    response <- httr::GET(url_, httr::add_headers("user-key"=get_vrd_api(),"limit"=limit, "page"=page))

    #check to verify json response
    if (httr::http_type(response) != "application/json") {
        stop("API did not return json", call. = FALSE)
    }

    #parses response
    parsed <- jsonlite::fromJSON(httr::content(response, "text"), flatten = TRUE)

    if (httr::status_code(response) != 200) {
        stop(
            sprintf(
                "Vehicle Recall Database request failed [%s]\n%s\n<%s>",
                httr::status_code(response),
                parsed$message,
                parsed$documentation_url
            ),
            call. = FALSE
        )
    }


    structure(
        list(
            content = parsed,
            name = query,
            response = response
        ),
        class = "vrd_api"
    )

}

# this is a placeholder helper function that allows print from class vrd_api
# need to determine if we want to keep something like this, leave as a placeholder
print_vrd_api <- function(x, ...){
    cat("<Recall_Number ", x$name, ">\n", sep = "")
    utils::str(x$content)
    invisible(x)
}


