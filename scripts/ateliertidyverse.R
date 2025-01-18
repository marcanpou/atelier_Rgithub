#### tidyverse

surveys <- read_csv("data/data/surveys_complete_77_89.csv")

str(surveys)
head(surveys)
#select - colonnes
#filter - lignes
#mutate créer colonnes

##### select
select(surveys, plot_id, species_id)

#peut selectionner une seule ligne et colonne
select(surveys, c(3,4))

#peut enlever une colonne
select(surveys, -plot_id)

select(surveys, where(is.numeric))

select(surveys, where(anyNA))

##### filter

filter(surveys, year == 1988)

filter(surveys, species_id %in% c('RM', 'DO'))

#peut combiener les deux
filter(surveys, year == 1988 & species_id %in% c('RM', 'DO'))

#year, month, species_id, plot_id

surveys_filtered =  surveys %>% filter(year == 1980:1985) %>% 
  select(year, month, species_id, plot_id)
surveys_two =  surveys %>% filter(year == 1988) %>% 
  select(record_id, month, species_id, plot_id)
summary(surveys_two)
summary(surveys_filtered)


##### mutate

surveys %>% filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000, 
        weight_lbs = weight_kg *2.2) %>% 
  relocate(weight_kg, .after = record_id) %>% 
  relocate(weight_lbs, .after = weight_kg)

surveys %>% 
  mutate(date = paste(year, month, day, sep = '-')) %>% 
  relocate(date, .after = year)

#use lubridate to efficiently work with dates
library('lubridate')
surveys %>% 
  mutate(date = ymd(paste(year, month, day, sep = '-'))) %>% 
  relocate(date, .after = year)
#use the function ymd to make 

surveys %>% group_by(sex) %>% 
  summarize(mean.weight = mean(weight, na.rm = TRUE), count = n())

#dataframe, compte nombre d'animaux par jjour, progression du nombre d'animal par jour

surveyz = surveys %>% select(year, month,day, sex) %>% 
  mutate(date = ymd(paste(year, month, day, sep = '-'))) %>% 
  relocate(date, .after = year)
surveyz

surveyz = surveyz %>%  group_by(sex, date) %>% summarize(count = n())
surveyz
?ggplot()
ggplot(data = surveyz, mapping = aes(x = date, y = count, colour = sex))+
  geom_line()
