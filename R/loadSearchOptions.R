#' Load the search parameters from a page
#'
#' This isn't an API function, but scrapes the search options from the base URL and returns a named list.
#' @param server Options are "sandbox", "production", or a provided URL
#' @return url A named list of search options

#' @export

loadSearchOptions <- function(server = "sandbox") {
  
  url <- loadURL(server)
  
  url$path <- "search"
  
  response <- httr::GET(url)
  content <- httr::content(response, as = "text", encoding = "UTF-8")
  
  content <- xml2::read_html(content)
  
  items <- list("prefix",
                "campus_id",
                "school_id",
                "department_id",
                "session",
                "credits",
                "delivery_method")
  
  result <- list()
  
  for (i in items) {
    path <- paste0('//*[@id="', i, '"]')
    
    node <- rvest::html_nodes(content, xpath = path)
    node <- rvest::html_nodes(node, "option")
    
    vec <- rvest::html_attr(node, "value")
    names(vec) <- rvest::html_text(node, "value")
    
    vec <- vec[!vec %in% c("-1", "")]
    
    result[[i]] <- vec
  }
  
  return(result)
}


