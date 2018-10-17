# NETTOYER DES FONDS DE CARTE AVEC R
# https://cran.r-project.org/web/packages/rmapshaper/rmapshaper.pdf
# https://github.com/ateucher/rmapshaper

# install.packages("rmapshaper")
# or
# library(devtools)
# install_github("ropensci/geojsonio")
# install_github("ateucher/rmapshaper")


setwd("/home/nlambert/Documents/R/CleanR")
library("sf")
library("rmapshaper")

cleanandconvert <- function(file,file2,snapdist){
shp <- st_read(paste("input/",file,".shp",sep=""), quiet = T)
shp <- st_transform(shp, 3035)
shp <- st_buffer(shp, dist = 0)
shp2 <- ms_simplify(shp, snap=TRUE,keep=1,snap_interval=snapdist,keep_shapes=T,force_FC = TRUE)
shp2 <- st_buffer(shp2, dist = 0)
shp2 <- st_transform(shp2, 4326)
st_write(obj = shp2,dsn = paste("output/",file2,".shp",sep=""))
}

cleanandconvert(file = "NUTS2003/GREAT_nuts3_2003","nuts2003-level3",snapdist = 1000)

