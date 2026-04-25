#!/bin/bash
#SBATCH --job-name=R_rheo_1
#SBATCH --partition=haku
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --array=1-2%2
#SBATCH --time=15:00:00
#SBATCH --output=/bigwork/nhkffrei/solver_and_case/R_rheo_final/logs/slurm-%A_%a.out
#SBATCH --error=/bigwork/nhkffrei/solver_and_case/R_rheo_final/logs/slurm-%A_%a.err

set -e

module load GCC/11.2.0
module load OpenMPI/4.1.1
module load OpenFOAM/10

source $WM_PROJECT_DIR/etc/bashrc

RUN_ID=$SLURM_ARRAY_TASK_ID
CASE_DIR=$BIGWORK/solver_and_case/R_rheo_final/run${RUN_ID}

echo "JOB: $SLURM_JOB_ID"
echo "RUN: $RUN_ID"
echo "CASE: $CASE_DIR"

date

cd "$CASE_DIR" || { echo "Case not found"; exit 1; }


# Mesh

echo ">>> blockMesh"
blockMesh > log.blockMesh 2>&1 || exit 1


# Initialisierung

echo ">>> setFields"
setFields > log.setFields 2>&1 || exit 1

# Decomposition

echo ">>> decomposePar"
rm -rf processor*
decomposePar -force > log.decompose 2>&1 || exit 1

if [ ! -d "processor0" ]; then
    echo ">>> ERROR: decomposition failed"
    exit 1
fi


# Solver

echo ">>> solver (parallel)"
srun freezeFoam4 -parallel > log.run 2>&1


# Rekonstruktion

echo ">>> reconstruct"
reconstructPar > log.reconstruct 2>&1 || exit 1

touch case.foam

echo ">>> Simulation finished"


# ZIP 

cd "$BIGWORK/solver_and_case/R_rheo_final" || exit 1

ZIP_NAME="run${RUN_ID}.zip"

zip -r -1 -q "$ZIP_NAME" "run${RUN_ID}"

if [ -f "$ZIP_NAME" ]; then
    rm -rf "$CASE_DIR"
    echo ">>> ZIP ok, case deleted"
else
    echo ">>> ZIP failed → case kept"
fi

date