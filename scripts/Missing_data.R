library(tidyverse)
penguins_clean_names |> 
  group_by(species) |> 
  summarise(mean = mean(body_mass_g))

summary(penguins_clean_names)

library(skimr)
skimr::skim(penguins_clean_names)

library(naniar)
naniar::vis_miss(penguins_clean_names)

naniar::gg_miss_upset(penguins_clean_names)

penguins_clean_names |> 
  filter(if_any(everything(), is.na)) |>
  select(culmen_length_mm, culmen_depth_mm, flipper_length_mm, 
         sex, delta_15_n_o_oo, delta_13_c_o_oo,comments,
         everything()) # reorder columns

penguins_clean_names |> 
  filter(if_any(culmen_length_mm, is.na))  # reorder columns

penguins_clean_names |> 
  group_by(species) |> 
  summarise(
    mean_body_mass = mean(body_mass_g, na.rm = T)
  )
