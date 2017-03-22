
# Part 1 - Data Download from Source & Import to R

## In this step, first, the raw csv data files were downloaded from their respective sources. Once the files are downloaded they were imported to R.

# Set Working Directory

setwd("C:/Users/Sudip/Documents/SMU - MSDS/Coursework/Sem1/6306 - Doing Data Science/Unit 8/Exercises/Case Study 1")

## We have two raw data files for this study and data sources are as follows: 
## GDP Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Education Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

## The alternative sources for the data are respectively
## http://data.worldbank.org/data-catalog/GDP-ranking-table
## http://data.worldbank.org/data-catalog/ed-stats

library(XML)

site1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(site1,destfile = "./RawDataGDP.csv")

site2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(site2,destfile = "./RawDataEDSTATS.csv")

data.GDP <- read.csv("RawDataGDP.csv", skip=5, header=F)
data.EDU <- read.csv("RawDataEDSTATS.csv", header=T)
