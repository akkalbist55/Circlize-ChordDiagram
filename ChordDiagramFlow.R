library(circlize)

export_dist <- c("Kailali","Kathmandu","Bardia","Kathmandu","Bardia","Kathmandu","Bardia","Bajhang","Kailali","Kailali","Bardia","Sagaematha","Kailali","Kathmandu","Kathmandu","Kathmandu","Bardia","Mahendranagar","Bardia","Akkal")
import_dist <- c("Butwal","Butwal","Kathmandu","Butwal","Makawanpur","Bajhang","Lalitpur","Kathmandu","Lalitpur","Lalitpur","Kailali","Butwal","Kathmandu","Dolakha","Butwal","Lalitpur","Butwal","Lalitpur","Lalitpur","Bist")
flow <- c(2000,65780,78010,851,35353,845,738,120788,245900,90002,4426,6870,152681,78114,32591,19274,10915,23100,6275,567)
season<- c("Spring","Summer","Winter","Autumn","Summer","Winter","Autumn","Spring","Summer","Winter","Autumn","Summer","Winter","Autumn","Summer","Winter","Autumn","Summer","Winter","Spring")


#data.frame


df <- data.frame(export_dist, import_dist, flow,stringsAsFactors = FALSE)
df[[3]] = log10(df[[3]])

dist = unique(c(df[[1]], df[[2]]))
color <- c("#E41A1C","#800000","#ff8c00","#ffd700","#008000","#00bfff","#377EB8",
           "#ff69b4","#800080","#4b0082","#dd15f1","#59f30b")

#df <- data.frame(export_dist, import_dist, flow, season)
#chordDiagram(df)


df1 <- data.frame(dist, color,stringsAsFactors = FALSE)
df1 <- data.frame(dist, color)
circos.clear()
circos.par(start.degree = 90, gap.degree = 5, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
par(mar = rep(0, 4))

res = chordDiagram(x = df, grid.col = color, transparency = 0.25,
                   order = dist, directional = 1,
                   direction.type = c("arrows", "diffHeight"), diffHeight  = -0.04,
                   annotationTrack = c("grid"), annotationTrackHeight = c(0.05, 0.1),
                   link.arr.type = "big.arrow", link.sort = TRUE, link.largest.ontop = TRUE)







circos.trackPlotRegion(
  track.index = 1, 
  bg.border = NA, 
  panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    sector.index = get.cell.meta.data("sector.index")
    dist = df1$dist[df1$dist == sector.index]
    
    #circos.text(x = mean(xlim), y = 1.5, 
    #            labels = dist, facing = "bending", adj = c(0.5, 0), cex = 1, niceFacing = TRUE)
    circos.text(CELL_META$xcenter, CELL_META$cell.ylim[1] - uy(2, "mm"),
                CELL_META$sector.index, facing = "reverse.clockwise", niceFacing = TRUE,
                adj = c(1.5, 0.5), cex = 0.8)
    
    
    
    
    circos.text(CELL_META$xcenter, CELL_META$cell.ylim[1] - uy(2, "mm"),
                CELL_META$sector.index, facing = "clockwise", niceFacing = TRUE,
                adj = c(1, 0.5), cex = 0.8)
    
    
  }
  
  
)





for(i in seq_len(nrow(res))) {
  circos.text(x = res$x1[i] - res$value[i]/2, y = 0.5, round(10^(res$value[i])), facing = "inside",
              niceFacing = TRUE, adj = c(0.5, 0.5), cex = 0.5, col = "white", sector.index = res$rn[i], track.index = 1)
  circos.text(x = res$x2[i] - res$value[i]/2, y = 0.5, round(10^(res$value[i])), facing = "inside",
              niceFacing = TRUE, adj = c(0.5, 0.5), cex = 0.5, col = "white", sector.index = res$cn[i], track.index = 1)
}

