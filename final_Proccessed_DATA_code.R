library(readr)
library(tidyr)
library(tidyverse)
library(dplyr)
PerGame_df <- read_csv("~/Desktop/PennState/STAT184_spring/Player_Per_game_stats.csv")
PlayerPhyscialAttributes_df <- read_csv("~/Desktop/PennState/STAT184_spring/nba_com_API_Data_2022-23.csv")

# Selecting relevant Physical and Draft statistics 
cleanedPhysicalAttrb <- PlayerPhyscialAttributes_df[, c("PLAYER_NAME", "PLAYER_HEIGHT_INCHES", "PLAYER_WEIGHT",
                                                        "COLLEGE", "COUNTRY", "DRAFT_YEAR", "DRAFT_ROUND", 
                                                        "DRAFT_NUMBER")]
# Renaming column name in PerGame_df from PName to PLAYER_NAME to match column name in cleanedPhysicalAttrb Dataset
# for merging
reNamedPerGame_df <- PerGame_df %>%
  rename(PLAYER_NAME = PName)

View(reNamedPerGame_df)
View(cleanedPhysicalAttrb)

# Merging Both data sets on Key attribute "PLAYER_NAME" for final fully processed data set 
# for visualizations 
merged_Final_Data <- merge(cleanedPhysicalAttrb, reNamedPerGame_df, by = "PLAYER_NAME")

View(merged_Final_Data)
