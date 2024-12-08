install.packages("geojson")
install.packages("geojsonio")
install.packages("sf")
install.packages("ggplot2")
install.packages("plyr")

library(geojson)
library(geojsonio)
library('ggplot2')
library('plyr')
library('sf')
library(dplyr)
library('tidyverse')


# Define the URL where the shapefile is located
url <- "https://data.buenosaires.gob.ar/dataset/barrios-populares/resource/3d0f5f8d-6fb2-42f1-91d4-85b347c05e76/download"

# Define the local folder and the destination file name
zip <- "H:/GitHub/geocaba/raw/barrios_populares.zip"

# Download the shapefile (compressed as a .zip file)
download.file(url, destfile = zip, mode = "wb")

# Print message when done
cat("Shapefile downloaded successfully!\n")

# Now, extract the zip file (shapefile components)
unzip(zip, exdir = 'H:/GitHub/geocaba/raw/barrios_populares')
file.remove(zip)

# Read the shapefile with `sf` package
shapefile_path <- "H:/GitHub/geocaba/raw/barrios_populares/barrios_vulnerables.shp"
villas <- st_read(shapefile_path)
villas <- st_transform(villas, 4326)



url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.geojson"
barrios <- geojson_read(url, what = "sp")
barrios <- st_as_sf(barrios, coords = c("lon", "lat"), crs = 4326) # I assume we are using the standard coordinates system, WGS84.




#st_use <- lala
#geo <- lapply(st_use, geojson_read, method = "local", what = "sp")
df <- ldply(setNames(lapply(geo, fortify), gsub("\\.geojson", "", st_names[7:13])))


# Map in ggplot
ggplot() +
  geom_sf(data = cropped[cropped$nombre_dpt == "CUNDINAMARCA",], fill = cl_palette[4]) +       # Geographic municipalities
  geom_sf(data = cropped[cropped$nombre_dpt == "SANTAFE DE BOGOTA D.C",]) +                    # // cont'd
  geom_sf_text(data = cropped, aes(label = nombre_mpi), size = 7/.pt, check_overlap = TRUE) +  # Names of municipalities
  geom_point(data = isochrones, size = 2.5, aes(x = lon, y = lat, shape = company_group, color = company_group)) +     # RMX plants
  scale_color_manual(values = cl_palette[1:2]) +                                # // Color plant
  scale_shape_manual(values = c(15, 19)) +
  #geom_sf_label(data = isochrones, aes(lon, lat, label = site_name), size = 7/.pt, fontface = "bold") +  # Names of municipalities
  coord_sf(xlim = outer_x, ylim = outer_y, expand=FALSE) +
  theme(axis.text.x=element_blank(),
        axis.title.x = element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        axis.ticks.y=element_blank(),
        legend.title=element_blank(),
        legend.position="inside",
        legend.position.inside = c(.99, .01),
        legend.box.just = "right",
        legend.justification = c("right", "bottom"),
        axis.ticks.length = unit(0, "pt"),
        plot.margin = margin(0, 0, 0, 0)) 

ggplot() +
  geom_sf(data = barrios) +
  geom_sf_text(data = barrios, aes(label = nombre), size = 7/.pt, check_overlap = TRUE) +  # Nombre del barrio
  geom_sf(data = villas, fill = "blue") # +

#  labs(x = NULL, y = NULL) +
#  geom_polygon(color = "black", fill="white") + 
#  coord_quickmap()

ggplot()+
  coord_sf()