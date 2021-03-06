% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ee_image.R
\name{stars_as_ee}
\alias{stars_as_ee}
\title{Convert a local image into an EE Image}
\usage{
stars_as_ee(
  x,
  assetId,
  overwrite = FALSE,
  monitoring = TRUE,
  bucket = NULL,
  quiet = FALSE
)
}
\arguments{
\item{x}{stars or stars-proxy object to be converted into an ee$Image.}

\item{assetId}{Character. Destination asset ID for the uploaded file.}

\item{overwrite}{Logical. If TRUE, the assetId will be overwritten if
it exists.}

\item{monitoring}{Logical. If TRUE the exportation task will be monitored.}

\item{bucket}{Character. Name of the GCS bucket.}

\item{quiet}{Logical. Suppress info message.}
}
\value{
An ee$Image object
}
\description{
Convert a local image into an EE Image
}
\examples{
\dontrun{
library(rgee)
library(stars)
ee_Initialize(gcs = TRUE)

# Get the filename of a image
tif <- system.file("tif/L7_ETMs.tif", package = "stars")
x <- read_stars(tif)
assetId <- sprintf("\%s/\%s",ee_get_assethome(),'stars_l7')

# Method 1
# 1. Move from local to gcs
gs_uri <- local_to_gcs(x = tif, bucket = 'rgee_dev')

# 2. Pass from gcs to asset
gcs_to_ee_image(
  x = x,
  gs_uri = gs_uri,
  assetId = assetId
)

# OPTIONAL: Monitoring progress
ee_monitoring()

# OPTIONAL: Display results
ee_stars_01 <- ee$Image(assetId)
Map$centerObject(ee_stars_01)
Map$addLayer(ee_stars_01)

# Method 2
ee_stars_02 <- stars_as_ee(
  x = x,
  assetId = assetId,
  bucket = "rgee_dev"
)
Map$centerObject(ee_stars_02)
Map$addLayer(ee_stars_02)
}
}
