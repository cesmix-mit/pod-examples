#!/bin/bash

#SBATCH --time=4:00:00             # WALLTIME
#SBATCH --account=FY150075       # WC ID
#SBATCH -N 1                     # Number of nodes
#SBATCH --job-name InP-PACE       # Name of job
#SBATCH -o job-%x.out
#SBATCH -e job-%x.err

nodes=$SLURM_JOB_NUM_NODES          # Number of nodes
cores=8                            # Number MPI processes to start on each node
                                    # choose 16 for skybridge, chama and uno
                                    # choose 36 for eclipse, ghost and attaway
                                    # choose 48 for manzano
cores_md=4
                                    
module purge
module load cde/v3/gcc/10.3.0
module load cde/v3/cmake/3.23.1
module load cde/v3/openmpi/4.1.2-gcc-10.3.0

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/projects/netpub/anaconda3/2022.05/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/projects/netpub/anaconda3/2022.05/etc/profile.d/conda.sh" ]; then
        . "/projects/netpub/anaconda3/2022.05/etc/profile.d/conda.sh"
    else
        export PATH="/projects/netpub/anaconda3/2022.05/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda init
conda activate fitsnap-pace
export OMP_NUM_THREADS=1
export PYTHONPATH="${HOME}/FitSNAP:$PYTHONPATH"
#export PYTHONPATH="/gpfs/adrohsk/FitSNAP:$PYTHONPATH"

#python -m fitsnap3 fitsnap-nn.in --overwrite
# TODO: parallel FitSNAP doesn't read atoms correctly! (maybe only for xyz scraper?)
#mpiexec --bind-to core --npernode $cores --n $(($nodes*$cores)) python -m fitsnap3 InP-example.in --overwrite 
#python -m fitsnap3 fitsnap-nn.in --overwrite
#python plot_force_comparison.py
#python plot_energy_comparison.py

#mpiexec --bind-to core --npernode $cores_md --n $(($nodes*$cores_md)) ${HOME}/lammps/build-fitsnap/lmp -in in.run 

#mpiexec --bind-to core --npernode $cores --n $(($nodes*$cores)) /projects/vasp/2020-build/clusters/vasp6.1.1/bin/vasp_gam
#mpiexec --bind-to core --npernode $cores --n $(($nodes*$cores)) /projects/vasp/2020-build/clusters/vasp6.1.1/bin/vasp_ncl
mpirun -np 36 python -m fitsnap3 InP-example.in --overwrite

#en_i="$(grep -n 'TOTEN' OUTCAR | tail -n1 | \
#  awk -F " " '{print $6}')"
#echo $en_i > enq.dat
