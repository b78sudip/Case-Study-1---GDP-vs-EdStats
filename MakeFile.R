
## R Makefile for Case Study 1 - Analysis on GDP Data & Educational Data from World Bank
## Sudip Bhattacharyya
## March 17, 2017

## This source code file pull other R scripts from working directory and run them.

## Libraries required
install.packages("dplyr")
install.packages("XML")
install.packages("ggplot2")
install.packages("repmis")

## Set working directory

setwd("C:/Users/Sudip/Documents/SMU - MSDS/Coursework/Sem1/6306 - Doing Data Science/Unit 8/Exercises/Case Study 1")

## Import Raw data files

source("Script_DataImport.R")

## Data Cleaning & Merge clean files

source("Script_DataCleaning.R")

## Data Analysis

source("Script_DataAnalysis.R")