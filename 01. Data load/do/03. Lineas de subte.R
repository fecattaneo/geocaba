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
# 2) Lineas de subte
#···············································································

# URL
url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/sbase/subte-estaciones/lineas-de-subte-zip.zip"

# Download the SHP file
zip <- paste0(data, "/raw/", "lineas_subte.zip")
download.file(url, destfile = zip, mode = "wb")

# Extract the zip file
unzip(zip, exdir = paste0(data, "/raw", "/lineas_subte"))
file.remove(zip)

# Read the shapefile
shapefile_path <- paste0(data, "/raw", "/lineas_subte", "/lineas-subte.shp")
lineas_subte <- st_read(shapefile_path)

# Check if the CRS is WGS 84
is_wgs84 <- st_crs(lineas_subte)$epsg == 4326
stopifnot(is_wgs84)

# Save data 
geojson_file <- paste0(data, "/dta", "/lineas_subte.geojson")
if (file.exists(geojson_file)) file.remove(geojson_file)  # Delete the existing file
st_write(lineas_subte, geojson_file)

#···············································································
# 3) Estaciones de subte
#···············································································

# URL
url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/sbase/subte-estaciones/estaciones-de-subte.zip"

# Download the SHP file
zip <- paste0(data, "/raw/", "estaciones_subte.zip")
download.file(url, destfile = zip, mode = "wb")

# Extract the zip file
unzip(zip, exdir = paste0(data, "/raw", "/estaciones_subte"))
file.remove(zip)

# Read the shapefile
shapefile_path <- paste0(data, "/raw", "/estaciones_subte", "/estaciones-de-subte.shp")
estaciones_subte <- st_read(shapefile_path)

# Check if the CRS is WGS 84
is_wgs84 <- st_crs(estaciones_subte)$epsg == 4326
stopifnot(is_wgs84)

# Save data 
geojson_file <- paste0(data, "/dta", "/estaciones_subte.geojson")
if (file.exists(geojson_file)) file.remove(geojson_file)  # Delete the existing file
st_write(estaciones_subte, geojson_file)

