# charger les packages
library(tidyverse)
library(ratdat)

#Graphique
ggplot(data = complete_old, aes(x = weight, y = hindfoot_length)) +
  geom_point(color = "cyan") +
  geom_abline(colour = "orange")
