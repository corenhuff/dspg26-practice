## Tidying data ##
# Coren Huff
# 2026-06-02

#Set up script-------------------------------------------------------
library(tidyverse)

#import data into environment
interviews <- read_csv(file = "data-raw/SAFI_clean.csv",
                       na = "NULL")

# Mean number of members 
# and min number of members 
# per village and member association 
# without NAs in member association 

interviews |> 
  filter(!is.na(memb_assoc)) |> 
  group_by(village, memb_assoc) |> 
  summarize(avg_membrs = mean(no_membrs),
            min_membrs = min(no_membrs), 
            max_membrs = max(no_membrs)) |> 
  ungroup()

#does the same thing
interviews |> 
  filter(!is.na(memb_assoc)) |> 
  summarize(avg_membrs = mean(no_membrs),
            min_membrs = min(no_membrs), 
            max_membrs = max(no_membrs), 
            .by = c(village, memb_assoc)) #grouping within summarize
  
interviews |> 
  filter(!is.na(memb_assoc)) |> 
  group_by(village, memb_assoc) |> 
  summarize(avg_membrs = mean(no_membrs),
            min_membrs = min(no_membrs), 
            max_membrs = max(no_membrs),
            n = n(),  #use this to count the number of obs in each group
            .groups = "drop")

interviews |> 
  count(village, memb_assoc, 
        sort = TRUE) # use sort function within count 

#adding arrange
interviews |> 
  filter(!is.na(memb_assoc)) |> 
  group_by(village, memb_assoc) |> 
  summarize(avg_membrs = mean(no_membrs),
            min_membrs = min(no_membrs), 
            max_membrs = max(no_membrs),
            n = n(),  #use this to count the number of obs in each group
            .groups = "drop") |> 
  arrange(desc(avg_membrs))

## More practice
#filter_out() filters out anything that is true
interviews |> 
  filter_out(is.na(memb_assoc)) |> 
  mutate(per_room = no_membrs/rooms) |> 
  summarize(mean_per_room = mean(per_room), 
            min_rooms = min(rooms), 
            max_rooms = max(rooms), 
            households = n(), 
            .by = c(village, memb_assoc)) |> 
  arrange(desc(households))

## Tidy data---------------------------------------------------------

# we're going to make our dataframe wider looking at the items_owned and months_lacked_food

interviews_items_owned <- interviews |> 
  separate_longer_delim(items_owned, delim = ";") |> 
  replace_na(list(items_owned = "no listed items")) |> 
  mutate(items_logical = TRUE) |> 
  group_by(key_ID) |> 
  mutate(number_items = if_else(
    items_owned == "no listed items",
    true = 0, 
    false = n()
  )) |> 
  pivot_wider(names_from = items_owned, 
              values_from = items_logical,
              values_fill = list(items_logical = FALSE))

interviews_plotting <- interviews_items_owned |> 
  separate_longer_delim(months_lack_food, delim = ";") |> 
  #make sure it is still grouped by key_ID
  group_by(key_ID) |> 
  mutate(months_logical = TRUE,
         number_months_lack_food = if_else(
           condition = months_lack_food == "none",
           true = 0, 
           false = n()
         )) |> 
  pivot_wider(names_from = months_lack_food, 
              values_from = months_logical, 
              values_fill = list(months_logical = FALSE))


# Save the data -----------------------------------------------------
#write_csv(what you want to save, "where you want to save/name.csv")
write_csv(interviews_plotting, 
          "data/interviews-plotting.csv")


















  

















