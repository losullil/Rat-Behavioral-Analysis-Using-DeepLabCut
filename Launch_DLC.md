Now it is time to launch DeepLabCut in the HPC! Woohoo! Some sources believe installing DeepLabCut to be the most difficult step of the software. Lucky for us, Dj has already installed DLC on the HPC. All we have to do is access it! 

# **Launching the Desktop**

First, navigate to the [Interactive Apps Tab/Bowdoin HPC Desktop](https://hpcweb.bowdoin.edu/pun/sys/dashboard/batch_connect/sys/bc_desktop/bowdoin/session_contexts/new) on the HPC Interface. There, you will be prompted with this screen: 
<img width="1037" alt="image" src="https://user-images.githubusercontent.com/86625869/180818523-1f886f89-87fa-41bb-941a-5063ad5cdac9.png">
I usually would log onto this at 9 AM and be on it until 5 PM, so I changed my session length to be 8 hours instead of the default 1. I haven't run into any complications with longer jobs, although if you are planning on submitting a training, you may want to end your session to avoid crowding the server. Once you have the proper specifications, click "launch" and wait ~2 minutes for the desktop to configure. Then, launch the desktop!

# **Navigate to MATE Terminal**

Once you click launch, a secondary tab should pop up that looks like a computer homescreen and you will receive an email from moosehead that your job has began. This is the Linux desktop! You can leave this desktop but it will still exist unless the session runs out or you end it. _Note: If right away, or at any point, you have a No Connection message, make sure you are still connected to the Bowdoin Wifi. We also had some issues with internationally bought computers, if this applies to you, reach out to DJ_

Go to Applications --> System Tools --> MATE Terminal. A black box will pop up: the terminal! This is how you can interact directly with the HPC operating system. 

<img width="880" alt="image" src="https://user-images.githubusercontent.com/86625869/180845120-082cd976-ef50-4693-9ea3-a3c7df2366ba.png">

# **Launching DeepLabCut**

Stay with me here! This is when you will be using some "coding" language. It is important to type each command exactly; a single wrong character will confuse the computer. From here on, a line that says 

$ _text of some sort_ 

means a line of code! Italicized code means something you will have to fill in with your own specifications. For example, 

$ _filename_ 

would really be 

$ KAT_OFT

if that is the file you are trying to access. 

First, you will want to enter the folder where the videos you are trying to analyze are stored. You will want to use the command: 

$ cd /mnt/research/jhoneycu/_yourpersonalfoldername/videosubfoldername_

After you have created your first project, you will want to "cd", or "change directory" into your project location. For example, to access my project this summer, I typed in the command: 

<img width="862" alt="image" src="https://user-images.githubusercontent.com/86625869/180847379-fce01f0a-a542-43cc-83c9-11917ec17bcf.png">

The top line of text here is the command I entered to get into my project directory. Once you press enter, the next line will appear; now, your commands will appear after the full address you have entered. This is how you can access the DLC files once the app is up! 

Next command: to retreive DeepLabCut, which has already been installed, enter: 

$ source /mnt/local/python-venv/dlc-2.2.1-gui/bin/activate

A cool tip here: if you have enough letters in a folder that the computer can distinguish it from other folder options, you can press "TAB" and the whole word will be produced. For example, at the end of the last command, just "ac" then "TAB" is enough for "activate" to be produced!

Once you press enter on this next command, your terminal will look like this:
<img width="1036" alt="image" src="https://user-images.githubusercontent.com/86625869/180848970-2824fd91-fe95-40c5-9fe4-ef6992ee882b.png">
The (dlc-2.2.1-gui) shows that you have called upon the DeepLabCut software. _Note: At the time this is created in 2022, 2.2.1 is the most updated software. In future years, this may change and you will have to enter another version_ 
Next, enter the command: 

$ ipython 

It will take a second, but eventually this will appear. 
<img width="919" alt="image" src="https://user-images.githubusercontent.com/86625869/180849441-8b835dc8-3aba-43a9-ab4a-1cba310bd808.png">

In the green line, first type:

$ import deeplabcut

After a bit of time (and some computer messages), you will be prompted with another green line. On this line, type:

$ deeplabcut.launch_dlc()

After a few seconds, the Graphical User Interface, or GUI, will appear! It should all look like this. 

<img width="1411" alt="image" src="https://user-images.githubusercontent.com/86625869/180850278-aa10e69c-b58b-465a-8b28-a2956e3e2481.png">

Yay! You are ready to create your project! 

![image](https://user-images.githubusercontent.com/86625869/180850445-7a468469-7114-4677-90a9-5a0f6899b848.png)
