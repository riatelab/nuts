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
library("cartography")

# Import shapfile
nuts <- st_read("shp/geom_eu34_nuts13.shp", quiet = T)
nuts3 <- nuts[nuts$level3 == 1,]
nuts3$nuts2 <- substr(nuts3$id, 1,4)
nuts3$nuts1 <- substr(nuts3$id, 1,3)
nuts3$nuts0 <- substr(nuts3$id, 1,2)
#head(nuts3)
# plot
plot(st_geometry(nuts3))

# On determine la couche de travail
shp <- nuts3
shp <- st_buffer(shp, 0)

# Affichage des erreurs topologiques
plot(st_union(shp),col="#f9d7cc",border="red")
title("st_union\n(nuts3 2013)")

# Premier traitement : snap 1km
shp2 <- ms_simplify(shp, snap=TRUE,keep=1,snap_interval=1000,keep_shapes=T,force_FC = TRUE)
shp2 <- st_buffer(shp2, 0)
test <- st_union(shp2)
plot(test,col="#f9d7cc",border="red")
title("st_union + snap 1km\n(nuts3 2013)")

# vérification
length(st_geometry(shp)) - length(st_geometry(shp2))
