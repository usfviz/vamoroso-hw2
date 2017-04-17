library(tidyr)
library(dplyr)
library(ggplot2)
df1 <- read.csv("fertility.csv") %>%
  dplyr::select(Country.Name,X1960:X2014)

data_long2 <- df1 %>%
  gather(year, fertility,X1960:X2014)

df2 <- read.csv("life_expectancy.csv") %>%
  dplyr::select(Country.Name,X1960:X2016)

data_long <- df2 %>%
  gather(year, life_ex,X1960:X2016)

full <- dplyr::full_join(data_long,data_long2,by=c("Country.Name","year"))
