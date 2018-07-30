library(dplyr)
library(circlize)
library(plyr)
library(sqldf)
getwd()
setwd("/home/akkal/RProject/CIRCOS/")
df <- read.table("Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

df1 <- sqldf("select Wildlife, WT, arrest_district from df")
df1
circlize(df1)
chordDiagram(df1)

