library(dplyr)
library(stringr)

data(mtcars)
head(mtcars)

#create a column converting to kilometers per liter
mtcars <- mtcars %>% 
  mutate(
    kpl = mpg*1.60934/3.78541,
    brand = rownames(mtcars)
  )


#show only cars with manual transmission
mtcars %>% filter(am == 1)


#show only cars with manual transmission and with 10 carburators
mtcars %>% filter( am == 1 & carb == 10)

# sort data by displacement

mtcars %>% 
  arrange(
    desc(disp),
    desc(gear)
  )

# average mpg for mazda
mtcars %>%
  mutate(
    brand = rownames(mtcars),
    #flag_mazda = if_else(brand == "Mazda RX4" | brand == "Mazda RX4 Wag",1,0)
    flag_mazda = if_else(str_detect(brand,"Mazda.*"),1,0)
  ) %>% 
  group_by(flag_mazda) %>% 
  filter(
    flag_mazda == 1
  ) %>% 
  summarize(
    mean_mpg = mean(mpg)
  )

#what is the car with the highest weight

mtcars %>% 
  mutate(
    brand = rownames(mtcars),
  ) %>% 
  arrange(
    desc(wt)
  ) %>% 
  head(1) %>% 
  pull(brand)