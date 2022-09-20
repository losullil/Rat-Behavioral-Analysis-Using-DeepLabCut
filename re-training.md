If you have created a labeled video, you will quickly notice the obvious: you need to re-train. Hopefully, you will get some good frames where the program can notice your markers, like this one. 

<img width="202" alt="image" src="https://user-images.githubusercontent.com/86625869/191134297-d0cfbcc8-8a45-4224-a3c1-999ebacd2fd2.png">

You will soon notice the markers skipping back and forth, especially in turns or rearing. Here is an example, yikes! 

<img width="142" alt="image" src="https://user-images.githubusercontent.com/86625869/191134404-84145b1d-f52b-4195-b516-c55e4ddb444e.png">

It is time to re-train. This is totally normal, and usually needs to happen multiple times until eventually you reach diminishing returns. 

Navigate to the OPT:Refine/Extract Outliers tab on the DLC GUI. Plug in your config file, and then select your video .mp4. Do not select the labeled video, the raw video is necessary! 

You can select frames with the "jump" algorithm, where DLC will extract a select number of frames, or the manual algorithm, where you go through the video and choose trouble areas. If you select jump then click EXTRACT FRAMES, you will have to navigate to the terminal and enter "yes" to start the job. You will see a loading screen like this: 
<img width="646" alt="image" src="https://user-images.githubusercontent.com/86625869/191135226-b6550e8b-e318-4784-81d5-d367b5dfa236.png">

I have had problems with these functions and the processing power of the MATE desktop. I prefer to use manual extraction of 10 frame chunks. Change the algorithm to manual, and specify videotype. Then click "Extract Frames" and select "Range of Frames". From there, you can toggle through the frames of the video (be warned, there is a huge lag) and click "Grab Frames" to select. When you are done, just click quit. You can launch GUI, then load labels from the machine learning .h5 file that DLC will direct you to. It will prompt you with a likelihood threshold; this is the likelihood that a given marker is correct. I keep the default 0.4. 
<img width="504" alt="image" src="https://user-images.githubusercontent.com/86625869/191138536-41e05f1e-7702-4e1a-9c14-ae429139c3f9.png">

Then, just go through frames and adjust labels accordingly. 

Once you are done, hit "Save" and then "Merge Dataset". Then click "OK" to make a new training dataset. Then just re-submit the training!
