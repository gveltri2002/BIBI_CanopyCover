# === === === === === === === === === === === === === === ===  
# Created by Gabe Veltri 4/15/2026
# Project: CanopyCover
# Goal: Looking at correlations between mean/SD values and stream width and basin size
# === === === === === === === === === === === === === === === 

#### Prep Work ####

# Load Packages
library(tidyverse)
library(readxl)
library(here)

# Import Data
df <- read_excel("data/ISP_canopy_cover_for_Gabe.xlsx",
                 sheet = "data")
canopy_avg <- read_csv("data/canopy_avg.csv")

#### Getting Widths Data ####
# Mean
width_mean <- df %>% 
  group_by(ISP_COMID) %>% 
  summarise(Avg_Bankful_width_m = mean(Bankful_width_m),
            Avg_Wetted_width_m = mean(Wetted_width_m))

# Standard Deviation
width_sd <- df %>% 
  group_by(ISP_COMID) %>% 
  summarise(SD_Bankful_width_m = sd(Bankful_width_m),
            SD_Wetted_width_m = sd(Wetted_width_m))

# Combined
width_all <- right_join(width_mean,width_sd)


#### Combining Data ####
merged_df <- merge(canopy_avg, width_all, by = "ISP_COMID", all.x = TRUE)

## Basin Metrics ##
basin <- df %>% 
  select(2:6)

basin_merged <- merge(merged_df, basin, by = "ISP_COMID", all.x = TRUE)

#### Visualizations ####

## Wetted Width vs. Canopy
ggplot(basin_merged, aes(x = Avg_Wetted_width_m, y = Canopy_Mean)) +
  geom_point() +
  facet_wrap(~Location)

# Bankful Width vs. Canopy
ggplot(basin_merged, aes(x = Avg_Bankful_width_m, y = Canopy_Mean)) +
  geom_point() +
  facet_wrap(~Location)

# Basin Size vs. Canopy
ggplot(basin_merged, aes(x = WS_Area_KM2, y = Canopy_Mean)) +
  geom_point() +
  facet_wrap(~Location)

# So far what I am seeing which makes sense:  
##### The banks vary very little => often was very DENSE brush so a 17
##### The center varies the most => wider streams mean less canopy cover

# Exploration
ggplot(basin_merged, aes(x = WS_forest_percent, y = Canopy_Mean)) +
  geom_point() +
  facet_wrap(~Location)

ggplot(basin_merged, aes(x = WS_Area_KM2, y = WS_forest_percent)) +
  geom_point()
  