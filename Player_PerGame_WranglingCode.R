# Load Libraries
library(readr)
library(tidyr)
library(tidyverse)
library(dplyr)
# Reading Data set from Kaggle
df_Kaggle_set <- read_csv("~/Desktop/PennState/STAT184_spring/2023_nba_player_stats.csv")
View(df_Kaggle_set)

# Selecting useful columns ,emitting unnecessary columns 
df_select_cols <- df_Kaggle_set[, c("PName", "POS", "Team", "GP", "Min", "PTS", "FG%",
                                    "3P%", "FT%", "REB", "AST", "TOV", "STL", "BLK",
                                    "+/-")]

# Calculating PER GAME statistics by Dividing Total / Games Played 
df_perGame_Stats <- df_select_cols %>%
  mutate(
    PPG = round(PTS / GP, 1), # Points Per Game 
    RPG = round(PTS / GP, 1), # Rebounds Per Game 
    APG = round(PTS / GP, 1), # Assists Per Game 
    TPG = round(TOV / GP, 1), # Turnovers Per Game 
    SPG = round(STL / GP, 1), # Steals Per Game 
    BPG = round(BLK / GP, 1)  # Blocks Per Game
  ) %>%
  # Only selecting newley caclulated Per Game statistics
  select("PName", "POS", "Team", "GP", "FG%", "3P%", "FT%", "+/-", "PPG", "RPG", "APG", "TPG", "SPG", "BPG")

View(df_perGame_Stats)