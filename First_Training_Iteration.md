Now it is time for the first training iteration! Although the GUI provides some guidance, we do not follow their prompting exactly. We will first follow the "Extract Frames", "Label Data", and "Create Training Dataset" tabs before we submit to the high-powered computing grid, Slurm. 

Under the "Extract Frames" tab, make sure that the _config.yaml_ file for your project is correct; it should have been automatically created by DLC. We pretty much keep the preset conditions here, but you can note a few things. We are using _kmeans_ clustering to extract frames; that means that the computer will calculate 20 _centroids_ of frames that are as distinct from eachother as possible. A given cluster will include frames that are as similar to their centroid and as dissimilar from other centroids as possible. Basically, this clustering is a simple and unsuperivised way to extract representative frames. By doing so automatically, you are not only saving labor and computer stress, you are also reducing the possibility of user bias. 

Once you hit "OK", you can minimize the GUI to watch the terminal at work. There should be some sort of progress update as the frames are extracted (if you have selected openCV, which is preset). 

<img width="732" alt="image" src="https://user-images.githubusercontent.com/86625869/190879885-1d526a11-3f5e-4673-8ccd-5cc8adce8a36.png">

You will then receive a completion message. 

<img width="1057" alt="image" src="https://user-images.githubusercontent.com/86625869/190880260-335e96fb-cfb0-43cd-af3d-ef35d2783e2b.png">

You can note that DLC does not reccommend training on single videos. I have not followed this reccomendation exactly for 2 reasons: 1) These videos have thousands of frames, larger than many other behavioral data set and 2) later, when we get to R, we will combine models made from other starting videos as well, effectively using multiple videos but at a different point in the process. 

If you click over to the "Label Frames" tab, the "Labeling Toolbox" window should pop up once you click "Label Frames". 

<img width="1148" alt="image" src="https://user-images.githubusercontent.com/86625869/190880319-aba55a1e-ea41-4f9b-855e-994a6e73d82d.png">

Click "Load Frames", and you should be prompted with a folder where your labeling frames are stored. Click "Open", and after a second, an image of your OFT should appear in the Labeling Toolbox!

<img width="1094" alt="image" src="https://user-images.githubusercontent.com/86625869/190880937-1ea34c60-37a6-4600-8a8e-e3d3d1099870.png">

Now it is time to label your rat. The labeling system is a bit finicky, but it is a good idea to zoom in and navigate from there. *Be as precise as possible*, this step will greatly influence the accuracy of your model. I usually set the marker size to 3, right click to label the bodypart that is selected. Try to keep your body part labeling consistent. Here is a fully labeled rat. 

<img width="344" alt="image" src="https://user-images.githubusercontent.com/86625869/190881073-8329db73-579c-41b1-9e94-af76b7dd3c8e.png">

Click "save" and "quit" once you have gone through all the frames. 

Navigate to the "create training set" tab and click "OK". After a minute or so, you should see this notice pop up in terminal: 

<img width="926" alt="image" src="https://user-images.githubusercontent.com/86625869/190882851-09a99077-0a09-478c-b985-b6dcec3d7a32.png">

You are ready to submit your work to Slurm! 
