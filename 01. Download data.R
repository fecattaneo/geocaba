install.packages("geojson")
install.packages("geojsonio")
install.packages("sf")


library(geojson)
library(geojsonio)

url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-desarrollo-humano-y-habitat/barrios-populares/barrios_populares_badata_WGS84.geojson"
villas <- geojson_read(url, what = "sp")

url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.geojson"
barrios <- geojson_read(url, what = "sp")

install.packages("ggplot2")
install.packages("plyr")

library('ggplot2')
library('plyr')
library('sf')

#st_use <- lala
#geo <- lapply(st_use, geojson_read, method = "local", what = "sp")
df <- ldply(setNames(lapply(geo, fortify), gsub("\\.geojson", "", st_names[7:13])))


ggplot(data = barrios, aes(x = long, y = lat, group = group)) +
  labs(x = NULL, y = NULL) +
  geom_polygon(color = "black", fill="white") + 
  coord_quickmap()

ggplot(barrios)+
  geom_sf() +
  coord_sf()