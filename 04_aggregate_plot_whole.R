#input: 
# Continent_Emission.text 
# country_whole_data.text
#output: 
# emission_sectors_vs_years.png
# Linear_Fitting.png
#Jpn_Linear_Fitting.png

library(tidyverse)

sectors_colour <- c("#33ff36", "#334fff", "#e82913", "#12dac5", "#fcf503")

#plotting emission of each sector
dget("Continent_Emission.text") %>% 
  group_by(year) %>% 
  summarize(Total = sum(Total),
            Gas = sum(Gas),
            Liquid = sum(Liquid),
            Solid = sum(Solid),
            Cement = sum(Cement),
            Flaring = sum(Flaring)) %>% 
  gather(Solid, Liquid, Gas, Cement,Flaring, key = "sectors", value = "emission") %>% 
  ggplot(aes(x = year, y = emission)) +
  scale_colour_manual (values = sectors_colour)+
  geom_line(aes(colour = sectors), size = 0.75) +
  xlab("Year") + ylab("Emission") +
  ggtitle("Emission of Each Sectror") +
  theme(panel.grid.major = element_line(colour = "black", 
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("emission_sectors_vs_years.png")


dget("country_whole_data.text") %>% 
  filter(year == 1990) %>% 
  ggplot(aes(x= popPermillion, y = total_emission)) + geom_point() +
  geom_smooth(method = "lm", se = FALSE, colour = "red") +
  xlab("population*1e6") + ylab("Total Emission") +
  ggtitle("Linear Fitting") + 
  ggsave("Linear_Fitting.png")

dget("country_whole_data.text") %>% 
  filter(country == "japan") %>% 
  ggplot(aes(x= popPermillion, y = total_emission)) + geom_point() +
  geom_line(aes(x = popPermillion, y = predict), colour = "red", size = 0.75) +
  xlab("population*1e6") + ylab("Total Emission") +
  ggtitle("Linear Fitting\n for Japan") + 
  ggsave("Jpn_Linear_Fitting.png")

