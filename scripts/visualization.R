# Coren Huff
# 2026-06-02
# Visualization with ggplot2


# Set up script -----------------------------------------------------------

library(tidyverse)

interviews_plotting <- read_csv("data/interviews-plotting.csv")

#structure of ggplot2
interviews_plotting |> 
  ggplot(mapping = aes(x = no_membrs, y = number_items)) +
  geom_point(alpha = 0.5)

#using a different geom 
interviews_plotting |> 
  ggplot(mapping = aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.7, 
              width = 0.2, 
              height = 0.2)

#mapping v setting

#setting color
interviews_plotting |> 
  ggplot(mapping = aes(x = no_membrs, y = number_items)) +
  geom_jitter(alpha = 0.7, 
              width = 0.2, 
              height = 0.2, 
              color = "tomato", 
              shape = 18)
  
#mapping color to the data
interviews_plotting |> 
  filter_out(is.na(memb_assoc)) |> 
  ggplot(mapping = aes(x = no_membrs, y = number_items,
                       color = village, 
                       shape = memb_assoc)) +
  geom_jitter(alpha = 0.7, 
              width = 0.2, 
              height = 0.2, 
              )

interviews_plotting |> 
  filter_out(is.na(memb_assoc)) |> 
  ggplot(mapping = aes(x = no_membrs, y = number_items)) +
  geom_jitter(aes(color = village, 
                  shape = memb_assoc), 
              alpha = 0.7, 
              width = 0.2, 
              height = 0.2) +
  scale_color_viridis_d(option = "mako")


interviews_plotting |> 
  ggplot(aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot()

#investigate the plot 
interviews_plotting |> 
  count(respondent_wall_type)

interviews_plotting |> 
  filter(respondent_wall_type != 'cement') |> 
  ggplot(aes(x = respondent_wall_type, y = rooms)) + 
  geom_boxplot(outliers = FALSE) +
  geom_jitter(aes(color = village),
              width = 0.2, 
              height = 0)


interviews_plotting |> 
  ggplot(aes(y = fct_infreq(respondent_wall_type))) +  #can plot on x to make vertical
  geom_bar(aes(fill = village)) +
  labs(y = "Wall Type",
       x = NULL,
       fill = "Village") +
  theme_classic()

ggsave("fig/wall-type.png", height = 8, width = 5)








