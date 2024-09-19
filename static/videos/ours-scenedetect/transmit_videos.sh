#!/bin/bash

# Set the remote server details
SERVER="ksefile.hpccube.com"
PORT="65245"
USER="qinxy"
PASSWD="9380ec0f4b4bc748b4-72de-447d-b110-dd92078508e5"
RETRY=10
RETRY_TIMEOUT=30
original_folder="../original"
V2A_folder="../V2A-MApper"
original_REMOTE_DIR="/AudioData/VGGsound"

# Iterate over video files in the current directory
for file in *.mp4; do
    # Extract the video_id from the filename
    video_id="${file%.*}"  # This removes the file extension (.mp4)

    # Run rayfile-c command
    rayfile-c -a $SERVER -P $PORT -u $USER -w $PASSWD \
    -no-meta -symbolic-links follow -retry $RETRY -retrytimeout $RETRY_TIMEOUT \
    -o download -s "${original_REMOTE_DIR}/${video_id}" -d "$original_folder"
    
    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "Successfully downloaded: $file"
    else
        echo "Failed to download: $file"
    fi
done
