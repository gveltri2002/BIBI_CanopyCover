# === === === === === === === === === === === === === === ===  
# Created by Gabe Veltri 4/12/2026
# Project: CanopyCover
# Goal: Initial exploration of canopy cover data for 2025 sampling year
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

