#' Retrieves API key from environment
#'
#' Retrieves API key from environment if available.
#'
#' @details
#' An API key is required to use the functions in \code{caRecall} and query the
#' Vehicle Recalls Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')}. Alternatively, instead of
#' setting the API key in the environment, the key can be passed into the
#' functions as an argument.
#'
#' @return VRD_API access key if set in environment. If access key is not
#' available, returns an error that the API key is not found and needs to
#' either be set in the environment or passed as an argument into functions.
#' @export
#'
#' @examples
#' \dontrun{
#' get_vrd_key()
#' }
get_vrd_key <- function() {
  x <- Sys.getenv("VRD_API")
  if (x == "") {
    stop("You must provide an API key to the function or use `Sys.setenv(VRD_API = 'your_API_key_here')`")
  }
  x
}

# function used to query the API
# not a user facing function
call_vrd_api <- function(url_, query = NULL, limit = NULL,
                         api_key = NULL) {

  # retrieve API key if no user key input to function call
  if (is.null(api_key)) api_key <- get_vrd_key()

  # add limit to url (limit does not go in header)
  url_ <- paste(url_, "?limit=", toString(limit), sep = "")

  # set the user agent
  ua <- httr::user_agent("https://github.com/WraySmith/caRecall")

  # set headers (currently only user-key is set)
  headers <- httr::add_headers("user-key" = api_key)

  # query the API
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

# function used to clean the response from the API call
# not a user facing function
clean_vrd_api <- function(api_output) {

  # makes dataframe of output
  df1 <- as.data.frame(unlist(api_output$content$ResultSet, recursive = FALSE))

  # only keeps columns with values
  df2 <- df1[, grep("Literal", colnames(df1))]

  # transposes dataframe
  df3 <- as.data.frame(t(df2), row.names = 1)

  # adds back the correct column names
  colnames(df3) <- df1$Name

  # checks column types
  col_type <- df1[, grep("Type", colnames(df1))]

  # check for single row
  if (is.list(col_type)) {
    col_type <- col_type[[1]]
  }

  # assigns columns
  i <- 1
  for (element in col_type) {

    # change df type
    if (element == "System.Decimal") {
      df3[[i]] <- as.integer(df3[[i]])
    }
    if (element == "System.DateTime") {
      df3[[i]] <- as.Date(
        substr(
          df3[[i]],
          1,
          nchar(df3[[i]]) - 11
        ),
        "%m/%d/%Y"
      )
    }
    i <- i + 1
  }
  # output dataframe
  df3
}
