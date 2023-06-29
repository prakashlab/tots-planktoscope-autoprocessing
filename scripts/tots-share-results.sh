#!/bin/bash -eux
id="$1"
archives_root="/media/pi/Elements/tots-ps/data"
ssh_target="pi@planktoscope-regular-level-9927.local"
results_target="/home/pi/data/results-preview/$id"
ssh "$ssh_target" "mkdir -p \"$results_target/\""
scp "$archives_root/$id-results.tar.gz" "$ssh_target:$results_target/"
ssh "$ssh_target" "cd \"$results_target\"; tar -xzf \"$id-results.tar.gz\" objects export"
ssh "$ssh_target" "rm \"$results_target/$id-results.tar.gz\""
ssh "$ssh_target" "rclone mkdir \"prakashlab-googledrive:/field_work/2023/2023-Arctic-SKQ/Data/PlanktoScope/results-preview/$id\""
ssh "$ssh_target" "rclone sync \"$results_target\" \"prakashlab-googledrive:/field_work/2023/2023-Arctic-SKQ/Data/PlanktoScope/results-preview/$id\""