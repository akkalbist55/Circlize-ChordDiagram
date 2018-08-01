library(dplyr)
library(igraph)
library(circlize)
getwd()
setwd("/home/akkal/RProject/IGRAPH/")
Data <- read.table("Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#dta <- read.csv("Data.csv", header=T,row.names=NULL)
#aaa <- Data[Data$Wildlife=="Tiger",] select only tiger from Data.csv table
sss <- read.csv("Data.csv",header=T,fill=T,
                   row.names = NULL)[,-1]
#tokeep <- c(Data[,"Wildlife"] == "Tiger")
#tokeep
Q <- with(Data, table(Wildlife, arrest_district))
links2 <- crossprod(Q, Q) #make adjacency matrix from table csv
diag(links2) <- 0 # make a pivot element to zero from csv to adjacency matrix
links2[ links2<20 ] <- 0 #remove weight <10 from adjacency matrix

links2
#E(links2)$w <-  E(links2)$weight > 10
#links2$Frequency <- table(links2$V1)[links2$V1]

links2 <- as.matrix(links2)
#ig <- graph.adjacency(links2, mode="undirected", weighted=TRUE)
chordDiagram(links2, annotationTrack = "grid",annotationTrackHeight = c(0.07, 0.1), transparency = 0,
             preAllocateTracks = list(track.height = 0.1))

circos.track(ylim = c(-0.5, 1), panel.fun = function(x, y) {
  chr = CELL_META$sector.index
  xlim = CELL_META$xlim
  ylim = CELL_META$ylim
  circos.rect(xlim[1], -1, xlim[1], 1, col = rand_color(1))
  circos.text(mean(xlim), mean(ylim), chr, cex = 0.6, col = "black",
              facing = "clockwise", niceFacing = TRUE, adj = c(-1, 0))
}, track.height = 0.05, bg.border = TRUE)
circos.clear()

