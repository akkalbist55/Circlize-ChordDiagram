getwd()
setwd("/home/akkal/RProject/CIRCOS/")
library(circlize)
df <- read.table("Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
df2 = data.frame(from = paste(df[[2]]), to = paste(df[[7]]), value = df[[3]], df[[4]], df[[5]], stringsAsFactors = FALSE)
#chordDiagram(df2)
col = rand_color(nrow(df2))
def = df[df2[[4]] > 5, ]


chordDiagram(df2, annotationTrack = "grid",annotationTrackHeight = c(0.07, 0.1), transparency = 0,
             preAllocateTracks = list(track.height = 0.1))

circos.track(ylim = c(-0.5, 1), panel.fun = function(x, y) {
  chr = CELL_META$sector.index
  xlim = CELL_META$xlim
  ylim = CELL_META$ylim
  circos.rect(xlim[1], -1, xlim[1], 1, col = rand_color(1))
  circos.text(mean(xlim), mean(ylim), chr, cex = 0.5, col = "black",
              facing = "clockwise", niceFacing = TRUE, adj = c(-1, 0))
}, track.height = 0.05, bg.border = NA)
  

# add labels and axis manually
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  
circos.text(mean(xlim), ylim[1], sector.name, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0), cex=0.7)
  
# print axis
# circos.axis(h = "bottom", labels.cex = 0.5, 
#  major.tick.percentage = 0.05, 
#            major.tick.length = 0.6,
#            sector.index = sector.name, track.index = 1)
}, bg.border = TRUE)

