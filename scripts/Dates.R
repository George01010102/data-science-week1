library(lubridate)
# library(tidyverse)
date("2017-10-11T14:02:00")

dmy("11 October 2020")

mdy("10/11/2020")

df <- tibble(
  date = c("X2020.01.22",
           "X2020.01.22",
           "X2020.01.22",
           "X2020.01.22")
)

df |> 
  mutate(
    date = as_date(date)
  )

df |> 
  mutate(
    date = as_date(date, format = "X%Y.%m.%d")
  )

year("2017-11-28T14:02:00")

month("2017-11-28T14:02:00")

week("2017-11-28T14:02:00")

day("2017-11-28T14:02:00")

library(janitor)

excel_numeric_to_date(42370)

penguins_clean_names <- penguins_clean_names |>
  mutate(date_egg = lubridate::dmy(date_egg))
