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

#### Visualizations ####

## Wetted Width


  