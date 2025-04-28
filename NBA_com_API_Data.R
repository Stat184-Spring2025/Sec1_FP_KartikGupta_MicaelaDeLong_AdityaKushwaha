# 1. Install (if needed) and load packages
if (!requireNamespace("httr",      quietly=TRUE)) install.packages("httr")
if (!requireNamespace("jsonlite",  quietly=TRUE)) install.packages("jsonlite")
if (!requireNamespace("dplyr",     quietly=TRUE)) install.packages("dplyr")

library(httr)
library(jsonlite)
library(dplyr)

# 2. NBA Stats API endpoint and query parameters
url <- "https://stats.nba.com/stats/leaguedashplayerbiostats"
params <- list(
  Season      = "2022-23",
  SeasonType  = "Regular Season",
  LeagueID    = "00",
  PerMode     = "Totals"
)

# 3. NBA requires certain request headers to avoid a 403
hdrs <- add_headers(
  `Accept`             = "application/json, text/plain, */*",
  `Accept-Language`    = "en-US,en;q=0.5",
  `Connection`         = "keep-alive",
  `Host`               = "stats.nba.com",
  `Origin`             = "https://www.nba.com",
  `Referer`            = "https://www.nba.com/stats/players/bio?Season=2022-23&SeasonType=Regular+Season",
  `User-Agent`         = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)",
  `x-nba-stats-origin` = "stats",
  `x-nba-stats-token`  = "true"
)

# 4. Send GET request
resp <- GET(url, hdrs, query = params)

# 5. Make sure it succeeded
stop_for_status(resp)

# 6. Parse the JSON payload
payload <- content(resp, "text", encoding = "UTF-8") %>%
  fromJSON(flatten = TRUE)

# 7. Extract the first resultSet into a data frame
df <- payload$resultSets$rowSet[[1]] %>%
  as.data.frame(stringsAsFactors = FALSE)

# 8. Assign proper column names
names(df) <- payload$resultSets$headers[[1]]

# 9. Inspect the new data frame
glimpse(df)

# 10. Open it in RStudio’s Data Viewer
View(df)