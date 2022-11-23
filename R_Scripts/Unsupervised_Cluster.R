#be sure to cd into the dirctory where this file is stored, and create future pathways based on being in this folder
library(sp)         #tested with v1.3-2
library(imputeTS)   #tested with v3.0
library(ggplot2)    #tested with v3.1.0
library(ggmap)      #tested with v3.0.0
library(data.table) #tested with v1.12.8
library(cowplot)    #tested with v0.9.4
library(corrplot)   #tested with v0.84
library(keras) 
library(writexl)
#note: I had all of these libraries installed in the HPC prior to my use. However, if they need to be updated, you will have to reach out to HPC admin (currently Dj) for them to install.
source("/mnt/research/jhoneycu/losulliv/DLCAnalyzer/R/DLCAnalyzer_Functions_final.R", encoding = 'UTF-8')
input_folder <- "KAT_OFT_R3/KAT_OFT_R3-lucyosullivan-2022-09-20/ALL_HALVES/"
files <- list.files(input_folder) 
#you will need to manually move all noncsv files OUT of this folder. This can be done in the interface. 
CreateSkelData <- function(t){
  if(!IsTrackingData(t)){
    stop("Object is not of type TrackingData")
  }
  dat <- data.frame(S1 = GetDistances(t,"nose","head_center"))
  dat$S2 <- GetDistances(t,"head_center","neck")
  dat$S3 <- GetDistances(t,"neck","body_center")
  dat$S4 <- GetDistances(t,"body_center","right_side")
  dat$S5 <- GetDistances(t,"body_center","left_side")
  dat$S6 <- GetDistances(t,"body_center","tail_base")
  dat$S7 <- GetDistances(t,"tail_base","right_hip")
  dat$S8 <- GetDistances(t,"tail_base","left_hip")
  dat$S9 <- GetDistances(t,"tail_base","tail_center")
  dat$S10 <- GetDistances(t,"tail_center","tail_tip")
  dat$A1 <- GetAngleTotal(t,"tail_base","tail_center","tail_center","tail_tip")
  dat$A2 <- GetAngleTotal(t,"right_hip","tail_base","tail_base","left_hip")
  dat$A3 <- GetAngleTotal(t,"tail_base","body_center","body_center","neck")
  dat$A4 <- GetAngleTotal(t,"right_side","body_center","body_center","left_side")
  dat$A5 <- GetAngleTotal(t,"body_center","neck","neck","head_center")
  dat$A6 <- GetAngleTotal(t,"tail_base","body_center","neck","head_center")
  dat$Ar1 <- GetPolygonAreas(t,c("tail_base","right_hip","left_hip"))
  dat$Ar2 <- GetPolygonAreas(t,c("right_hip","left_hip","left_side","right_side"))
  dat$Ar3 <- GetPolygonAreas(t,c("right_side","right_ear","left_ear","left_side"))
  dat$Ar4 <- GetPolygonAreas(t,c("right_ear","nose","left_ear"))
  dat <- as.data.frame(dat) 
  t$features <- dat
  return(t)
}
#be sure that the names in the skeleton correlate with your labels!
pipeline <- function(path){
  Tracking <- ReadDLCDataFromCSV(file = path, fps = 30)
  Tracking <- CutTrackingData(Tracking, end = 300) #cutoff last 10s in frames
  Tracking <- CalibrateTrackingData(Tracking, method = "ratio", ratio = 126/1)
  Tracking <- CleanTrackingData(Tracking, likelihoodcutoff = 0.95)
  Tracking <- CreateSkelData(Tracking) #references my points and creates features for the test set
  Tracking <- CreateTestSet(Tracking, integration_period = 22) #sets integration period between 0.5-1.0s
  Tracking <- AddBinData(Tracking,unit = "minute", binlength = 5) #five minute time bins appropriate for USV playback, but I couldn't get it to work :(
  return(Tracking)
}

TrackingAll <- RunPipeline(files,input_folder,FUN = pipeline)

TrackingAll <- UnsupervisedClusteringKmeans(TrackingAll,N_clusters = 19,Z_score_Normalize = TRUE)

PlotLabels.Multi.PDF(TrackingAll)
#this will be stored under LabelsMulti.pdf in your file. Note that it will replace itself if you run the function again, so download it externally if you wish to keep it. 

#There is definitely a loop to print out all of these commands. It would not work for me, because the ETHZ RScripts I was working with have this data as a list of a list. So, I took advantage of CtrlF to edit this. Then, I used excel to align each section next to its video and sort them by condition. 

#SALMELASIL
LabelReport(TrackingAll$OFT_5000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_11000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_14000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_24000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_28000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_49000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_61000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_64000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_70000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALMCONSIL
LabelReport(TrackingAll$OFT_16000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_19000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_36000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_43000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_53000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_54000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_58000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_73000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALFELASIL
LabelReport(TrackingAll$OFT_8000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_12000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_15000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_26000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_31000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_41000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_50000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_63000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_72000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALFCONSIL
LabelReport(TrackingAll$OFT_3000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_17000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_18000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_23000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_35000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_59000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_69000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_74000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_75000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATMELASIL
LabelReport(TrackingAll$OFT_6000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_7000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_25000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_29000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_30000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_40000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_48000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_51000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_62000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_65000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_79000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATMCONSIL
LabelReport(TrackingAll$OFT_2000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_20000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_21000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_33000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_37000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_44000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_46000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_55000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_57000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_68000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_77000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATFELASIL
LabelReport(TrackingAll$OFT_8000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_13000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_27000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_32000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_42000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_52000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_66000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_67000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_71000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_80000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_81000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATFCONSIL
LabelReport(TrackingAll$OFT_10000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_22000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_34000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_38000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_39000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_45000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_47000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_60000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_76000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_78000DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALMELAUSV
LabelReport(TrackingAll$OFT_5001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_11001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_14001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_24001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_28001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_49001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_61001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_64001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_70001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALMCONUSV
LabelReport(TrackingAll$OFT_16001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_19001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_36001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_43001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_53001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_54001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_58001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_73001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALFELAUSV
LabelReport(TrackingAll$OFT_8001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_12001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_15001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_26001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_31001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_41001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_50001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_63001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_72001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#SALFCONUSV
LabelReport(TrackingAll$OFT_3001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_17001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_18001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_23001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_35001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_59001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_69001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_74001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_75001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATMELAUSV
LabelReport(TrackingAll$OFT_5001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_7001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_25001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_29001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_30001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_40001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_48001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_51001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_62001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_65001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_79001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATMCONUSV
LabelReport(TrackingAll$OFT_2001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_20001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_21001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_33001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_37001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_44001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_46001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_55001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_57001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_68001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_77001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATFELAUSV
LabelReport(TrackingAll$OFT_9001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv) 
LabelReport(TrackingAll$OFT_13001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_27001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_32001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_42001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_52001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_66001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_67001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_71001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_80001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_81001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#KATFCONUSV
LabelReport(TrackingAll$OFT_10001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_22001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_34001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_38001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_39001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_45001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_47001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_60001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_76001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)
LabelReport(TrackingAll$OFT_78001DLC_resnet50_KAT_OFT_R3Sep20shuffle1_200000.csv)

#you will get an "Unsupervised_Cluster.Rout" file as an output for this. It is HUGE. I copied it into excel and manipulated excel to then paste transpose it into Prism. There is definitely a more efficient way. 
