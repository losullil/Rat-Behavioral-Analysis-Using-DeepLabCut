After several iterations of each training session, I realized my first two models were struggling much more than my third. I used "uncertain" sampling (instead of manual) to get a visual on which frames were struggling the most. It turns out, several of the sample videos in models 1 and 2 contained the experimenter reaching for the rat in the last seconds of the video! This seemed to be confusing the model. So, I had to go through each video and record at which point an experimenter stepped in (if at all). Then, in terminal, I inserted: 

$ ffmpeg -sseof -_secondsofffromend_ -i input.mp4 -c copy output.mp4

