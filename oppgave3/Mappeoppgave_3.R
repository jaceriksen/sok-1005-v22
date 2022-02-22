library(rvest)
library(tidyverse)

#Oppgave 1

df <- read_html("https://www.motor.no/aktuelt/motors-store-vintertest-av-rekkevidde-pa-elbiler/217132")

df <- df %>% html_table(header = TRUE)

df <- df[[1]]

df <- df %>% 
  select(-"Avvik") %>% 
  rename(modell = `Modell (temp. varierte fra 0° til -10°)`,
         wltp = `WLTP-tall`,
         stopp = STOPP) %>% 
  na_if("x") %>% 
  na.omit()


df$wltp <- substr(df$wltp, 0, 3) %>% 
  as.numeric(df$wltp)
df$stopp <- substr(df$stopp, 0, 3) %>% 
  as.numeric(df$stopp)


df %>% 
  ggplot() + aes(x = wltp, y = stopp) +
  geom_point() +
  geom_abline(color = "orange") +
  labs(title = "Motors test av elbilers rekkevidde mot WLTP", 
       x = "WLTP-rekkevidde (km)",
       y = "Rekkevidde i Motors test (km)") +
  xlim(200, 650) + 
  ylim(200, 600)

# På figuren kan man se at alle bilene har lavere rekkevidde i Motors rekkeviddetest
# enn det som er oppgitt fra WLTP-testing.


#Oppgave 2

lm(stopp ~ wltp, data = df)

# Det første tallet er hvor regresjonslinjen krysser x-aksen.
# Det andre tallet er stigningstallet på regresjonslinjen.

df %>% 
  ggplot() + aes(x = wltp, y = stopp) +
  geom_point() +
  geom_abline(color = "orange") +
  geom_smooth(method = lm) +
  labs(title = "Motors test av elbilers rekkevidde mot WLTP", 
       x = "WLTP-rekkevidde (km)",
       y = "Rekkevidde i Motors test (km)") +
  xlim(200, 650) + 
  ylim(200, 600)


# Brukte kode fra: "https://stackoverflow.com/questions/21675379/r-only-keep-the-3-x-first-characters-in-a-all-rows-in-a-column"
# Samarbeidet med: Fridtjof Mortensen, Arne Nordkvelle og Markus Mollatt