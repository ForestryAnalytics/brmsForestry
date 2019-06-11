read_csv(https://s3.amazonaws.com/silviaterra-biometrics-public/arrowhead-height-data.csv).

After reading in the data, we’ll drop any species with fewer than 25 unique height observations. This leaves us with a dataset containing 12 species to work with.


library(tidyverse)
library(brms)
library(gganimate)
library(tidybayes)

myData <- read_csv(https://s3.amazonaws.com/silviaterra-biometrics-public/arrowhead-height-data.csv)

myData %>%
  group_by(common) %>%
  nest() %>%
  mutate(n = map_dbl(data, n_distinct)) %>%
  filter(n >= 25) %>%
  select(common, data) %>%
  unnest()

ggplot(myData, aes(x = diameter, y = height)) +
  geom_point(col = 'dark green', alpha = 0.5) +
  xlab("diameter (inches)") +
  ylab("height (feet)") +
  facet_wrap(~common) +
  theme_bw()
