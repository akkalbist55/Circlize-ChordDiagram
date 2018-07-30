getwd()
setwd("/home/akkal/RProject/CIRCOS/")

library("circlize")
df <- read.table("Data.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#names(df1) <- c("Wildlife","WT","arrest_district")

df2 = data.frame(from = paste(df[[2]]), to = paste(df[[7]]), value = df[[3]], df[[4]], df[[5]], stringsAsFactors = FALSE)
#chordDiagram(df2)
col = rand_color(nrow(df))
def = df[df2[[4]] > 10.10, ]
def

sp = unique(c(df[[4]]))
from = paste(df[[2]], sep = ",")
to = paste(df[[7]], sep = ",")
grid.col <- col
dff <- data.frame(from, to, stringsAsFactors = FALSE)
circos.clear()

# Plot chord diagram
chordDiagram(df2,
             
             # manual order of sectors
             #order = port_coords$Name_short,
             
             # plot only grid (no labels, no axis)
             annotationTrack = "grid",
             # annotationTrack = NULL, 
             preAllocateTracks = 1, 
             
             # adjust grid width and spacing
             annotationTrackHeight = c(0.05, 0.1), 
             
             # add directionality
             directional=FALSE, 
            # direction.type = c("diffHeight", "arrows"), 
            # link.arr.type = "big.arrow",
             
             # adjust the starting end of the link
             diffHeight = -uh(1, "mm"),
             
             # adjust height of all links
             h.ratio = 0.8,
             
             # add link border
             link.lwd = 1, link.lty = 1, link.border="gray35"
             
             # track.margin = c(0.01, 0.1)
            
)

# Scotland
highlight.sector(port_coords$Name_short[which(dff$Country_lb == "Scotland")],
                 track.index = 1, col = "blue2",
                 text = "Scotland", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)
# England
highlight.sector(port_coords$Name_short[which(port_coords$Country_lb == "England")],
                 track.index = 1, col = "red2",
                 text = "England", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)
# Wales
highlight.sector(port_coords$Name_short[which(port_coords$Country_lb == "Wales")],
                 track.index = 1, col = "springgreen4",
                 text = "Wales", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)
# Isle of Man
highlight.sector(port_coords$Name_short[which(port_coords$Country_lb == "Isle of Man")],
                 track.index = 1, col = "orangered4",
                 text = "Isle of Man", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)
# Rep. Ireland
highlight.sector(port_coords$Name_short[which(port_coords$Country_lb == "Rep. Ireland")],
                 track.index = 1, col = "darkorange3",
                 text = "Ireland", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)
# N.Ireland
highlight.sector(port_coords$Name_short[which(port_coords$Country_lb == "N.Ireland")],
                 track.index = 1, col = "magenta4",
                 text = "NI", cex = 1, text.col = "white", 
                 niceFacing = TRUE, font=2)

# add labels and axis manually
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  
  # print labels & text size (cex)``
  # circos.text(mean(xlim), ylim[1] + .7, sector.name, 
  #            facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5), cex=0.6)
  
  circos.text(mean(xlim), ylim[1], sector.name, 
              facing = "clockwise", niceFacing = TRUE, adj = c(0, 0), cex=0.6)
  
  # print axis
  #circos.axis(h = "bottom", labels.cex = 0.5, 
              # major.tick.percentage = 0.05, 
   #           major.tick.length = 0.6,
   #           sector.index = sector.name, track.index = 1)
}, bg.border = TRUE)

# re-set circos parameters
circos.clear()

