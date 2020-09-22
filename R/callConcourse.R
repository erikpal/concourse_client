#' Call Concourse
#'
#' @param url The url constructed for the API call
#' @param env_var_name The name of the environment variable of the API key
#' @param verbose Enable verbose mode
#'
#' @return content of the API call as a list
#' @export

callConcourse <- function(url,
                          env_var_name = "CONCOURSE_KEY", 
                          verbose = FALSE) {
  
  token <- loadToken(env_var_name)
  
  if(verbose == TRUE) {print("Making call...")}
  
  response <- httr::GET(url, httr::add_headers("X-AUTH-KEY" = token))
  
  if(verbose == TRUE) {
    print(paste("URL Called:    ", response$url))
    print(paste("Status Code:   ", response$status_code))
    print(paste("Response Date: ", response$date))
    print("Response times:")
    print(response$times)
  }
  
  content <- httr::content(response, as = "text", encoding = "UTF-8")

  return(content)
  
}