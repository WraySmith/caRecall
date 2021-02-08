#' get_vrd_key
#'
#' @return A string that is your VRD_API key
#' @export
#'
#' @examples
#' \dontrun{
#' get_vrd_key()
#' }
get_vrd_key <- function() {
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
#' @param url_ api url to be hit
#' @param query names the resulting object
#' @param limit how many items to get from the api, default to no limit
#' @param api_key defaults to the one set in the environment, can be pass one manually
#'
#' @return vrd_api class
#'
#' @examples
#' \dontrun{
#' call_vrd_api()
#' }
call_vrd_api <- function(url_, query = NULL, limit = NULL,
                         api_key=get_vrd_key()){

    # add limit to url (limit does not go in header)
    url_ <- paste(url_, "?limit=", toString(limit), sep = "")

    # set the user agent
    ua <- httr::user_agent("https://github.com/WraySmith/caRecall")

    # set headers (currently only user-key is set)
    headers <- httr::add_headers("user-key" = api_key)

    # query the api
    response <- httr::GET(url_, headers, ua)

    ### NEED TO PROVIDE MORE ERROR OUTPUT HERE
    ### POTENTIALLY API KEY AND LINK TO DOCS
    if (httr::status_code(response) != 200) {
        stop(
            sprintf(
                "Vehicle Recall Database request failed [%s]\n%s",
                httr::status_code(response),
                response$request$url
            ),
            call. = FALSE
        )
    }

    # check to verify json response
    if (httr::http_type(response) != "application/json") {
        stop("API did not return json", call. = FALSE)
    }

    # parse response
    parsed <- jsonlite::fromJSON(httr::content(response, "text"), flatten = TRUE)

    # create a class for the returned response
    structure(
        list(
            content = parsed,
            name = query,
            response = response
        ),
        class = "vrd_api"
    )

}


#' clean_vrd_api()
#'
#'helper function for cleaning api database
#'
#' @param api_output api response to be cleaned
#'
#' @return dataframe
#'
#' @examples
#' \dontrun{
#' clean_vrd_api()
#' }
clean_vrd_api <- function(api_output){

    # makes dataframe of output
    df1 <- as.data.frame(unlist(api_output$content$ResultSet,recursive=FALSE))

    # only keeps columns with values
    df2 <- df1[, grep("Literal", colnames(df1))]

    # transposes dataframe
    df3 <- as.data.frame(t(df2), row.names = 1)

    # adds back the correct column names
    colnames(df3) <- df1$Name

    # checks column types
    col_type <- df1[, grep("Type", colnames(df1))]

    # check for single row
    if (is.list(col_type)){
        col_type <- col_type[[1]]
    }

    # assigns columns
    i <- 1
    for (element in col_type){

        # change df type
        if (element == "System.Decimal"){
            df3[[i]] <- as.integer(df3[[i]])
        }
        if (element == "System.DateTime"){
            df3[[i]] <- as.Date(substr(df3[[i]],
                                       1,
                                       nchar(df3[[i]])-11),
                                "%m/%d/%Y")
        }
        i <- i + 1
    }
    # output dataframe
    df3
}


