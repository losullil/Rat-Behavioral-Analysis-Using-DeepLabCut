After you have trained, analyzed, and evaluated your first iteration, you may want to create a labeled video to visualize how well the markings are. This step is not essential, but can be a good way to document your progress. This step requires the MOST interaction with terminal, but if you just follow my commands, it is not too hard. 

Pull up DeepLabCut on the MATE terminal. DON'T launch the GUI; you will not be able to interact with the terminal if you do so. If you do, simply enter Ctrl C. 
Then, you will define the config path. For example, 

$ config = '/mnt/research/jhoneycu/losulliv/KAT_OFT_R/KAT_OFT_R-lucyosullivan-2022-09-17/config.yaml'

Be sure to include that final quotation mark, I always forget! 

Your next command will apply the create video function and direct the computer to your existing videos that you want to be labeled. It will look something like this

$ deeplabcut.create_labeled_video(config, ['/mnt/research/jhoneycu/losulliv/KAT_OFT_R/KAT_OFT_R-lucyosullivan-2022-09-17/videos/'])

Once you press enter, you should see this
<img width="1283" alt="image" src="https://user-images.githubusercontent.com/86625869/191113696-f6bee5dc-80d4-4ace-bddc-690d33ca032d.png">
If you just receive a short message before the next line pops up, something is wrong. Make sure your analyze and evaluate scripts were successful. 

When the video is created, it will appear in a new folder on the HPC interface. You may have to download it to be able to view it. 

![image](https://user-images.githubusercontent.com/86625869/191114066-5470b571-693a-4e12-9d08-445f5c1aa465.png)


Error Notes: If you receive a message that there is "no unfiltered data file" found, check the slurm.out files to ensure that your evaluate and anaalyze steps occured correctly. 
