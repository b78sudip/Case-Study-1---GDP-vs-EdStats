
# Part 2 - Data Cleaning

## This part of the project focuses on cleaning the raw data files and data preperation for analysis. Data cleaning covers removing blank rows and columns, renaming fields
## as per requirement, removing unwanted or irrelevent characters from data, changing data types as required and also identifying missing values.

## Once the individual files are clean they were sorted according to Country Code and then the files were merged based on Country Codes to make a single file that contains
## all the fields from both files. This merged file has been used for the analyses.

## GDP file has 4 fields that provides information on Countries with respective country codes, size of the Economy (in million US dollars) and rank of the countries according to their economy size.
## Education file has 31 fields that covers information on Countries with their codes, Income group, currency unit, latest population etc.

library(dplyr)
library(ggplot2)
library(repmis)

dim(data.GDP)
dim(data.EDU)

data.GDP <- data.GDP[1:190, c(1:2,4:5)]
data.GDP <- rename(data.GDP, CountryCode = V1, Rank = V2, Country = V4, GDP = V5)
data.GDP <- arrange(data.GDP, CountryCode)
data.EDU <- arrange(data.EDU, CountryCode)

data.GDP$GDP <- gsub(",", "", data.GDP$GDP)
data.GDP$GDP <- as.numeric(as.character(data.GDP$GDP))

data.Merged <- merge(data.GDP, data.EDU, by.x = "CountryCode", by.y = "CountryCode")

data.Merged$Rank <- as.numeric(as.character(data.Merged$Rank))