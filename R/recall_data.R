#' Summary of recalls searching by make or manufacturer
#'
#' Returns summary information of recalls in the Vehicle Recalls Database based
#' on a make or manufacturer search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by make or manufacturer and returns
#' summary recall information. The year range of the search can be specified
#' and is based on the manufactured year and not the year a recall occurred.
#' Partial search term matches can also be returned by the function and is the
#' default. Note that if \code{partial = FALSE} is used, the number of entries
#' returned by the function may be less than the count provided by
#' \code{\link{count_recall_by_make}} which returns a count for all partial
#' matches.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param make List of make or manufacturer names. Case insensitive.
#' @param manufacturer Logical; if TRUE, manufacturer is searched on instead
#' of make.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param limit Number indicating how many recall entries should be returned.
#' Defaults to 25 which is the default of the API.
#' @param partial Logical; if TRUE, returns all partial search term matches.
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble of recall summary information from the Vehicle Recalls
#' Database. Includes six columns.
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_make("Nissan")
#' recall_by_make(c("Mazda", "Toyota"), start_year = 2008, partial = FALSE)
#' API_KEY <- "xxxxxxxxxxx"
#' recall_by_make("Maz", end_year = 2000, limit = 100, api_key = API_KEY)
#' }
recall_by_make <- function(make, manufacturer = FALSE,
                           start_year = NULL, end_year = NULL,
                           limit = 25, partial = TRUE,
                           api_key = NULL) {

  # create multiple requests from input list
  input_request <- paste(make, collapse = "|")

  # format the url string
  if (manufacturer) {
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
  } else {
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
  }

  url_ <- paste(url_, input_request, sep = "")

  # append year range criteria to url if input by user
  if (!is.null(start_year) | !is.null(end_year)) {

    # add start or end year if value one of the values is NULL
    if (is.null(start_year)) start_year <- 1900
    if (is.null(end_year)) end_year <- 2100

    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- paste(url_, "/year-range/", year_range, sep = "")
  }

  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, make, limit, api_key = api_key)

  # convert content to a tibble
  contents_df <- clean_vrd_api(api_output)

  # filters for exact result
  if (partial == FALSE & manufacturer == FALSE) {
    contents_df <- contents_df[contents_df$`Make name` == toupper(toString(make)), ]
  }
  if (partial == FALSE & manufacturer == TRUE) {
    contents_df <- contents_df[contents_df$`Manufacturer Name` == toupper(toString(make)), ]
  }


  # outputs tibble
  contents_df
}

#' Summary of recalls searching by model
#'
#' Returns summary information of recalls in the Vehicle Recalls Database based
#' on a model search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by model and returns summary recall
#' information. The year range of the search can be specified and is based on
#' the manufactured year and not the year a recall occurred. Partial search
#' term matches can also be returned by the function and is the default. Note
#' that if \code{partial = FALSE} is used, the number of entries returned by the
#' function may be less than the count provided by
#' \code{\link{count_recall_by_model}} which returns a count for all partial
#' matches.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param model List of model names.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param limit Number indicating how many recall entries should be returned.
#' Defaults to 25 which is the default of the API.
#' @param partial Logical; if TRUE, returns all partial search term matches.
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble of recall summary information from the Vehicle Recalls
#' Database. Includes six columns.
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_model("civic")
#' recall_by_model(c("ranger", "brz"), start_year = 2008, partial = TRUE)
#' API_KEY <- "xxxxxxxxxxx"
#' recall_by_model("Sub", end_year = 2000, limit = 100, api_key = API_KEY)
#' }
recall_by_model <- function(model,
                            start_year = NULL, end_year = NULL,
                            limit = 25, partial = TRUE,
                            api_key = NULL) {

  # create multiple requests from input list
  input_request <- paste(model, collapse = "|")

  # format the url string
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
  url_ <- paste(url_, input_request, sep = "")

  # append year range criteria to url if input by user
  if (!is.null(start_year) | !is.null(end_year)) {

    # add start or end year if value one of the values is NULL
    if (is.null(start_year)) start_year <- 1900
    if (is.null(end_year)) end_year <- 2100

    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- paste(url_, "/year-range/", year_range, sep = "")
  }
  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, model, limit, api_key = api_key)

  # convert content to a tibble
  contents_df <- clean_vrd_api(api_output)

  # filters for exact result
  if (partial == FALSE) {
    contents_df <- contents_df[contents_df$`Model name` == toupper(toString(model)), ]
  }

  # outputs tibble
  contents_df
}

#' Summary of recalls searching by years
#'
#' Returns summary information of recalls in the Vehicle Recalls Database based
#' on a year range search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by year range and returns
#' summary recall information. If \code{start_year} and/or \code{end_year} are
#' not specified, the function will default to the start and/or end years
#' available in the database. Note that the year range is based on the
#' manufactured year and not the year a recall occurred.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param start_year Start of year range.
#' @param end_year End of year range.
#' @param limit Number indicating how many recall entries should be returned.
#' Defaults to 25 which is the default of the API.
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble of recall summary information from the Vehicle Recalls
#' Database. Includes six columns.
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_years(2010, 2012, limit = 100)
#' API_KEY <- "xxxxxxxxxxx"
#' recall_by_years(end_year = 1970, api_key = API_KEY)
#' }
recall_by_years <- function(start_year = 1900, end_year = 2100,
                            limit = 25, api_key = NULL) {

  # format the url string
  year_range <- paste(toString(start_year), toString(end_year), sep = "-")
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
  url_ <- paste(url_, year_range, sep = "")

  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, year_range, limit,
    api_key = api_key
  )

  # convert content to a tibble
  contents_df <- clean_vrd_api(api_output)


  # output tibble
  contents_df
}

#' Summary of recalls searching by recall number(s)
#'
#' Returns summary information of recalls in the Vehicle Recalls Database based
#' on recall numbers(s).
#'
#' @details
#' Queries the Vehicle Recalls Database API by recall number and returns
#' summary recall information.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param recall_number List of recall numbers.
#' @param limit Number indicating how many recall entries should be returned.
#' Defaults to 25 which is the default of the API.
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble of recall summary information from the Vehicle Recalls
#' Database. Includes six columns.
#' @export
#'
#' @examples
#' \dontrun{
#' recall_by_number(1977044)
#' API_KEY <- "xxxxxxxxxxx"
#' recall_by_number(c(2014216, 2013022), api_key = API_KEY)
#' }
recall_by_number <- function(recall_number, limit = 25, api_key = NULL) {

  # create multiple requests from input list
  input_request <- paste(recall_number, collapse = "|")

  # format the url string
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/recall-number/"
  url_ <- paste(url_, input_request, sep = "")

  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, recall_number, limit,
    api_key = api_key
  )

  # convert content to a tibble
  contents_df <- clean_vrd_api(api_output)

  # output tibble
  contents_df
}

#' Detailed information on recalls searching by recall number(s)
#'
#' Returns detailed information on recalls in the Vehicle Recalls Database
#' based on recall numbers(s).
#'
#' @details
#' Queries the Vehicle Recalls Database API by recall number and returns
#' detailed recall information for each number. Note that each recall number
#' provided to the function results in a separate API call. Accordingly,
#' the rate of API calls is limited to one call per second to stay within the
#' API limit. For example, providing a list of 60 recall numbers to the function
#' would take approximately 1 minute to complete.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param recall_number List of recall numbers.
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble of detailed recall information from the Vehicle Recalls
#' Database. Includes 15 columns.
#' @export
#'
#' @examples
#' \dontrun{
#' recall_details(1977044)
#' API_KEY <- "xxxxxxxxxxx"
#' recall_details(c(2014216, 2013022), api_key = API_KEY)
#' }
recall_details <- function(recall_number, api_key = NULL) {

  # a limit of 60 calls are allowed per minute
  # this function rate limits and a call with 600 numbers would take > 10 min
  if (length(recall_number) > 600) {
    stop(
      print("Number of recall_numbers must be less than 600"),
      call. = FALSE
    )
  }


  i <- 1
  for (single_number in recall_number) {

    # format the url string
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall-summary/recall-number/"
    url_ <- paste(url_, toString(single_number), sep = "")

    # API call, returns class vrd_api
    api_output <- call_vrd_api(url_, single_number,
      api_key = api_key
    )

    if (i == 1) {
      # initialize tibble
      compiled_df <- clean_vrd_api(api_output)
    } else {
      # append to tibble
      compiled_df <- rbind(compiled_df, clean_vrd_api(api_output))
    }

    Sys.sleep(1)
    i <- i + 1
  }
  # output tibble
  compiled_df
}
