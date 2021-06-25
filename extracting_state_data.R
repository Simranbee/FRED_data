library(tidyquant)
library(purrr)
library(stringr)
library(dplyr)
setwd("~/Documents/fred")

#This code is for downlaoding state level data from FRED and saving to
#csv.  All visualizations of this data were done in jupyter
#you only have to change on line 13 (in this case it says RGSP but 
#you can change it to whatever you need ex: "UR" for unemployment data)

download_all_states <- function(state_code) {
  fred_code <- str_c(state_code, "RGSP")  #the only thing you change is RGSP
  
  tq_get(fred_code, get = "economic.data",
       from = "1997-01-01") %>%
    mutate(state = state_code)
}

all_states_GSP1 <- map_dfr(state.abb, download_all_states)

write.csv(all_states_GSP1, "state_level_Real_GDP.csv")
