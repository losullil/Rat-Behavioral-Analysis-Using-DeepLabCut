#!/bin/bash
#SBATCH --mail-type=BEGIN,END,FAIL
source /mnt/local/python-venv/dlc-2.2.1-gui/bin/activate
export DLClight="True";
python train_network.py
