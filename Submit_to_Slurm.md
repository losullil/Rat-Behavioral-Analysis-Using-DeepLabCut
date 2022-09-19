Slurm is a part of the HPC Grid of Bowdoin. The HPC has graphical processing units, or GPUs, which are the reason why advanced video analysis like this is even possible. Before we submit to the grid, we have to prepare some files under our project folder. 

First, we have to create a .py and .sh file to command the program to submit to the HPC. I have created two samples in this repository, you can copy them yourself with your own specifications using the "edit" feature of the HPC interactive interface. See my files "train_network.py" and "train_network.sh" for reference. 

Navigate back to the Bowdoin HPC Interface. On the drop down menu on the top right, go to clusters --> Bowdoin Slurm HPC Cluster Shell Access

<img width="608" alt="image" src="https://user-images.githubusercontent.com/86625869/190883040-c54d7f0f-a904-4fe5-ac36-30b0df558a20.png">

When you click on this, a new tab should pop up on your browser that looks like a blank terminal window. Now, in just a few short commands, you can submit your job! 

Navigate to your project folder using the following command. 

$ cd /mnt/research/jhoneycu/_yourname/yourfolder/yourprojectfolder_

If you insert the command 

$ ls 

You should see your config.yaml file, your .py and your .sh scripts. 

To submit your training script, insert the following command. 

$ sbatch -p gpu --gres=gpu:rtx3080:1 --mem=32G train_network.sh

You should receive a notice such as this one.

<img width="248" alt="image" src="https://user-images.githubusercontent.com/86625869/190883487-1ac53b98-d3bf-46fe-9dea-2aa2113872b2.png">

This means your job has submitted! You can see where you are on the queue of jobs by inputting

$ squeue

You should also receive an email a few minutes after your job processes, as well as a completion email when it is done. Sometimes, you will immediately receive an e-mail that the job has failed. This means there is something wrong with a script. To get to the bottom of this, you can input the command

$ tail -f slurm-_job####_.out

You will then view an error message like this. 
<img width="1379" alt="image" src="https://user-images.githubusercontent.com/86625869/190883644-115046fe-c435-45a4-a6fe-45a1e02af955.png">

You can react accordingly! 

After about 12 hours, you should receive an e-mail from the HPC that says your job is finished. On the interactive HPC grid, you can see a slurm####.out file with your job number. If you open that file, you can see some statistics on how your model improved over the training session. 

<img width="1262" alt="image" src="https://user-images.githubusercontent.com/86625869/191021924-c16f3e2d-5529-4fff-9f8f-76b8090fb5af.png">

The next step is going to be to evaluate your model. Essentially, when you labeled those intially extracted frames, the computer used some of them to train the system (the "train set") and saved some of them to test the initial model (the "test set"). You will need to create an evaluate_network.py and an evaluate_network.sh to be able to submit this to Slurm. See example in the repository. 

Once these files are created, use the $ sbatch command to evaluate. 

After about 12 hours, you should receive an e-mail from the HPC that says your job is finished. On the interactive HPC grid, you can see a slurm####.out file with your job number. If you open that file, you can see some statistics on how your model improved over the training session. 
