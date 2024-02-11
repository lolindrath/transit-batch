#!/bin/bash

# Clean up
rm input/*.zip
rm input/*.txt

pushd input

# Grab the latest from SEPTA
wget https://www3.septa.org/developer/gtfs_public.zip
unzip gtfs_public.zip
unzip google_rail.zip

popd

# Run the batch processor to convert to JSON
swift run TransitBatch

# Send it to R2
rclone sync output/ cloudflare:septa-app
