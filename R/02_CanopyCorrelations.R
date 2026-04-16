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
