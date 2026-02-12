penguins <- readRDS(url("https://UEABIO/5023B/raw/refs/heads/2026/files/penguins.RDS"))
glimpse(penguins)
str(penguins)
library(skimr)
skim(penguins)

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
  coord_flip()+
  labs(x = "")+
  theme(legend.position = "bottom")
