#!/bin/bash
#!/bin/bash
#SBATCH -J to_BLCA
#SBATCH -o out_err_files/MIDORI_to_BLCA_%A.out
#SBATCH -e out_err_files/MIDORI_to_BLCA_%A.err
#SBATCH --nodes=1
#SBATCH -t 24:00:00
#SBATCH -p short,defq
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bnguyen@gwu.edu

module load blast+
module load R/3.5.3

mkdir -p midori_blca
MIDORI_file="MIDORI_UNIQ_GB239_CO1_RAW.fasta"

grep ">" $MIDORI_file | sed -E 's/\..*$//' | sed 's/>//' | uniq > midori_blca/midori_accnos.txt

#Are there any duplicates?
sed -E 's/root.*$//' $MIDORI_file | awk '/^>/{f=!d[$1];d[$1]=1}f' > midori_blca/midori_blca_dedup.fasta

TMPDIR='.' Rscript gen_midori_blca_tax.R

makeblastdb -in midori_blca/midori_blca_dedup.fasta -dbtype nucl -parse_seqids -out midori_blca/midori_blca_blast

#makeblastdb -in $MIDORI_file  -dbtype nucl -parse_seqids -out midori_blca/midori_blca_blast
