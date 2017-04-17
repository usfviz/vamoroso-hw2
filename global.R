library(tidyr)
library(dplyr)
library(ggplot2)
library(shiny)

valid_names <- read.csv('valid_country_codes.csv', skip=2)[1:236,]

continents <- read.csv('Metadata_Continent.csv') %>% dplyr::select(Country.Code, Region) %>%
  dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

df1 <- read.csv("fertility.csv") %>%
  dplyr::select(Country.Name,Country.Code, X1960:X2014) %>%dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

data_long2 <- df1 %>%
  gather(year, fertility,X1960:X2014)

df2 <- read.csv("life_expectancy.csv") %>%
  dplyr::select(Country.Name,Country.Code, X1960:X2016)%>%dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

df3 <- read.csv("population.csv") %>% dplyr::select(Country.Name, Country.Code, X1960:X2016) %>% dplyr::filter(Country.Code %in% valid_names$ISO.ALPHA.3.code)

data_long <- df2 %>%
  gather(year, life_ex,X1960:X2016)

data_long3 <- df3 %>% gather(year, population, X1960:X2016)

full <- dplyr::full_join(data_long,data_long2,by=c("Country.Code","year")) %>% 
  dplyr::full_join(data_long3, by=c('Country.Code', 'year')) %>%
  dplyr::select(Country.Code:life_ex, fertility:population)

full_c <- dplyr::left_join(full, continents, by='Country.Code')

full_c$year <- gsub("X", '', full_c$year)
full_c$year <- as.numeric(full_c$year)
full_c <- na.omit(full_c)

df_filt <- full_c %>% dplyr::filter(year=='X1960')

#library(countrycode)
#full2$Continent <- countrycode(full2$Country.Code, "wb", "continent")
#full2
