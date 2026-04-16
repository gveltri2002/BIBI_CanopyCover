# === === === === === === === === === === === === === === ===  
# Created by Gabe Veltri 4/12/2026
# Project: CanopyCover
# Goal: Gathering mean and SD values for shade cover at ISP sites, additonally create visualizations at the end
# === === === === === === === === === === === === === === === 

#### Prep Work ####

# Load Packages
library(tidyverse)
library(readxl)
library(here)

# Import Data
df <- read_excel("data/ISP_canopy_cover_for_Gabe.xlsx",
              sheet = "data")

#### Basic Stats ####

## Get Mean and SD for Shade at ISP Sites => ALL, LB, RB, Center 

# Mean
mean <- df %>% 
  group_by(ISP_COMID) %>% 
  summarise(All = mean(c(Left_bank, Center_US, Center_DS, Center_RB, Center_LB, Right_bank)),
            LB = mean(Left_bank),
            Center = mean(c(Center_US, Center_DS, Center_RB, Center_LB)),
            RB = mean(Right_bank))

# Standard Deviation
sd <- df %>% 
  group_by(ISP_COMID) %>% 
  summarise(All = sd(c(Left_bank, Center_US, Center_DS, Center_RB, Center_LB, Right_bank)),
            LB = sd(Left_bank),
            Center = sd(c(Center_US, Center_DS, Center_RB, Center_LB)),
            RB = sd(Right_bank))

## Tables
# Mean
long_mean <- mean %>% 
  pivot_longer(2:5,
               names_to = "Location",
               values_to = "Mean")
# Standard Deviation
long_sd <- sd %>% 
  pivot_longer(2:5,
               names_to = "Location",
               values_to = "SD")

# Combined
long_both <- right_join(long_mean,long_sd)
long_both <- long_both %>% 
  rename(Canopy_Mean = Mean,
         Canopy_SD = SD)

write.csv(long_both,"Data/canopy_avg.csv", row.names = FALSE)

#### Visualization ####
# Each site shown together
ggplot(long_both, aes(x = Location, y = Canopy_Mean, fill = Location)) + 
  geom_bar(position = position_dodge(), stat ="identity",
           colour='black') +
  facet_wrap(~ISP_COMID) +
  geom_errorbar(aes(ymin = Canopy_Mean - Canopy_SD, ymax = Canopy_Mean + Canopy_SD), width=.2)


# Each metric shown together => shows average canopy cover at each site grouped by the different metrics (ALL, LB, RB, Center)
ggplot(long_both, aes(x = ISP_COMID, y = Canopy_Mean, fill = Location)) + 
  geom_bar(position = position_dodge(), stat ="identity",
           colour='black') +
  facet_wrap(~Location) +
  geom_errorbar(aes(ymin = Canopy_Mean - Canopy_SD, ymax = Canopy_Mean + Canopy_SD), width=.2) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

