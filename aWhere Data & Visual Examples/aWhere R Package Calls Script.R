#########################################################################
#########################################################################

###One-time aWhere R package install
##Run all three of the below commands once to install the package
##Consult Leila or Hanna for assistance if errors occur
##FMI on the aWhere R package, visit https://github.com/aWhereAPI/aWhere-R-Library/blob/master/documentation/complete-documentation.md

#########################################################################
#########################################################################

install.packages('devtools')
install.packages(c('chron', 'magrittr', 'DBI', 'assertthat', 'bitops', 
                   'Rcpp', 'tibble', 'jsonlite', 'data.table', 'httr', 
                   'lubridate', 'RCurl'))
devtools::install_github("aWhereAPI/aWhere-R-Library")

#########################################################################
#########################################################################

##Basic Commands in the aWhere R Package
#You may run these as many times as you would like, and update as needed

#########################################################################
#########################################################################

library(aWhereAPI)

##Get Token - key and secret
#update the fields "key" and "secret" with your personal key and secret accessed via the aWhere Developer Portal - http://developer.awhere.com/user/login

get_token("key", "secret")


###Create Field
#This will create a field in your aWhere account at the following location.  Update location and ID to create additional fields.

create_field(field_id = "hyderabad_center", latitude = "17.382814", longitude = "78.478075", farm_id = "Test")

###Get Fields List
#This will provide a list of all the fields currently stored in your aWhere account.

get_fields()

####Weather data - change name/id of field or latitude/longitude points, & customize start and end dates if desired.
#This pulls the data and creates a dataset in R titled "obs" that can be viewed later.
#The two lines below will perform an identical function - one calls location by field ID/name and the other by coordinates.

obs1 <- daily_observed_fields("hyderabad_center", day_start = "2017-01-01", day_end = "2017-04-01")
obs2 <- daily_observed_latlng(0.403444, 32.560327, day_start = "2017-01-01", day_end = "2017-04-01")

View(obs1)

###Forecast data - customize call as needed
#This pulls the data and creates a dataset in R titled "fcst" that can be viewed later.
#The two lines below will perform an identical function - one calls location by field ID/name and the other by coordinates.
#Note: Update day_start to be a day in the near future or today.

fcst1 <- forecasts_fields("hyderabad_center", day_start = "2017-05-13")
fcst2 <- forecasts_latlng(0.403444, 32.560327, day_start = "2017-05-13")

View(fcst1)

###Long-term norm data - norms determined based on month-day (MM-DD) spans, with default as 10-year norms. Can customize years and exclude years.
#This pulls the data and creates a dataset in R titled "ltn" that can be viewed later.

##10-year norms
ltn1 <- weather_norms_fields("hyderabad_center", monthday_start = "06-01", monthday_end = "09-01", year_start = 2006, year_end = 2015)
  
##custom-year norms
ltn2 <- weather_norms_fields("hyderabad_center", monthday_start = "01-01", monthday_end = "03-29", year_start = 2008, year_end = 2012)
  
View(ltn1)
View(ltn2)

###Agronomic data
#This pulls the data and creates a dataset in R titled "ag" or "ag_ltn" that can be viewed later.

ag1 <- agronomic_values_fields("hyderabad_center", day_start = "2017-01-01", day_end = "2017-04-01")
ag2 <- agronomic_values_fields("hyderabad_center", day_start = "2017-01-01", day_end = "2017-04-01")

###Agronomic Norms

##10-year norms
ag_ltn1 <- agronomic_norms_fields("hyderabad_center", month_day_start = "03-15", month_day_end = "04-01", year_start = 2006, year_end = 2015)

##custom-year norms
ag_ltn2 <- agronomic_norms_fields("hyderabad_center", month_day_start = "03-15", month_day_end = "04-01", year_start = 2010, year_end = 2014)

View(ag2)
View(ag_ltn2)

###Set Working Directory
##update this to use the file path on your computer where you would like to save your data.
setwd("C:/Users/yourname/Libraries/Documents")

###Save & export data into .csv file
#You can change which dataset you want to export - here we're exporting "ag_ltn2" and "obs1" into two separate files.
write.csv(ag_ltn2, file = "Agronomic Long Term Norms.csv")
write.csv(obs1, file = "Observations.csv")
