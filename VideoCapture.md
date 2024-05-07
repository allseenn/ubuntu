ffmpeg -f x11grab -framerate 30 -video_size 1920x1080 -i :0 -vf "eq=brightness=0.5:contrast=1.8" -b:v 10M output.mp4
