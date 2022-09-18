Slurm is a part of the HPC Grid of Bowdoin. The HPC has graphical processing units, or GPUs, which are the reason why advanced video analysis like this is even possible. Before we submit to the grid, we have to prepare some files under our project folder. 

First, we have to create a .py and .sh file to command the program to submit to the HPC. I have created two samples in this repository, you can copy them yourself with your own specifications using the "edit" feature of the HPC interactive interface. See my files "train_network.py" and "train_network.sh" for reference. 

Navigate back to the Bowdoin HPC Interface. On the drop down menu on the top right, go to clusters --> Bowdoin Slurm HPC Cluster Shell Access

<img width="608" alt="image" src="https://user-images.githubusercontent.com/86625869/190883040-c54d7f0f-a904-4fe5-ac36-30b0df558a20.png">

When you click on this, a new tab should pop up on your browser that looks like a blank terminal window. Now, in just a few short commands, you can submit your job! 

Navigate to your project folder. You should also be able to see your .py and .sh scripts in this folder. Remember, to do this, you can use the $ cd command for change directory. 

<img width="1154" alt="image" src="https://user-images.githubusercontent.com/86625869/190883100-57ed9f5b-703b-48eb-a61f-7b833952c826.png">

Next, navigate into the project specific folder which contains the config.yaml file. 

