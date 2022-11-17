After several iterations of each training session, I realized my first two models were struggling much more than my third. I used "uncertain" sampling (instead of manual) to get a visual on which frames were struggling the most. It turns out, several of the sample videos in models 1 and 2 contained the experimenter reaching for the rat in the last seconds of the video! This seemed to be confusing the model. So, I had to go through each video and record at which point an experimenter stepped in (if at all). Then, in terminal, I inserted: 

$ ffmpeg -sseof -_secondsofffromend_ -i input.mp4 -c copy output.mp4

I also wanted to cut the videos into 5 minute chunks. This will 1) allow me to compare USV/silence conditions and 2) cut out the long stretches at the ends of some videos where the camera was left on accidentally. I need to create a loop of an ffmpeg split command to do this efficently. 

$ for FILE in *.mp4; do ffmpeg -i "$f" -c copy -map 0 -segment_time 00:05:05 -f segment  "${f%.*}.mp4"; done

This was what I first attempted, which in theory should work (troubleshooting forums suggested it was my own dated terminal that was preventing it). So, I underwent the tedious process of cutting each video--a temporary fix for now--with this following command. 

$ ffmpeg 
  -i OFT_35.mp4 
  -c copy 
  -map 0 
  -segment_time 00:05:05 
  -f segment 
  OFT_35%03d.mp4
 With the video edited for what I am putting in. 
