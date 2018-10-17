# NETTOYER DES FONDS DE CARTE AVEC R
# https://cran.r-project.org/web/packages/rmapshaper/rmapshaper.pdf
# https://github.com/ateucher/rmapshaper

library("sf")
library("dplyr")

setwd("/home/nlambert/Documents/R/CleanR")
file <- "output/nuts2003-level3.shp"
shp <- st_read(file, quiet = T)

errors <- st_union(shp)
plot(errors)
st_write(obj = errors,dsn = "output/errors.shp")

# st_write(obj = test,dsn = "errors.shp")

#st_write(obj = shp,dsn = "output2/nuts2006-level3.shp")

tmp <- shp
new <- tmp %>% group_by(id) %>% summarize() 
st_write(obj = new,dsn = "output2/nuts2003-level3.shp")

tmp <- shp
tmp$id <- substr(tmp$id,1,4)
new <- tmp %>% group_by(id) %>% summarize() 
st_write(obj = new,dsn = "output2/nuts2003-level2.shp")

tmp <- shp
tmp$id <- substr(tmp$id,1,3)
new <- tmp %>% group_by(id) %>% summarize() 
st_write(obj = new,dsn = "output2/nuts2003-level1.shp")

tmp <- shp
tmp$id <- substr(tmp$id,1,2)
new <- tmp %>% group_by(id) %>% summarize() 
st_write(obj = new,dsn = "output2/nuts2003-level0.shp")


