# Inputs: 
# Continent_Portions.text 
# Continent_Participation.text

# Outputs: 
# Sectors_Participation_1950.png
# Sectors_Participation_1966.png
# Sectors_Participation_1982.png
# Sectors_Participation_1997.png 
# Sectors_Participation_2013.png 
# Continents_Participation.png
# Continents_Ranking.png

library(tidyverse)
library(readr)

tidy_Continent_Portions <- dget("Continent_Portions.text") %>% 
  set_names(c("year", "Total", "continent", "Gas", "Liquid", "Solid", "Cement", "Flaring")) %>% 
  gather(Gas, Liquid, Solid, Cement, Flaring, key = "sectors", value = "percentage")

sectors_colour <- c("#334fff", "#33ff36", "#e82913", "#12dac5", "#fcf503")


filter(tidy_Continent_Portions, year == 1950) %>% 
  ggplot(aes(x = sectors, y = percentage)) + 
  scale_fill_manual(values = sectors_colour) +
  geom_bar(stat="identity",aes(fill = sectors)) + 
  facet_wrap(~ continent) + xlab("Sectors") + ylab("Percentage") +
  ggtitle("Participation of Each Sectror\n (Year = 1950)") + 
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Sectors_Participation_1950.png")

filter(tidy_Continent_Portions, year == 1966) %>% 
  ggplot(aes(x = sectors, y = percentage)) + 
  scale_fill_manual(values = sectors_colour) +
  geom_bar(stat="identity",aes(fill = sectors)) + 
  facet_wrap(~ continent) + xlab("Sectors") + ylab("Percentage") +
  ggtitle("Participation of Each Sectror\n (Year = 1966)") + 
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Sectors_Participation_1966.png")

filter(tidy_Continent_Portions, year == 1982) %>% 
  ggplot(aes(x = sectors, y = percentage)) + 
  scale_fill_manual(values = sectors_colour) +
  geom_bar(stat="identity",aes(fill = sectors)) + 
  facet_wrap(~ continent) + xlab("Sectors") + ylab("Percentage") +
  ggtitle("Participation of Each Sectror\n (Year = 1982)") + 
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Sectors_Participation_1982.png")

filter(tidy_Continent_Portions, year == 1997) %>% 
  ggplot(aes(x = sectors, y = percentage)) + 
  scale_fill_manual(values = sectors_colour) +
  geom_bar(stat="identity",aes(fill = sectors)) + 
  facet_wrap(~ continent) + xlab("Sectors") + ylab("Percentage") +
  ggtitle("Participation of Each Sectror\n (Year = 1997)") + 
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Sectors_Participation_1997.png")


filter(tidy_Continent_Portions, year == 2013) %>% 
  ggplot(aes(x = sectors, y = percentage)) + 
  scale_fill_manual(values = sectors_colour) +
  geom_bar(stat="identity",aes(fill = sectors)) + 
  facet_wrap(~ continent) + xlab("Sectors") + ylab("Percentage") +
  ggtitle("Participation of Each Sectror\n (Year = 2013)") + 
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Sectors_Participation_2013.png")

continent_colours <- c("#27da12","#175cde","#ebef09","#d00ee7","#ec160b")

dget("Continent_Participation.text") %>% 
  filter(year %in% c(1950, 1966, 1982, 1997, 2013)) %>% 
  ggplot(aes(x = continent, y = Participation)) +
  scale_fill_manual(values = continent_colours)+
  geom_bar(stat="identity",aes(fill = continent)) +
  facet_wrap(~year) +
  xlab("Continents") + ylab("Participation Percentag") +
  ggtitle("Continents' Participation\n in Different Years")+
  theme(panel.grid.major = element_line(colour = "black",
                                        linetype = "dotdash"),
        panel.background = element_rect(fill = "gray98")) +
  ggsave("Continents_Participation.png")


dget("Continent_Participation.text") %>%
  group_by(continent) %>% 
  summarize(mean_participation = mean(Participation)) %>% 
  ggplot(aes(x = continent, y = mean_participation)) +
  geom_point() + xlab("Continents") + ylab("Participation Average (%)") +
  ggtitle("Ranking Continents\n In Participation") + ggsave("Continents_Ranking.png")

rm(tidy_Continent_Portions, sectors_colour, continet_colours)
