library(tidyverse)
library(readr)
library(data.table)
library(zoo)
library(gdata)

#Oppgave 1

lower_trop <- fread("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")

lower_trop <- lower_trop %>% 
  select(Year, Mo, Globe)

lower_trop$Year <- as.numeric(lower_trop$Year)

lower_trop$Mo <- as.numeric(lower_trop$Mo)

lower_trop$Globe <- as.numeric(lower_trop$Globe)

lower_trop <- na.omit(lower_trop)

lower_trop$YearMo <- paste(lower_trop$Year, lower_trop$Mo, sep = "-")

lower_trop$YearMo <- as.yearmon(lower_trop$YearMo)

ggplot(lower_trop, aes(x = YearMo, y = Globe)) + 
  geom_point(col="blue") +
  geom_line(col="blue", group = 1) +
  geom_line(col = "red", aes(y=rollmean(lower_trop$Globe, 13, na.pad = TRUE))) +
  labs(x = "?r og m?ned",
       y = "Temperatur",
       title = "Temperatur i nedre troposf?re") + 
  theme_bw()


#Oppgave 2

low_trop <- fread("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")
low_trop <- low_trop %>% select(Year, Mo, NoPol)

mid_trop <- fread("http://vortex.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt")
mid_trop <- mid_trop %>% select(NoPol)

tropo <- fread("http://vortex.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt") 
tropo <- tropo %>% select(NoPol)  

low_strat <- fread("http://vortex.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt")
low_strat <- low_strat %>% select(NoPol)

low_trop <- rename.vars(low_trop, from = "NoPol", "NoPol1")
low_trop$NoPol1 <- as.numeric(low_trop$NoPol1)
low_trop <- head(low_trop, -1)
low_trop$YearMo <- paste(low_trop$Year, low_trop$Mo, sep = "-")
low_trop$YearMo <- as.yearmon(low_trop$YearMo)

mid_trop <- rename.vars(mid_trop, from = "NoPol", "NoPol2")
mid_trop$NoPol2 <- as.numeric(mid_trop$NoPol2)
mid_trop <- head(mid_trop, -1)

tropo <- rename.vars(tropo, from = "NoPol", "NoPol3")
tropo$NoPol3 <- as.numeric(tropo$NoPol3)
tropo <- head(tropo, -1)

low_strat <- rename.vars(low_strat, from = "NoPol", "NoPol4")
low_strat$NoPol4 <- as.numeric(low_strat$NoPol4)


AllNoPol <- cbind(low_trop, mid_trop, tropo, low_strat)

AllNoPol %>% 
ggplot(aes(x = YearMo)) + 
  geom_point(col="blue", aes(y = NoPol1)) +
  geom_point(col="red", aes(y = NoPol2)) +
  geom_point(col="green", aes(y = NoPol3)) +
  geom_point(col="purple", aes(y = NoPol4)) +
  geom_line(col = "black", size = 1, aes(y=rollmean(AllNoPol$NoPol1+NoPol2+NoPol3+NoPol4, 13, na.pad = TRUE))) +
  labs(x = "?r og m?ned",
       y = "Temperatur",
       title = "Temperatur fra 60 til 90 grader nord") +
  theme_bw()
