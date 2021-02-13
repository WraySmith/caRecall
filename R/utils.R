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
  check_url(url_)
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
# returns a tibble of output
clean_vrd_api <- function(api_output) {

  # change from json to dataframe format
  unclean_df <- as.data.frame(unlist(api_output$content$ResultSet, recursive = FALSE))

  # checks to verify dataframe is not empty
  if (length(unclean_df)==0) stop("API query had no results", call. = FALSE)

  # prepares for transpose by removing headers and data type values
  df <- unclean_df[, grep("Literal", colnames(unclean_df))]

  # transposes dataframe
  df <- as.data.frame(t(df), row.names = 1)

  # adds column names
  colnames(df) <- unclean_df$Name

  # checks data type values to change in data frame
  col_type <- unclean_df[, grep("Type", colnames(unclean_df))]

  # check for single row which is not a list
  if (is.list(col_type)) col_type <- col_type[[1]]

  # assigns columns types
  i <- 1
  for (element in col_type) {

    # change df column types
    if (element == "System.Decimal") df[[i]] <- as.integer(df[[i]])
    if (element == "System.DateTime") {
      df[[i]] <- as.Date(
        substr(
          df[[i]],
          1,
          nchar(df[[i]]) - 11
        ),
        "%m/%d/%Y"
      )
    }
    i <- i + 1
  }
  # output as tibble
  tibble::as_tibble(df)
}


check_url <- function(url_){

    # check year range
    if (grepl("year-range", url_, fixed = TRUE)){
      year_range_substring <- gregexpr(pattern ='year-range',url_)
      sub_string <- substring(url_, year_range_substring)
      years_as_string <- unlist(as.list(strsplit(sub_string, '/')[[1]])[2])
      years <- as.list(strsplit(years_as_string, '-')[[1]])
      start_year <- unlist(years[1])
      end_year <- unlist(years[2])
      if (start_year > end_year){
          stop("Start year must be less than or equal to the end year")
      }
    }

    # test limit
    if (grepl("limit", url_, fixed = TRUE)){
        limit_substring <- gregexpr(pattern ='limit',url_)
        sub_string <- substring(url_, limit_substring)
        limit_as_string <- unlist(as.list(strsplit(sub_string, '=')[[1]])[2])
        if(!is.null(limit_as_string)){
          if (as.integer((limit_as_string)) < 1){
            stop("Limit has to be greater or equal to 1")
          }
        }
    }

}

