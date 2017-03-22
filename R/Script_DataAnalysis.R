
## In this study an attempt was made to answer the questions below:

## 1 Merge the data based on the country shortcode. How many of the IDs match? 
## 2 Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame? 
## 3 What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups? 
## 4 Show the distribution of GDP value for all the countries and color plots by income group.  Use ggplot2 to create your plot.  
## 5 Provide summary statistics of GDP by income groups. 
## 6 Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

# Part 3 - Analysis

## This is the last and main part of this project where the clean data were analysed to find out answers for the question listed in the problem statement.

## Q1. Merge the data based on the country shortcode. How many of the IDs match?

nrow(data.Merged)

## The number of matched countries (through their 3 digit country codes) is 189.

## Q2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?

data.ordered.Merged <- data.Merged[order(as.numeric(as.character(data.Merged$GDP))),]
data.ordered.GDP <- arrange(data.GDP, GDP)
data.ordered.GDP[13, ]

## The 13th country, when sorted in ascending order by GDP value, is 'St. Kitts and Nevis'.

## Q3. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?

mean(data.Merged$Rank[data.Merged$Income.Group == "High income: OECD"])
mean(data.Merged$Rank[data.Merged$Income.Group == "High income: nonOECD"])

## The average GDP rank for "High income: OECD" is 32.96667 (in million USD).
## The average GDP rank for "High income: nonOECD" is 91.91304 (in million USD).

## Q4. Show the distribution of GDP value for all the countries and color plots by income group.  Use ggplot2 to create your plot.

data.forq4 <- data.Merged[c(3:4, 6)]
data.forq4 <- arrange(data.forq4, GDP)

ggplot(data.forq4, aes(x=Income.Group , y=GDP, fill=Income.Group)) + geom_boxplot() + ggtitle("GDP vs Income Group (Regular Scale)")
ggplot(data.forq4, aes(x=Income.Group , y=GDP, fill=Income.Group)) + geom_boxplot() + scale_y_log10() + ggtitle("GDP vs Income Group (Logarithmic Scale with base 10)")

## Box plots were selected for graphical representation of GDP distribution for different Income groups. In the first graph GDP for all countries were plotted against Income groups. 
## This graph shows that most of the income groups has extreme outliers to higher side which makes the graph difficult to interpret.

## To overcome this issue a logarithmic transformation (with base 10) was made. Two advantages of this transformation are i) this transformation makes no change in the ranks and
## ii) this transformation brings the values closer to each other that reduces the range significantly and also makes the graph readable. Hence all the interpretations were made
## from the graph built on log(10) scale.

## The plots show that "High Income: OECD" group has the highest average GDP whereas it is lowest for "Low Income" countries. On the other hand GDP figures are least spread out
## for "Low Income" group of countries and "Low Middle Income" group has the widest range. Average GDP for "High Income: non OECD", "Lower Middle Income" and "Higher Middle Income"
## are closer to one another as compared to other income groups.

## Q5. Provide summary statistics of GDP by income groups.

aggregate(data.Merged$GDP, list(data.Merged$Income.Group), summary)

## The summary is as below:

###             	 Group      Min     1st Q   Median     Mean     3rd Q      Max
###	  High income: nonOECD     2584     12840    28370   104300    131200   711000
###	     High income: OECD    13580    211100   486500  1484000   1480000 16240000
###	            Low income      596      3814     7843    14410     17200   116400
###	   Lower middle income       40      2549    24270   256700     81450  8227000
###	   Upper middle income      228      9613    42940   231800    205800  2253000

## Q6. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

quantile(data.Merged$Rank, probs = c(0.20, 0.40, 0.60, 0.80, 1.00))

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

## The number of countries in "Lower middle income" group with Highest GDP is 5.

str(data.forq6)
str(data.Merged)