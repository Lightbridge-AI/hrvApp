# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency

usethis::use_pipe()
usethis::use_package("tools")
usethis::use_package("readr")
usethis::use_package("readtext")
usethis::use_package("tibble")
usethis::use_package("dplyr")
usethis::use_package("purrr")
usethis::use_package("stringr")
usethis::use_package("openxlsx")

## Dev Package
usethis::use_dev_package("physiolab", remote = "Lightbridge-AI/physiolab")

## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "read_hrv" ) # Name of the module
golem::add_module( name = "read_brs" ) # Name of the module

## Add helper functions ----
## Creates ftc_* and utils_*
golem::add_fct( "read_hrv" ) 
golem::add_fct( "read_brs" ) 
golem::add_utils( "helper" )

## Global Vars
# Put this in  R/globals.R
# utils::globalVariables(c("var1"))
usethis::use_r("globals.R")


## External resources
## Creates .js and .css files at inst/app/www
# golem::add_js_file( "script" )
# golem::add_js_handler( "handlers" )
# golem::add_css_file( "custom" )

## Add internal datasets ----
## If you have data in your package
#usethis::use_data_raw( name = "my_dataset", open = FALSE ) 

## Tests ----
## Add one line by test you want to create
#usethis::use_test( "app" )

# Documentation

## Vignette ----
# usethis::use_vignette("hrvApp")
# devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
#usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
#covrpage::covrpage()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

