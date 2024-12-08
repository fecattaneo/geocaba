#···············································································
# 1) Preamble
#···············································································

# Get current working directory
current_dir <- getwd()

# Traverse upward to find the root Git directory
while(!file.exists(file.path(current_dir, ".git"))) {
  current_dir <- dirname(current_dir)
}

source('H:/GitHub/geocaba/_setup.R')

#···············································································
# 2) Barrios
#···············································································

# URL
url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/ministerio-de-educacion/barrios/barrios.zip"

# Download the shapefile (compressed as a .zip file)
zip <- paste0(data, "/raw/", "barrios.zip")
download.file(url, destfile = zip, mode = "wb")

# Extract the zip file
unzip(zip, exdir = paste0(data, "/raw", "/barrios"))
file.remove(zip)

# Read the shapefile
shapefile_path <- paste0(data, "/raw", "/barrios", "/barrios.shp")
barrios <- st_read(shapefile_path)

# Check if the CRS is WGS 84
is_wgs84 <- st_crs(barrios)$epsg == 4326
stopifnot(is_wgs84)

# Save data 
geojson_file <- paste0(data, "/dta", "/barrios.geojson")
if (file.exists(geojson_file)) file.remove(geojson_file)  # Delete the existing file
st_write(barrios, geojson_file)

#···············································································
# 3) Barrios populares
#···············································································

# URL
url <- "https://data.buenosaires.gob.ar/dataset/barrios-populares/resource/3d0f5f8d-6fb2-42f1-91d4-85b347c05e76/download"

# Download the shapefile (compressed as a .zip file)
zip <- paste0(data, "/raw/", "barrios_populares.zip")
download.file(url, destfile = zip, mode = "wb")

# Extract the zip file
unzip(zip, exdir = paste0(data, "/raw", "/barrios_populares"))
file.remove(zip)

# Read the shapefile
shapefile_path <- paste0(data, "/raw", "/barrios_populares", "/barrios_vulnerables.shp")
barrios_populares <- st_read(shapefile_path)

# Transform data to WGS 84
barrios_populares <- st_transform(barrios_populares, 4326)
names(barrios_populares) <- tolower(names(barrios_populares))

# Save data 
geojson_file <- paste0(data, "/dta", "/barrios_populares.geojson")
if (file.exists(geojson_file)) file.remove(geojson_file)  # Delete the existing file
st_write(barrios, geojson_file)