#···············································································
# 1) Preamble
#···············································································

# Get current working directory
current_dir <- getwd()

# Traverse upward to find the root Git directory
while(!file.exists(file.path(current_dir, ".git"))) {
  current_dir <- dirname(current_dir)
}

source(paste0(current_dir, "/00. Resources", "/_setup.R"))

#···············································································
# 2) Read data
#···············································································

# Barrios 
geojson_path <- paste0(data, "/dta", "/barrios.geojson")
barrios <- st_read(geojson_path)

# Barrios populares
geojson_path <- paste0(data, "/dta", "/barrios_populares.geojson")
barrios_populares <- st_read(geojson_path)

# Callejero 
geojson_path <- paste0(data, "/dta", "/calles.geojson")
callejero <- st_read(geojson_path)

# Trim data 
bbox_flores = st_bbox(barrios[barrios$nombre == "FLORES",])
barrios_cropped = st_crop(barrios, bbox_flores)
barrios_cropped <- barrios_cropped  %>% 
                   mutate(nombre = gsub(" ", "\n", nombre))
callejero_cropped = st_crop(callejero, bbox_flores) %>% filter(red_jerarq != "VÍA LOCAL")
barrios_populares_cropped = st_crop(barrios_populares, bbox_flores) %>% 
                             group_by(nombre) %>%
                              summarise(geometry = st_union(geometry))

#···············································································
# 3) Plot
#···············································································

ggplot() + 
  geom_sf(data = barrios_cropped, linewidth = 1.2, color = "black") +
  geom_sf(data = barrios_populares_cropped, fill = "#00b0dd") + 
  geom_sf(data = callejero_cropped, linewidth = 0.1, color = "darkgray" ) +
  geom_sf_label(data = barrios_cropped, aes(label=nombre), fill = "white", size = 3)+
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

