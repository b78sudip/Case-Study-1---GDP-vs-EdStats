# Analysis on GDP Data & Educational Data from World Bank
Sudip Bhattacharyya  
March 17, 2017  

### Libraries required:
### install.packages("dplyr")
### install.packages("XML")
### install.packages("ggplot2")
### install.packages("repmis")

### Set Working Directory


```r
setwd("C:/Users/Sudip/Documents/SMU - MSDS/Coursework/Sem1/6306 - Doing Data Science/Unit 8/Exercises/Case Study 1")
```



# Introduction

### The objective of this study is to analyze data on Gross Domestic Product (GDP) and Educational Statistics for 190 countries across the globe. 
### We have two raw data files for this study and data sources are as follows: 
### GDP Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
### Education Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

### The alternative sources for the data are respectively
### http://data.worldbank.org/data-catalog/GDP-ranking-table
### http://data.worldbank.org/data-catalog/ed-stats

### GDP file has 4 fields that provides information on Countries with respective country codes, size of the Economy (in million US dollars) and rank of the countries according to their economy size.
### Education file has 31 fields that covers information on Countries with their codes, Income group, currency unit, latest population etc.

### In this study an attempt was made to answer the questions below:

### 1. Merge the data based on the country shortcode. How many of the IDs match? 
### 2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame? 
### 3. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups? 
### 4. Show the distribution of GDP value for all the countries and color plots by income group.  Use ggplot2 to create your plot.  
### 5. Provide summary statistics of GDP by income groups. 
### 6. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?



# Part 1 - Data Download from Source & Import to R

### In this step, first, the raw csv data files were downloaded from their respective sources. Once the files are downloaded they were imported to R.


```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.3.3
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(XML)
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.3.3
```

```r
library(repmis)
```

```
## Warning: package 'repmis' was built under R version 3.3.3
```

```r
site1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(site1,destfile = "./RawDataGDP.csv")

site2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(site2,destfile = "./RawDataEDSTATS.csv")

data.GDP <- read.csv("RawDataGDP.csv", skip=5, header=F)
data.EDU <- read.csv("RawDataEDSTATS.csv", header=T)
```



# Part 2 - Data Cleaning

### This part of the project focuses on cleaning the raw data files and data preperation for analysis. Data cleaning covers removing blank rows and columns, renaming fields as per requirement, removing unwanted or irrelevent characters from data, changing data types as required and also identifying missing values.

### Once the individual files are clean they were sorted according to Country Code and then the files were merged based on Country Codes to make a single file that contains all the fields from both files. This merged file has been used for the analyses.


```r
dim(data.GDP)
```

```
## [1] 326  10
```

```r
dim(data.EDU)
```

```
## [1] 234  31
```

```r
data.GDP <- data.GDP[1:190, c(1:2,4:5)]
data.GDP <- rename(data.GDP, CountryCode = V1, Rank = V2, Country = V4, GDP = V5)
data.GDP <- arrange(data.GDP, CountryCode)
data.EDU <- arrange(data.EDU, CountryCode)

data.GDP$GDP <- gsub(",", "", data.GDP$GDP)
data.GDP$GDP <- as.numeric(as.character(data.GDP$GDP))

data.Merged <- merge(data.GDP, data.EDU, by.x = "CountryCode", by.y = "CountryCode")

data.Merged$Rank <- as.numeric(as.character(data.Merged$Rank))
```



# Part 3 - Analysis

### This is the last and main part of this project where the clean data were analysed to find out answers for the question listed in the problem statement.


### Q1. Merge the data based on the country shortcode. How many of the IDs match?


```r
nrow(data.Merged)
```

```
## [1] 189
```

### A: The number of matched countries (through their 3 digit country codes) is 189.


### Q2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?


```r
data.ordered.Merged <- data.Merged[order(as.numeric(as.character(data.Merged$GDP))),]
data.ordered.GDP <- arrange(data.GDP, GDP)
data.ordered.GDP[13, ]
```

```
##    CountryCode Rank             Country GDP
## 13         KNA  178 St. Kitts and Nevis 767
```

### A: The 13th country, when sorted in ascending order by GDP value, is 'St. Kitts and Nevis'.


### Q3. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?


```r
mean(data.Merged$Rank[data.Merged$Income.Group == "High income: OECD"])
```

```
## [1] 32.96667
```

```r
mean(data.Merged$Rank[data.Merged$Income.Group == "High income: nonOECD"])
```

```
## [1] 91.91304
```

### A:
### The average GDP rank for "High income: OECD" is 32.96667 (in million USD).
### The average GDP rank for "High income: nonOECD" is 91.91304 (in million USD).


### Q4. Show the distribution of GDP value for all the countries and color plots by income group.  Use ggplot2 to create your plot.


```r
data.forq4 <- data.Merged[c(3:4, 6)]
data.forq4 <- arrange(data.forq4, GDP)

ggplot(data.forq4, aes(x=Income.Group , y=GDP, fill=Income.Group)) + geom_boxplot() + ggtitle("GDP vs Income Group (Regular Scale)")
```

![](https://github.com/b78sudip/Case-Study-1---GDP-vs-EdStats/blob/master/Charts%20-%20Graphs/GDP%20vs%20Income%20Group%20(Regular%20Scale).jpg
)<!-- -->

```r
ggplot(data.forq4, aes(x=Income.Group , y=GDP, fill=Income.Group)) + geom_boxplot() + scale_y_log10() + ggtitle("GDP vs Income Group (Logarithmic Scale with base 10)")
```

![](https://github.com/b78sudip/Case-Study-1---GDP-vs-EdStats/blob/master/Charts%20-%20Graphs/GDP%20vs%20Income%20Group%20(Log%20Scale).jpg)<!-- -->

### Box plots were selected for graphical representation of GDP distribution for different Income groups. In the first graph GDP for all countries were plotted against Income groups. 

### This graph shows that most of the income groups has extreme outliers to higher side which makes the graph difficult to interpret.

### To overcome this issue a logarithmic transformation (with base 10) was made. Two advantages of this transformation are i) this transformation makes no change in the ranks and ii) this transformation brings the values closer to each other that reduces the range significantly and also makes the graph readable. Hence all the interpretations were made from the graph built on log(10) scale.

### The plots show that "High Income: OECD" group has the highest average GDP whereas it is lowest for "Low Income" countries. On the other hand GDP figures are least spread out for "Low Income" group of countries and "Low Middle Income" group has the widest range. Average GDP for "High Income: non OECD", "Lower Middle Income" and "Higher Middle Income" are closer to one another as compared to other income groups.


### Q5. Provide summary statistics of GDP by income groups.


```r
aggregate(data.Merged$GDP, list(data.Merged$Income.Group), summary)
```

```
##                Group.1   x.Min. x.1st Qu. x.Median   x.Mean x.3rd Qu.
## 1 High income: nonOECD     2584     12840    28370   104300    131200
## 2    High income: OECD    13580    211100   486500  1484000   1480000
## 3           Low income      596      3814     7843    14410     17200
## 4  Lower middle income       40      2549    24270   256700     81450
## 5  Upper middle income      228      9613    42940   231800    205800
##     x.Max.
## 1   711000
## 2 16240000
## 3   116400
## 4  8227000
## 5  2253000
```
### A: The summary is as below:

###              	 Group      Min     1st Q   Median     Mean     3rd Q      Max
###	  High income: nonOECD     2584     12840    28370   104300    131200   711000
###	     High income: OECD    13580    211100   486500  1484000   1480000 16240000
###	            Low income      596      3814     7843    14410     17200   116400
###	   Lower middle income       40      2549    24270   256700     81450  8227000
###	   Upper middle income      228      9613    42940   231800    205800  2253000


### Q6. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?


```r
quantile(data.Merged$Rank, probs = c(0.20, 0.40, 0.60, 0.80, 1.00))
```

```
##   20%   40%   60%   80%  100% 
##  38.6  76.2 113.8 152.4 190.0
```

```r
data.forq6 <- data.Merged[c(2:3, 6)]
data.forq6 <- arrange(data.forq6, Rank)

data.forq6.sub1 <- subset(data.forq6, data.forq6$Rank <= 38)
data.forq6.rest <- subset(data.forq6, data.forq6$Rank > 38)
data.forq6.sub1 <- within(data.forq6.sub1, Rank.Group <- "High")

data.forq6.sub2 <- subset(data.forq6.rest, data.forq6$Rank <= 38)
data.forq6.rest <- subset(data.forq6.rest, data.forq6$Rank > 38)
data.forq6.sub2 <- within(data.forq6.sub2, Rank.Group <- "Medium-High")

data.forq6.sub3 <- subset(data.forq6.rest, data.forq6$Rank <= 38)
data.forq6.rest <- subset(data.forq6.rest, data.forq6$Rank > 38)
data.forq6.sub3 <- within(data.forq6.sub3, Rank.Group <- "Medium")

data.forq6.sub4 <- subset(data.forq6.rest, data.forq6$Rank <= 37)
data.forq6.rest <- subset(data.forq6.rest, data.forq6$Rank > 37)
data.forq6.sub4 <- within(data.forq6.sub4, Rank.Group <- "Low-Medium")

data.forq6.sub5 <- subset(data.forq6.rest, data.forq6$Rank <= 38)
data.forq6.sub5 <- within(data.forq6.sub5, Rank.Group <- "Low")

data.forq6 <- rbind(data.forq6.sub1, data.forq6.sub2, data.forq6.sub3, data.forq6.sub4, data.forq6.sub5)

country.dist <- table(data.forq6$Rank.Group, data.forq6$Income.Group)

country.dist
```

```
##              
##                  High income: nonOECD High income: OECD Low income
##   High         0                    4                18          0
##   Low          0                    2                 0         11
##   Low-Medium   0                    4                 1         16
##   Medium       0                    8                 1          9
##   Medium-High  0                    5                10          1
##              
##               Lower middle income Upper middle income
##   High                          5                  11
##   Low                          16                   9
##   Low-Medium                    8                   8
##   Medium                       12                   8
##   Medium-High                  13                   9
```

### A: The number of countries in "Lower middle income" group with Highest GDP is 5.



# Conclusion

### Two files data files had been analysed for this study - Educational Data and Gross Domestic Data. This files were sourced from World Bank website. GDP file had data listed for 190 countries on 4 different fields whereas Educational file had 234 records and 31 columns.

### We merged both the files by country code that resulted into 189 records and 34 columns. One row for South Sudan (SSD) was left out of the 190 countries listed in GDP data.

### "High Income: OECD" group had the highest average GDP as well as most widely diversed "Low Income" countries had lowest average GDP. "High Income:OECD" countries had few extremely rich countries who pulled their average GDP more than 75% of their group members because the group average is higher than their 3rd quantile figure.

### United States had the maximum income for "High Income:OECD" countries which is almost 15 times of their group average. Tavalu showed GDP of $40m which is the lowest among all countries.

### "High Income: nonOECD" is the most centralized group. The stragest finding was that the average GDP for "Lower middle income" and "Upper middle income" groups are higher than the same of "High income: nonOECD" because these groups has extreme high values in their group which are supposed to be outliers.
