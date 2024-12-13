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
# 2) Callejero
#···············································································

# URL
url <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/jefatura-de-gabinete-de-ministros/calles/callejero.zip"

# Download the shapefile (compressed as a .zip file)
zip <- paste0(data, "/raw/", "callejero.zip")
download.file(url, destfile = zip, mode = "wb")

# Extract the zip file
unzip(zip, exdir = paste0(data, "/raw", "/callejero"))
file.remove(zip)

# Read the shapefile
shapefile_path <- paste0(data, "/raw", "/callejero", "/calles.shp")
calles <- st_read(shapefile_path)

# Check if the CRS is WGS 84
is_wgs84 <- st_crs(calles)$epsg == 4326
stopifnot(is_wgs84)

# Save data 
geojson_file <- paste0(data, "/dta", "/calles.geojson")
if (file.exists(geojson_file)) file.remove(geojson_file)  # Delete the existing file
st_write(calles, geojson_file)
