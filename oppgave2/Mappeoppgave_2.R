library(tidyverse)
library(rjson)
library(jsonlite)

#Oppgave 1

covid_df <- fromJSON("https://static01.nyt.com/newsgraphics/2021/12/20/us-coronavirus-deaths-2021/ff0adde21623e111d8ce103fedecf7ffc7906264/scatter.json")

covid_df %>%
  ggplot(aes(x=fully_vaccinated_pct_of_pop, y=deaths_per_100k, label = name)) +
  geom_point(col="darkseagreen2") +
  geom_text(hjust=0.5, vjust=-0.6, size = 2) +
  scale_x_continuous(labels = scales::percent) +
  labs(title="Covid-19 deaths compared with vaccination rates",
       x ="Share of total population fully vaccinated",
       y = "Avg. monthly deaths per 100,000") +
  theme_bw()


#Oppgave 2
summary(covid_df)

lm(deaths_per_100k ~ fully_vaccinated_pct_of_pop, data = covid_df)

# Den første verdien, "Intercept", viser hvor den lineære regresjonsmodellen krysser y-aksen.
# Dvs. at hvis 0% av befolkningen er vaksinert, vil 31.15 personer per 100,000 innbyggere dø.

# Den neste verdien viser stigningstallet til regresjonsmodellen.
# Altså hvor mye y øker når x økes med 1.
# Siden x-aksen er i prosent er det hvor mye 

covid_df %>%
  ggplot(aes(x=fully_vaccinated_pct_of_pop, y=deaths_per_100k, label = name)) +
  geom_point(col="darkseagreen2") +
  geom_text(hjust=0.5, vjust=-0.6, size = 2) +
  geom_smooth(method = lm) +
  scale_x_continuous(labels = scales::percent) +
  labs(title="Covid-19 deaths compared with vaccination rates",
       x ="Share of total population fully vaccinated",
       y = "Avg monthly deaths per 100,000") +
  theme_bw() 


