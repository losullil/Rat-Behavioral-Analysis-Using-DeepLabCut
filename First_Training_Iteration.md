Now it is time for the first training iteration! Although the GUI provides some guidance, we do not follow their prompting exactly. We will first follow the "Extract Frames", "Label Data", and "Create Training Dataset" tabs before we submit to the high-powered computing grid, Slurm. 

Under the "Extract Frames" tab, make sure that the _config.yaml_ file for your project is correct; it should have been automatically created by DLC. We pretty much keep the preset conditions here, but you can note a few things. We are using _kmeans_ clustering to extract frames; that means that the computer will calculate 20 _centroids_ of frames that are as distinct from eachother as possible. A given cluster will include frames that are as similar to their centroid and as dissimilar from other centroids as possible. Basically, this clustering is a simple and unsuperivised way to extract representative frames. By doing so automatically, you are not only saving labor and computer stress, you are also reducing the possibility of user bias. 

Once you hit "OK", you can minimize the GUI to watch the terminal at work. There should be some sort of progress update as the frames are extracted. 

<img width="732" alt="image" src="https://user-images.githubusercontent.com/86625869/190879885-1d526a11-3f5e-4673-8ccd-5cc8adce8a36.png">

