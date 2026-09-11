#!/bin/bash
#SBATCH --job-name=rpllfp
#SBATCH --output=rpllfp-slurm.%N.%j.out
#SBATCH --error=rpllfp-slurm.%N.%j.err
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
pyh.RPLLFP(saveLevel=1); \
print(time.localtime());"

conda deactivate
/data/src/PyHipp/envlist.py $envarg

