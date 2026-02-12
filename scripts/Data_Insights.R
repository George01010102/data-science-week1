penguins <- readRDS(url("https://UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))
glimpse(penguins)
str(penguins)
library(skimr)
skim(penguins)
library(dplyr)
library(janitor)
#filtering
penguins |>
  filter(species == "Adelie") |>
  count()

#grouping
penguins |>
  group_by(species) |>
  count()

#frequency count by subgroup (number)
penguins |>
  group_by(species,sex) |>
  count() |>
  arrange(desc(n))

#frequency count by subgroup (%)
penguins |>
  tabyl(sex, species) |>
  adorn_percentages("all") |>
  adorn_totals(c("row", "col")) |>
  adorn_pct_formatting(digits = 1)

#Visualizing frequencies geom_col
library(ggplot2)
penguins |> 
  group_by(species,sex) |> 
  count() |> 
  arrange(desc(n)) |> 
  ggplot(aes(x = species,
             y = n,
             fill = sex))+
  geom_col(position=position_dodge2(preserve="single"))+
  geom_label(aes(label = n),
             position=position_dodge2(preserve="single",
                                      width = .9))+ # <- doges text and label bars
  coord_flip()+
  labs(x = "")+
  theme(legend.position = "bottom")

#visualizing frequencies geom_bar
penguins |> 
  ggplot(aes(x = species,
             fill = sex))+
  geom_bar(position=position_dodge2(preserve="single"))+
  coord_flip()+
  labs(x = "")+
  theme(legend.position = "bottom")

install.packages("colorspace")
library(colorspace)
#scatterplots
penguins_flagged|>
  ggplot(aes(x = culmen_length_mm,
             y = culmen_depth_mm,
             colour = species)) +
  geom_point(alpha = 0.7)+
  scale_colour_discrete_qualitative()

#correlation
penguins_flagged |>
  summarise(
    r = cor(culmen_length_mm,
            culmen_depth_mm,
            use = "complete.obs") # Important to include if there are any missing values
  )

#correlation sub grouping
penguins_flagged |>
  group_by(species) |> 
  summarise(
    r = cor(culmen_length_mm,
            culmen_depth_mm,
            use = "complete.obs") # Important to include if there are any missing values
  )


library(tidyverse)
#summary statistics
penguins_flagged |>
  group_by(species, sex) |> # Calculate withing groups
  drop_na(sex) |> #removes rows when sex is unknown
  summarise(
    mean_mass = mean(body_mass_g, na.rm = TRUE),
    sd_mass = sd(body_mass_g, na.rm = TRUE),
    n = n()
  )


#summaries multiple variables, summarise at
penguins_flagged |> 
  group_by(species) |> 
  summarise_at(c("flipper_length_mm",
                 "culmen_length_mm",
                 "culmen_depth_mm"),
               mean, na.rm =T) # mean function



#summaries multiple variables, summarise if
penguins_flagged |> 
  group_by(species) |> 
  summarise_if(is.numeric, # selects only numeric columns
               mean, na.rm =T)


#Visualizing distributions
#Boxplots for group comparisons
penguins_flagged |>
  ggplot(aes(x = species,
             y = body_mass_g)) +
  geom_boxplot() +
  coord_flip()

#Histogram for body mass shape distribution
penguins_flagged |> 
  ggplot(aes(body_mass_g,
             fill = species))+
  geom_histogram()+
  scale_fill_discrete_qualitative()+
  facet_wrap(~species, # make facets by species
             ncol = 1) # stack the plots for easier comparison


#ggally
install.packages("GGally")
library(GGally)
penguins_flagged |> 
  ggpairs(columns = 10:12, ggplot2::aes(colour = species))
