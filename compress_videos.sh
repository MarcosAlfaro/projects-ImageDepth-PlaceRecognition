# compress videos.sh
# This script compresses all video files in the .videos directory using ffmpeg.
# It creates a new directory called "compressed" and saves the compressed videos there.
# Usage: ./compress_videos.sh
#!/bin/bash
# Create a directory for compressed videos
mkdir -p static/compressed
# Set desired FPS (you can change this value)
FPS=24
# Set videos directory and check if it exists
# get the current directory
current_dir=$(pwd)
# print the current directory
echo "Current directory: $current_dir"
# append the .videos directory to the current directory
videos_dir="$current_dir/static/videos"
# check if the videos directory exists
if [ ! -d "$videos_dir" ]; then
    echo "The directory $videos_dir does not exist."
    exit 1
fi

# Loop through all video files in the videos directory
for video in "$videos_dir"/*; do
    # Skip if no files found
    [ -e "$video" ] || continue
    
    # Get the filename without the path
    filename=$(basename "$video")
    # Compress the video using ffmpeg
    ffmpeg -i "$video" -vcodec libx264 -crf 32 -preset slow -r $FPS "$current_dir/static/compressed/$filename"
    # 18 muy buena, 23 buena, 28 mala
    # Check if the compression was successful
    if [ $? -eq 0 ]; then
        echo "Compressed $filename successfully."
    else
        echo "Failed to compress $filename."
    fi
done
