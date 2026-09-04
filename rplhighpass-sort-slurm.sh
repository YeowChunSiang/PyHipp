#!/bin/bash
#SBATCH --job-name=rplhps
#SBATCH --output=rplhps-slurm.%N.%j.out
#SBATCH --error=rplhps-slurm.%N.%j.err
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
pyh.RPLHighPass(saveLevel=1); \
from PyHipp import mountain_batch; \
mountain_batch.mountain_batch(); \
from PyHipp import export_mountain_cells; \
export_mountain_cells.export_mountain_cells(); \
print(time.localtime());"

conda deactivate
/data/src/PyHipp/envlist.py $envarg

