# R Practice DSPG 2026
# Coren Huff
# 2026-06-01

#load tidyverse
library(tidyverse)

# Getting started ---------------------------------------------------------

#download file, we commented the whole thing so we don't keep downloading the file
# download.file(
#   "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv",
#   "data-raw/SAFI_clean.csv", mode = "wb"
# )

#read data in
# na = NULL tells R that "NULL" in the dataset is a missing value
interviews <- read_csv(
  "data-raw/SAFI_clean.csv", 
  na = "NULL"
)

#this exploratory stuff would normally be done in the console 
View(interviews)
class(interviews)
glimpse(interviews) #turns tibble on its side
head(interviews)
tail(interviews)

#statistical summary of each variable
summary(interviews)

#structure how the data is read in
str(interviews)
str(interviews$liv_count)

#[row, column]
interviews[1,1]
#slicing, give first three values in the fifth column
interviews[1:3,5]
#leaving blank makes it inclusive beginning to end
interviews[ , 1:3]
#negative indices give whole thing but 1, for example this is all but first variable
interviews[ , -1]

#accessing variables by name
#returns a vector
interviews$village
#returns a tibble
interviews["village"]

area_hectares <- 1.0
area_acres <- area_hectares*2.47
area_hectacres <- 2.5 # does not update area_acres

round(3.14159)
args(round)
?round
round(3.14159, 2)
round(3.14159, -1)
round(42, -1)

hh_members <- c(3, 7, 10, 6)
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
key_id <- c("1", "2", "3")
#key_id[1] + key_id[2]
hh_members[1:2]
hh_members[2:length(hh_members)]
#gives last three
hh_members[(length(hh_members) -2):length(hh_members)]

hh_members <- c(hh_members, "NULL")
hh_members <- c(3, 7, 10, 6)

logi_vec <- c("TRUE", "FALSE", "TRUE")
c(1, logi_vec)
c("word", logi_vec)
hh_members <- c(hh_members, NA)

NaN #special missing value (not a number)

mean(hh_members)
#na.rm = TRUE strips the NA values before computation 
mean(hh_members, na.rm = TRUE)
max(hh_members, na.rm = TRUE)

#gather hh_members where it is NOT (!) missing
hh_members[!is.na(hh_members)]
#taking ****
na.omit(hh_members)

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
levels(respondent_floor_type)
respondent_floor_type

days_of_week <- factor(
  c("Monday", "Tuesday", "Wednesday", "Thursday", "Monday"), 
  levels=c("Monday", "Tuesday", "Wednesday", "Thursday"),
  ordered=TRUE
  )

as.character(days_of_week)
as.numeric(days_of_week)
as.factor(days_of_week)

hh_fact <- factor(hh_members)
as.numeric(hh_fact)
as.numeric(as.character(hh_fact))

dates <- interviews$interview_date
str(dates)
interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)
dates[1]+years(30)

# if you wanted to change it in the dataset
interviews$interview_date <- interviews$interview_date+years(1)
interviews$interview_date <- interviews$interview_date-years(1)

interviews <- read_csv("data-raw/SAFI_clean.csv")

# dplyr----
#
interviews <- read_csv(
  "data-raw/SAFI_clean.csv", 
  na = "NULL"
)
#select columns
select(interviews, village, no_membrs, months_lack_food, memb_assoc)
select(interviews, village:years_liv)

#filter rows based on data
glimpse(filter(interviews, 
       village== "Chirodzo", 
       rooms > 1,
       no_meals > 2))

interviews |> 
  select(-key_ID) |> 
  filter(village == "Chirodzo", 
          rooms > 1, 
          no_meals > 2)

interviews |> 
  select(-key_ID) |> 
  filter(village == "Chirodzo" | village =="Ruaca") #the | (pipe) is "or"

interviews |> 
  select(-key_ID) |> 
  filter(village == "Chirodzo" & rooms > 1 | village =="Ruace" & rooms > 2)

#mutate creates new columns based on existing colums 
interviews |> 
  mutate(people_per_rooms = no_membrs / rooms) |> 
  glimpse()

 #create people per room but only for cases where family is member of an irrigation association (memb_assoc== "yes") and then i added it to the environment
interviews <- interviews |> 
  filter(memb_assoc == "yes") |> 
  mutate(people_per_rooms = no_membrs / rooms)

means_no_memb <- interviews |> 
  group_by(village, memb_assoc) |> 
  summarize(mean_no_membrs = mean(no_membrs), 
            .groups = "drop")

write_csv(x = means_no_memb, file = "data/means_no_memb.csv")













