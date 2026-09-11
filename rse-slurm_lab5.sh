#!/bin/bash
#SBATCH --job-name=rse
#SBATCH --output=rse-slurm.%N.%j.out
#SBATCH --error=rse-slurm.%N.%j.err
#SBATCH --partition=queue1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/data/miniconda3/bin/conda init
source ~/.bashrc
envarg=`/data/src/PyHipp/envlist.py`
conda activate $envarg

python -u -c "import PyHipp as pyh; \
import time; \
import os; \
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"

conda deactivate
/data/src/PyHipp/envlist.py $envarg

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:106088256647:awsnotify --message "rseJobDone"
