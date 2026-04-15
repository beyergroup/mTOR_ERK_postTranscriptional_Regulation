#!/bin/bash
#SBATCH --job-name=knit_extended
#SBATCH --output=knit_extended_%j.out
#SBATCH --error=knit_extended_%j.err
#SBATCH --time=24:00:00
#SBATCH --mem=64G


# Initialize conda
source ~/.bashrc  # Or your conda init file
source $(conda info --base)/etc/profile.d/conda.sh
conda activate R


# ── Paths ──
RMD_FILE="Code/02_Model_train_and_validation.Rmd"
OUT_DIR="Output"

mkdir -p "${OUT_DIR}"

echo "Starting knit at $(date)"
echo "R version: $(Rscript --version 2>&1)"

Rscript -e "
  rmarkdown::render(
    input       = '${RMD_FILE}',
    output_dir  = '${OUT_DIR}',
    output_file = 'Katrin_analysis_summary.html',
    envir       = new.env()
  )
"

echo "Finished at $(date)"
