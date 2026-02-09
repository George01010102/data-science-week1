library(tidyverse)
# check for whole duplicate 
# rows in the data
penguins_clean_names |> 
  filter(duplicated(across(everything())))
sum() 

penguins_demo <- penguins_clean_names |> 
  slice(1:50) |> 
  bind_rows(slice(penguins_clean_names, c(1,5,10,15,30)))

penguins_demo |> 
  filter(duplicated(across(everything())))
sum()

penguins_clean_names |> 
  summarise(
    n = n(),
    n_distinct(individual_id)
  )

