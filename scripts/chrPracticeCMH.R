# Coren Huff
# 2026-06-02
#playing with 2025 VA CHR

#load readxl
library(readxl)
library(tidyverse)

# import file 
chr <- read_excel("data-raw/2025CHR.xlsx", 
           sheet = "Select Measure Data", 
           skip=1)
View(chr)

names(chr) <- names(chr) |> 
              gsub(" ", "_", x=_) |> 
              gsub(",", "", x=_) |> 
              gsub("%", 'Pct', x=_)

names(chr)

#select FIPS, STATE, COUNTY, FEI, and YPLL from chr
foodLife <- chr |> 
  select("FIPS",
         "State",
         "County", 
         "Food_Environment_Index", 
         "Years_of_Potential_Life_Lost_Rate")

#plot YPLL by FEI and lable the axes
foodLife |> 
  ggplot(aes(Food_Environment_Index, Years_of_Potential_Life_Lost_Rate)) +
    geom_point()+
    xlab("Food Environment Index(1-10)")+
    ylab("YPLL Rate per 100,000")

#find out which counties have the highest and lowest YPLL
max(Years_of)

str(foodLife)  
  
  
  
  
  
