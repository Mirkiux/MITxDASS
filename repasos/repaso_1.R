library(dplyr)
library(stringr) #funciones para texto, para regex

data("mtcars")

### Visualizar la data 

View( head(mtcars) )

### pipe operator(ctrl + chift + m):  izquierda %>% primer argumento de la derecha

mtcars %>% head()

#equivalentes
head(mtcars,10)
mtcars %>% head(10)

#objeto mas importante de R: dataframes
#flavor 1: dataframe de R base --clasico
#flavor 2: dataframe de tidyverse --mas practico
#flavor 3: data.table para datasets muy grandes que necesitan alta performance

#¿como reconocer que tipo de dataframe tenemos?

#dataframe de R base
class(mtcars)

#dataframe de tidyverse (tibble)
mtcars_tidyverse <- tibble(mtcars)
class(mtcars_tidyverse)

#volviendo a crear el tibble pero con los rownames


mtcars_tidyverse <- mtcars %>% 
  mutate(
    modelo = rownames(mtcars)
  ) %>% 
  tibble()


mtcars_tidyverse <- tibble(mutate(mtcars,modelo = rownames(mtcars)))

mtcars_tidyverse <- tibble(
  mutate(
    mtcars,
    modelo = rownames(mtcars)
  )
)

#uso de mutate
mtcars_tidyverse <- mtcars_tidyverse %>% mutate(
  kpl = mpg*1.6/3.8,
  flag_carro_rendidor = if_else(kpl > 10,1,0),
  flag_carro_viejo = if_else(disp > 150, 1, 0),
  marca = str_extract(modelo,"^[a-z|A-Z]+")
  ) 

#agrupciones por marca
## particionar la tabla
mtcars_tidyverse <- mtcars_tidyverse %>% 
  group_by(
    marca
  ) #particiona la tabla


mtcars_tidyverse <- mtcars_tidyverse %>% #ojo: como la tabla ya esta particionada, las funciones de agregacion son por particion
  mutate(
    max_cyl = max(cyl)
  )


## colapsar la tabla

mtcars_sumarizado <-  mtcars_tidyverse %>% 
  group_by(
    marca
  ) %>% 
  summarise(
    min_cyl =min(cyl),
    max_cyl = max(cyl),
    avg_cyl = mean(cyl),
    med_cyl = median(cyl),
    min_kpl = min(kpl),
    max_kpl = max(kpl),
    avg_cyl = mean(kpl),
    med_cyl = median(kpl)
  )







