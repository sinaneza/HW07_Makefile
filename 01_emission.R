
library(tidyverse)
library(readr)
library(stringr)
library(forcats)



#download.file("http://cdiac.ornl.gov/ftp/ndp030/CSV-FILES/nation.1751_2013.csv", destfile = "emission_raw.csv", quiet = TRUE)

Carbon_Emission_Raw <- read_csv("emission_raw.csv")

Regional_CO2_Africa_Raw <- read_csv("Regional_CO2_Africa_Raw.csv")
Regional_CO2_Americas_Raw <- read_csv("Regional_CO2_Americas_Raw.csv")
Regional_CO2_Asia_Raw <- read_csv("Regional_CO2_Asia_Raw.csv")
Regional_CO2_Europe_Raw <- read_csv("Regional_CO2_Europe_Raw.csv")
Regional_CO2_Oceania_Raw <- read_csv("Regional_CO2_Oceania_Raw.csv")

names(Carbon_Emission_Raw) <- c("country",
               "year",
               "total_emission",
               "solid_fuel_emission",
               "liquid_fuel_emission",
               "gas_fuel_emission",
               "cement_prod_emission",
               "gas_flaring_emission",
               "EmissionPerCap",
               "bunker_fuel_emission")


lower_case_country <- tolower(Carbon_Emission_Raw$country) 
Carbon_Emission <- Carbon_Emission_Raw %>% 
  mutate(country = lower_case_country) %>% 
  mutate(country = factor(country),
         country = fct_reorder(country, total_emission, .desc = TRUE),
         total_emission = as.double(total_emission),
         solid_fuel_emission = as.double(solid_fuel_emission),
         liquid_fuel_emission = as.double(liquid_fuel_emission),
         gas_fuel_emission = as.double(gas_fuel_emission),
         gas_flaring_emission = as.double(gas_flaring_emission),
         EmissionPerCap = as.double(EmissionPerCap),
         bunker_fuel_emission = as.double(bunker_fuel_emission),
         popPermillion = (total_emission/EmissionPerCap)/1000)


#saved as text file to have my reordered factors
dput(Carbon_Emission, "Carbon_Emission.text")
rm(Carbon_Emission)
Carbon_Emission <- dget("Carbon_Emission.text")
levels(Carbon_Emission$country)

#working on Africa's data
Africa_Emission <- Regional_CO2_Africa_Raw %>% 
  mutate(Total = as.double(Total),
         Gas = as.double(Gas),
         Liquid = as.double(Liquid),
         Solid = as.double(Solid),
         Cement = as.double(Cement),
         Flaring = as.double(Flaring)) %>% 
  rename(year = Year)





Americas_Emission <- Regional_CO2_Americas_Raw %>% 
  mutate(Total = as.double(Total),
         Gas = as.double(Gas),
         Liquid = as.double(Liquid),
         Solid = as.double(Solid),
         Cement = as.double(Cement),
         Flaring = as.double(Flaring)) %>% 
  rename(year = Year)





Asia_Emission <- Regional_CO2_Asia_Raw %>% 
  mutate(Total = as.double(Total),
         Gas = as.double(Gas),
         Liquid = as.double(Liquid),
         Solid = as.double(Solid),
         Cement = as.double(Cement),
         Flaring = as.double(Flaring)) %>% 
  rename(year = Year)




Europe_Emission <- Regional_CO2_Europe_Raw %>% 
  mutate(Total = as.double(Total),
         Gas = as.double(Gas),
         Liquid = as.double(Liquid),
         Solid = as.double(Solid),
         Cement = as.double(Cement),
         Flaring = as.double(Flaring)) %>% 
  rename(year = Year)




Oceania_Emission <- Regional_CO2_Oceania_Raw %>% 
  mutate(Total = as.double(Total),
         Gas = as.double(Gas),
         Liquid = as.double(Liquid),
         Solid = as.double(Solid),
         Cement = as.double(Cement),
         Flaring = as.double(Flaring)) %>% 
  rename(year = Year)



Af <- Africa_Emission %>% 
  mutate(continent = rep("Africa",
                         length(Africa_Emission$year)))
Am <- Americas_Emission %>% 
  mutate(continent = rep("Americas",
                         length(Americas_Emission$year)))
As <- Asia_Emission %>% 
  mutate(continent = rep("Asia",
                         length(Asia_Emission$year)))
Eu <- Europe_Emission %>% 
  mutate(continent = rep("Europe",
                         length(Europe_Emission$year)))
Oc <- Oceania_Emission %>% 
  mutate(continent = rep("Oceania",
                         length(Europe_Emission$year)))

Continent_Emission <- rbind(Af,Am,As,Eu,Oc) %>% 
  mutate(continent = factor(continent)) %>% 
  mutate(continent = fct_reorder(continent,Total,.desc = TRUE))
levels(Continent_Emission$continent)

dput(Continent_Emission, "Continent_Emission.text")
rm(Continent_Emission)
Continent_Emission <- dget("Continent_Emission.text")
levels(Continent_Emission$continent)


rm(Af, Am, As, Eu, Oc,
   Africa_Emission,
   Americas_Emission,
   Asia_Emission,
   Europe_Emission,
   Oceania_Emission,
   Regional_CO2_Africa_Raw,
   Regional_CO2_Americas_Raw,
   Regional_CO2_Asia_Raw,
   Regional_CO2_Europe_Raw,
   Regional_CO2_Oceania_Raw,
   Carbon_Emission_Raw)
