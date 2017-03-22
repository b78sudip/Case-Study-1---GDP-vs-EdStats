# Case-Study-1---GDP-vs-EdStats
This is a repository for case study based on World Bank data - Assignment (Unit 08)

The objective of this study is to analyze data on Gross Domestic Product (GDP) and Educational Statistics for 190 countries across the globe. 
We have two raw data files for this study and data sources are as follows:

GDP Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Education Data: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

The alternative sources for the data are respectively

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

GDP file has 4 fields that provides information on Countries with respective country codes, size of the Economy (in million US dollars) and rank of the countries according to their economy size.
Education file has 31 fields that covers information on Countries with their codes, Income group, currency unit, latest population etc.

In this study an attempt was made to answer the questions below:

        1. Merge the data based on the country shortcode. How many of the IDs match? 
        2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?
        3. What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups? 
        4. Show the distribution of GDP value for all the countries and color plots by income group.  Use ggplot2 to create your plot.  
        5. Provide summary statistics of GDP by income groups. 
        6. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

Directories & File Locations:
-----------------------------

The root directory contains 3 sub-directories:
        
        Data (Directory):       This directory contains data files
        R (Directory):          This directory contains R scripts.
        Charts & Graphs:        This directory contains the graphs or charts produced in this project.
        
Also root directory contains the following files:
        
        Readme File:            This file describes the project details and gives the structure of directories and file locations.
        Make File:              This is the make file that calls for different R scripts sequentially.
        .rmd File:              This file contains the script for R-Markdown.
        .md File:               This shows the output of R-Markdown.
        .html File:             This is the HTML code for R-Markdown.
        
