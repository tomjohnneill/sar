# by Tom Wagstaff @ Crisis

library(dplyr)
library(rvest)

BRMAno <- c()
BRMAname <- c()
nRents <- c()
minRent <- c()
maxRent <- c()
LHArate <- c()

setwd("C:/Users/Temp/Documents/HomelessHack/Graphs") # change this. Graphs will be stored here - the summary csv will be stored in the parent folder.

queryMonth <- 5
queryYear <- 2017 # you can set these to other years / months if you like

j <- 1 # set j to 1 for SAR, 2 for 1 bed, 3 for 2 bed, 4 - 3 bed, 5 - 4 bed.

for (i in 1:170) { # should be 170 - 6 for testing
  page <- paste0("https://lha-direct.voa.gov.uk/ListofRents.aspx?Month=", as.character(queryMonth), "&Year=", as.character(queryYear), "&BrmaId=", as.character(i))
  voa <- html_session(page)
  
  BRMAno <- BRMAno %>%
    c(i)
  
  BRMAname <- BRMAname %>%
    c(gsub("View List of Rents information for ", "", voa %>%
    html_node("#HeaderTwo") %>%
    html_text()))
  
  nRentsNode <- paste0("li:nth-child(", as.character(j), ") th+ td")
  nRents <- nRents %>%
    c(voa %>%
    html_node(nRentsNode) %>%
    html_text() %>%
    as.integer())
    
  minRentNode <- paste0("li:nth-child(", as.character(j), ") td:nth-child(3)")
  minRent <- minRent %>%
    c(gsub("£", "", voa %>%
    html_node(minRentNode) %>%
    html_text()) %>%
    as.numeric())
    
  maxRentNode <- paste0("li:nth-child(", as.character(j), ") td:nth-child(4)")
  maxRent <- maxRent %>%
    c(gsub("£", "", voa %>%
    html_node(maxRentNode) %>%
    html_text()) %>%
    as.numeric())
    
  LHARateNode <- paste0("li:nth-child(", as.character(j), ") td:nth-child(5)")
  LHArate <- LHArate %>%
    c(gsub("£", "", voa %>%
    html_node(LHARateNode) %>%
    html_text()) %>%
    as.numeric())
    
  imgNode <- paste0("li:nth-child(", as.character(j), ") img")
  imgSource <- voa %>%
    html_node(imgNode) %>%
    html_attr("src")
    
  print(imgSource)
  targetFile <- paste0("BRMA_", i, "_beds_", (j - 1), ".gif")
  try(download.file(paste0("https://lha-direct.voa.gov.uk/", imgSource), destfile = targetFile, mode = "wb", quiet = TRUE), silent = TRUE)
}

voaResult <- data.frame(BRMAno, BRMAname, nRents, minRent, maxRent, LHArate)

destFile <- paste0("./VOA_summary_", as.character((j-1)), "_beds_", as.character(queryYear), "_", as.character(queryMonth), ".csv")
write.csv(voaResult, destFile)
