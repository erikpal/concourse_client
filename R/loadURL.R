#' Load Server URL
#' 
#' Will load server url from system variable or defer to supplied url. Assumes that the following url variables have 
#' been set in the .Renviron folder: CONCOURSE_URL, CONCOURSE_SANDBOX
#' @param server Either the name of the environment variable for the url, or a provided string beginning with 'http'
#' @return url A character vector of of the url

loadURL <- function(server) {
  
  if (server == "production") {
    server <- "CONCOURSE_URL"
  }
  
  if (server == "sandbox") {
    server <- "CONCOURSE_SANDBOX"
  }
  
  if (grepl("^http\\w{0,1}://", server)) {
    server <- server
  } else if (Sys.getenv(server) == "") {
    stop("Please place a url file in .Renviron")
  } else {
    server <- Sys.getenv(server)
  }
  
  url <- httr::parse_url(server)
  
  return(url)
}
