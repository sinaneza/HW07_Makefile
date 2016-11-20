# Inputs:
#   Continent_Emission.text
#   Carbon_Emission.text
# 
# Outputs:
#   Continent_Portions.text
#   Continent_Participation.text
#   Emission_vs_Pop.text
#   country_whole_data.text

library(readr)
library(tidyverse)

#portion of each sector
Continent_Portions <- dget("Continent_Emission.text") %>% 
  mutate(Gas_Percent = (Gas/Total)*100,
    Liquid_Percent = (Liquid/Total)*100,
    Solid_Percent = (Solid/Total)*100,
    Cement_Percent = (Cement/Total)*100,
    Flaring_Percent = (Flaring/Total)*100) %>% 
  dplyr::select(-Gas, -Liquid, -Solid, -Cement, -Flaring)

#computing total carbon emission for each year:
(total_sum_diffy <- dget("Continent_Emission.text") %>%
  group_by(year) %>% 
  summarize(Sum = sum(Total)))

#computing continent's participation in carbon emission in each year:

library(forcats)

Continent_Participation <- inner_join(Continent_Portions,
           total_sum_diffy) %>% 
  mutate(Participation = (Total/Sum)*100,
         continent = fct_reorder(continent, Participation,fun =mean, .desc=TRUE)) %>% 
  dplyr::select(continent, year, Participation)

#computing linear and quadratic models for relationship of
#total carbon emission against population

##This function computes polynomial function fitting relation of 'y' against 'x'
##'n' defines degree of polynomial

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

#This function computes sum of squares:
normal <- function(x) {
  if(!is.numeric(x)) {
    stop('This function only works for numeric input!\n',
         'You have provided an object of class: ', class(x)[1])
  }
  sqrt(sum(x^2))
}

#functions for linear modelling applicabale to a dataframe (with one input)
LM_df <- function(df) LM(df$popPermillion, df$total_emission)

#I have filtered data to years after 1980 since population data was not available for some countries
#befor that time; Moreover I have eliminated chod, somalia and some other countries from modelling since only after 1998 do we have access
#to its population
ndf <- dget("Carbon_Emission.text") %>%
  filter(year>1980, country != "chad") %>% 
  filter(country!="democratic republic of the congo (formerly zaire)") %>% 
  filter(country!="ethiopia") %>% 
  filter(country!="somalia") %>%
  filter(country!="kuwaiti oil fires")

library(broom)

#use nested data to find model coefficients
nested_df <- ndf %>% 
  group_by(country) %>%
  nest() %>% 
  mutate(Lin_Fit = map(data,LM_df),
         Lin_Fit_tidy = map(Lin_Fit, tidy),
         Resid_Lin_Fit = map(Lin_Fit, resid),
         Resid_Lin_Fit_normal = map_dbl(Resid_Lin_Fit, normal))
#use tidy and unnest to transmute list to dataframe and extract it.

Emission_vs_Pop <- nested_df %>%
  dplyr::select(country, Lin_Fit_tidy, Resid_Lin_Fit_normal, data, Resid_Lin_Fit) %>% 
  unnest(Lin_Fit_tidy) %>%
  select(country:estimate) %>% 
  spread(key = term, value = estimate) %>% 
  rename(intercept = `(Intercept)`,slope = `poly(x, n)`)


country_whole_data <- nested_df %>% 
  dplyr::select(country, data, Resid_Lin_Fit) %>%
  unnest(Resid_Lin_Fit, data) %>% 
  inner_join(Emission_vs_Pop) %>% 
  mutate(predict = (slope*popPermillion) + intercept)




dput(Continent_Portions, "Continent_Portions.text")
dput(Continent_Participation, "Continent_Participation.text")
dput(Emission_vs_Pop, "Emission_vs_Pop.text")
dput(country_whole_data, "country_whole_data.text")

rm(Continent_Portions, Continent_Participation,
   Emission_vs_Pop, country_whole_data,
   ndf, nested_df, total_sum_diffy)


