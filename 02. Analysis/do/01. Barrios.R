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

# Lineas de subte 
geojson_path <- paste0(data, "/dta", "/lineas_subte.geojson")
lineas_subte <- st_read(geojson_path)

# Estaciones de subte 
geojson_path <- paste0(data, "/dta", "/estaciones_subte.geojson")
estaciones_subte <- st_read(geojson_path)

colors <- c("#00b0dd", "#ef1428", "#0068b4", "#008166", "#6b197f", "#fed201")

estaciones_subte$LINEA = paste0("LINEA ", estaciones_subte$LINEA)
estaciones_subte = estaciones_subte %>% rename(LINEASUB = LINEA)
lineas_subte <- st_simplify(lineas_subte, dTolerance = 50, preserveTopology = TRUE)

#···············································································
# 3) Plot
#···············································································

ggplot() + 
  geom_sf(data = barrios) +
  geom_sf(data = lineas_subte, aes(color = LINEASUB), lwd = 1.5) +
  geom_sf(data = estaciones_subte, aes(fill = LINEASUB),  color = "black", size = 3, shape = 21) +   
  scale_color_manual(values = colors) +
  scale_fill_manual(values = colors) +
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

