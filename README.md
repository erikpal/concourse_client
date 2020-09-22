README
================

## Overview

This is a basic R package for interfacing with the Intellidemia
Concourse API.

## Installation

bRush is not available on CRAN and can be installed directly from GitHub
using the devtools package (which is available on CRAN).

``` r
devtools::install_github("erikpal/bRush")
```

## Setup and use of API Token

To use this package, get the API token from the admin panel.

Place the token in a file called .Renviron as such:

``` r
CONCOURSE_KEY = ABcD123efG45hIJ78KLMno9PQrstuVwXyZ10
```

This method follows the best practice for developing API packages as
documented here:
<https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html>

Alternatively, you may place the token in a text file called token.txt
to be loaded from the working directory at the time needed.

You may store multiple keys for multiple servers, and override the
default name of “CONCOURSE\_KEY” by passing this arugument when making
requests:

``` r
env_var_name = "NameOfApiKey"
```

## Setup and use of server urls

The loadURL function will load urls provided in .Renviron file as well.
By default, the variables CONCOURSE\_SANDBOX, CONCOURSE\_URL use
“sandbox” or “production” as shortcuts for you development and
production environments. CONCOURSE\_SANDBOX is the default for all
functions. Any variable name can be specified, and you may also pass an
actual url instead of using environment variables (e.g, server =
“<https://univ.campusconcourse.com/>”).

## Example Usage

### Example \#1 - Make a custom table of syllabus items in a department (BIOL) templates

``` r
library(dplyr)
library(purrr)
library(tidyr)
library(magrittr)
library(concourseClient)

getCourseIDs(template = "templates", department_id = "BIOL") %>%  ## Call to get course IDs
  pull(external_id) %>%                                           ## Pull the IDs column
  map_df(~getCourseInfo(.x,                                       ## Call each syllabus
                        verbose = TRUE) %>%                       ## Use verbose mode
           .[["syllabus"]] %>%                                    ## Pull the syllabus list
           .[["children"]] %$%                                    ## Pull the children list
           tibble(external_id = .x,                               ## Make a data frame, add the ID
                  items = map(., ~.x$pretty_name)                 ## Unlist the pretty name
                  )
         ) %>% 
  unnest(items) %>%                                               ## Unnest the lsit of pretty names
  mutate(exists = TRUE) %>%                                       ## Make a variable to spread
  complete(items, nesting(external_id), 
           fill = list(exists = FALSE)) %>%                       ## Complete the data set with FALSE
  pivot_wider(names_from = items,                                 ## Spread the pretty names
              values_from = exists)                               ## Fill with exists
```

### Example \#2 - Create a report of syllabus activity for current classes by department

``` r
library(dplyr)
library(purrr)
library(concourseClient)

getCourseIDs(timeframe = "current", department_id = "PYCH") %>%   ## Call to get course IDs
  pull(external_id) %>%                                           ## Pull the IDs column
  map_df(~getSyllabusAccess(.x,                                   ## Call each syllabus
                            verbose = TRUE) %>%                   ## Use verbose mode
           .[["registrants"]] %>%                                 ## Pull the registrants list
           do.call(rbind, .) %>%                                  ## Convert the list to a matrix
           as.data.frame() %>%                                    ## Convert the matix to a df
           mutate(course_id = .x)                                 ## Add a course id column
  )
```
