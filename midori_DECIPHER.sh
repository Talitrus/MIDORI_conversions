#!/bin/bash
#!/bin/bash
#SBATCH -J retax
#SBATCH -o out_err_files/retax_%A.out
#SBATCH -e out_err_files/retax_%A.err
#SBATCH --nodes=1
#SBATCH -t 06:00:00
#SBATCH -p defq,short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bnguyen@gwu.edu

module load R

TMPDIR='.' Rscript midori2DECIPHER.R
