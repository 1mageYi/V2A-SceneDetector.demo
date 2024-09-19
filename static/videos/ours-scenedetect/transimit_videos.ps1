# Define variables
$localVideoDir = "C:\Users\Admin\Desktop\DKU\SW\V2A-SceneDetector.demo\static\videos\ours-scenedetect" # Replace with your local video directory
$remoteUser = "yimj"
$remoteIP = "10.200.13.115"
$remoteVideoDir = "/SMIIPdata1/VGGSound_15446/datasets/original_datasets/VGGsound_test_15446_video_original/"
$localDestinationDir = "C:\Users\Admin\Desktop\DKU\SW\V2A-SceneDetector.demo\static\videos\original" # Replace with your local destination directory
$remoteVideoDir_v2a = "/SMIIPdata1/VGGSound_15446/v2a_combined_videos/"
$localDestinationDir_v2a = "C:\Users\Admin\Desktop\DKU\SW\V2A-SceneDetector.demo\static\videos\V2A-Mapper" # Replace with your local destination directory
# Get the list of video files in the local directory
$files = Get-ChildItem -Path $localVideoDir -Filter *.mp4  # Adjust the file extension if necessary

# Loop through each file and copy from the remote server
foreach ($file in $files) {
    $filename = $file.Name
    $remoteFilePath = "$remoteUser@${remoteIP}:${remoteVideoDir_v2a}${filename}"
    
    # Use scp to copy the file from remote server to the local destination
    scp $remoteFilePath $localDestinationDir_v2a

    # Check if the copy was successful
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully copied $filename"
    } else {
        Write-Host "Failed to copy $filename"
    }
}