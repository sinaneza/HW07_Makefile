library(readr)
library(tidyverse)

#portion of each sector
Continent_Portions <- dget("Continent_Emission.text") %>% 
  mutate(Gas_Percent = (Gas/Total)*100,
    Liquid_Percent = (Liquid/Total)*100,
    Solid_Percent = (Solid/Total)*100,
    Cement_Percent = (Cement/Total)*100,
    Flaring_Percent = (Flaring/Total)*100)

#computing total carbon emission for each year:
(total_sum_diffy <- dget("Continent_Emission.text") %>%
  group_by(year) %>% 
  summarize(Sum = sum(Total)))

#computing continent's participation in carbon emission in each year:
Continent_Participation <- inner_join(Continent_Portions,
           total_sum_diffy) %>% 
  mutate(Participation = (Total/Sum)*100) %>% 
  dplyr::select(continent, year, Participation)

##computing linear and quadratic models for relationship of
##total carbon emission against population

#This function computes polynomial function fitting relation of 'y' against 'x'
#'n' defines degree of polynomial

LM <- function(x, y, n=1) {
  if(!is.numeric(x)) {
    stop('This function only works for numeric input!\n',
         'You have provided an object of class: ', class(x)[1])
  }
  if(!is.numeric(y)) {
    stop('This function only works for numeric input!\n',
         'You have provided an object of class: ', class(y)[1])
  }
  if(!is.numeric(n)) {
    stop('This function only works for numeric input!\n',
         'You have provided an object of class: ', class(n)[1])
  }
  lm(y ~ poly(x, n))
}

#functions for linear and quadratic modeling applicabale to a dataframe (with one input)
LM_df <- function(df) LM(df$popPermillion, df$total_emission)
LM_df_sq <- function(df) LM(df$popPermillion, df$total_emission, n = 2)


#I have filtered data to years after 1980 since population data was not available for some countries
#befor that time; Moreover I have eliminated chod, somalia and some other countries from modelling since only after 1998 do we have access
#to its population
ndf <- dget("Carbon_Emission.text") %>%
  filter(year>1980, country != "chad") %>% 
  filter(country!="democratic republic of the congo (formerly zaire)") %>% 
  filter(country!="ethiopia") %>% 
  filter(country!="somalia") %>%
  filter(country!="kuwaiti oil fires")

nested_df <- ndf %>% 
  group_by(country) %>%
  nest() %>% 
  mutate(Lin_Fit = map(data,LM_df),
         Quad_Fit = map(data,LM_df_sq))




dput(Continent_Portions, "Continent_Portions.text")
dput(Continent_Participation, "Continent_Participation.text")
