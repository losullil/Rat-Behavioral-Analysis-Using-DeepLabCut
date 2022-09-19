#!/bin/bash
#SBATCH --mail-type=BEGIN,END,FAIL

source /mnt/local/python-venv/dlc-2.2.1/bin/activate
export DLClight="True";
python 'evaluate_network.py'
