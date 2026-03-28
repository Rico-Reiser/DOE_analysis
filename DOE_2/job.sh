#!/bin/bash
#SBATCH --job-name=DOE_2
#SBATCH --partition=haku
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --array=1-32%12
#SBATCH --time=20:00:00
#SBATCH --output=/bigwork/nhkffrei/solver_and_case/DOE_2/logs/slurm-%A_%a.out
#SBATCH --error=/bigwork/nhkffrei/solver_and_case/DOE_2/logs/slurm-%A_%a.err

set -e

module purge
module load GCC/11.2.0
module load OpenMPI/4.1.1
module load OpenFOAM/10

source $WM_PROJECT_DIR/etc/bashrc

# ==============================
# Pfade
# ==============================

RUN_ID=$SLURM_ARRAY_TASK_ID
CASE_DIR=$BIGWORK/solver_and_case/DOE_2/run${RUN_ID}

echo "JOB: $SLURM_JOB_ID"
echo "RUN: $RUN_ID"
echo "CASE: $CASE_DIR"

date

cd "$CASE_DIR" || { echo "Case not found"; exit 1; }

# ==============================
# Mesh
# ==============================

echo ">>> blockMesh"
blockMesh > log.blockMesh 2>&1

# ==============================
# Initialisierung
# ==============================

echo ">>> setFields"
setFields > log.setFields 2>&1

# ==============================
# Decomposition
# ==============================

echo ">>> decomposePar"
rm -rf processor*
decomposePar -force > log.decompose 2>&1

if [ ! -d "processor0" ]; then
    echo ">>> ERROR: decomposition failed"
    exit 1
fi

# ==============================
# Solver (ORIGINAL mit srun)
# ==============================

echo ">>> solver (parallel)"
srun freezeFoam4 -parallel > log.run 2>&1

# ==============================
# Rekonstruktion
# ==============================

echo ">>> reconstruct"
reconstructPar > log.reconstruct 2>&1

touch case.foam

echo ">>> Simulation finished"

# ==============================
# ZIP-KOMPRIMIERUNG
# ==============================

echo ">>> Compressing results..."

cd "$BIGWORK/solver_and_case/DOE_2" || exit 1

ZIP_NAME="run${RUN_ID}.zip"

rm -f "$ZIP_NAME"

if [ ! -d "run${RUN_ID}" ]; then
    echo ">>> error: run${RUN_ID} not found for zip"
    exit 1
fi

zip -r -1 -q "$ZIP_NAME" "run${RUN_ID}"

echo ">>> ZIP created: $ZIP_NAME"

# ==============================
# OPTIONAL: Speicher sparen
# ==============================

rm -rf "$CASE_DIR"
echo ">>> Original case deleted (only ZIP remains)"

date