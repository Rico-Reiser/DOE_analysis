#!/bin/bash

BASE=~/freezeCase/freezeFoam4/DOE_2

# =========================================
# CONSTANT VALUES
# =========================================

# water
rhoW=1100
nuW=1.81e-5

# air
rhoA=1.2
nuA=1.5e-5

# =========================================

for i in $(seq 1 32); do
    d="$BASE/run$i"
    echo ">>> updating run$i"

    # ==============================
    # DOE PARAMETER (contactFluid)
    # ==============================

case $i in
    1)  cpCF=1220; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.01; hCF=-122000 ;;
    2)  cpCF=1220; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.01; hCF=-122000 ;;
    3)  cpCF=1220; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=1;   sigmaWC=0.01; hCF=-122000 ;;
    4)  cpCF=1220; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=1;   sigmaWC=0.01; hCF=-122000 ;;

    5)  cpCF=1220; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.1; hCF=-122000 ;;
    6)  cpCF=1220; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.1; hCF=-122000 ;;
    7)  cpCF=1220; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=1;   sigmaWC=0.1; hCF=-122000 ;;
    8)  cpCF=1220; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=1;   sigmaWC=0.1; hCF=-122000 ;;

    9)  cpCF=1300; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.01; hCF=-130000 ;;
    10) cpCF=1300; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.01; hCF=-130000 ;;
    11) cpCF=1300; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=1;   sigmaWC=0.01; hCF=-130000 ;;
    12) cpCF=1300; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=1;   sigmaWC=0.01; hCF=-130000 ;;

    13) cpCF=1300; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.1; hCF=-130000 ;;
    14) cpCF=1300; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.1; hCF=-130000 ;;
    15) cpCF=1300; nuCF=2.85714e-6; rhoCF=1430; lambdaCF=1;   sigmaWC=0.1; hCF=-130000 ;;
    16) cpCF=1300; nuCF=2.22222e-6; rhoCF=1781; lambdaCF=1;   sigmaWC=0.1; hCF=-130000 ;;

    17) cpCF=1220; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.01; hCF=-122000 ;;
    18) cpCF=1220; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.01; hCF=-122000 ;;
    19) cpCF=1220; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=1;   sigmaWC=0.01; hCF=-122000 ;;
    20) cpCF=1220; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=1;   sigmaWC=0.01; hCF=-122000 ;;

    21) cpCF=1220; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.1; hCF=-122000 ;;
    22) cpCF=1220; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.1; hCF=-122000 ;;
    23) cpCF=1220; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=1;   sigmaWC=0.1; hCF=-122000 ;;
    24) cpCF=1220; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=1;   sigmaWC=0.1; hCF=-122000 ;;

    25) cpCF=1300; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.01; hCF=-130000 ;;
    26) cpCF=1300; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.01; hCF=-130000 ;;
    27) cpCF=1300; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=1;   sigmaWC=0.01; hCF=-130000 ;;
    28) cpCF=1300; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=1;   sigmaWC=0.01; hCF=-130000 ;;

    29) cpCF=1300; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=0.1; sigmaWC=0.1; hCF=-130000 ;;
    30) cpCF=1300; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=0.1; sigmaWC=0.1; hCF=-130000 ;;
    31) cpCF=1300; nuCF=4.28571e-5; rhoCF=1430; lambdaCF=1;   sigmaWC=0.1; hCF=-130000 ;;
    32) cpCF=1300; nuCF=3.33333e-5; rhoCF=1781; lambdaCF=1;   sigmaWC=0.1; hCF=-130000 ;;
esac

    # =========================================
    # transportProperties
    # =========================================
    awk \
        -v rhoW="$rhoW" -v nuW="$nuW" \
        -v rhoA="$rhoA" -v nuA="$nuA" \
        -v rhoCF="$rhoCF" -v nuCF="$nuCF" '
        BEGIN { block="" }
        /^[[:space:]]*water[[:space:]]*$/        { block="water"; print; next }
        /^[[:space:]]*air[[:space:]]*$/          { block="air"; print; next }
        /^[[:space:]]*contactFluid[[:space:]]*$/ { block="contactFluid"; print; next }

        block=="water" && /^[[:space:]]*rho/ { sub(/[0-9.eE+-]+/, rhoW); print; next }
        block=="water" && /^[[:space:]]*nu/  { sub(/[0-9.eE+-]+/, nuW);  print; next }

        block=="air" && /^[[:space:]]*rho/ { sub(/[0-9.eE+-]+/, rhoA); print; next }
        block=="air" && /^[[:space:]]*nu/  { sub(/[0-9.eE+-]+/, nuA);  print; next }

        block=="contactFluid" && /^[[:space:]]*rho/ { sub(/[0-9.eE+-]+/, rhoCF); print; next }
        block=="contactFluid" && /^[[:space:]]*nu/  { sub(/[0-9.eE+-]+/, nuCF);  print; next }

        /^[[:space:]]*}/ { print; block=""; next }
        { print }
    ' "$d/constant/transportProperties" > "$d/constant/tmp" && mv "$d/constant/tmp" "$d/constant/transportProperties"

    # =========================================
    # solidificationProperties
    # =========================================
    awk \
        -v rhoCF="$rhoCF" -v cpCF="$cpCF" -v lambdaCF="$lambdaCF" '
        BEGIN { block="" }
        /^[[:space:]]*contactFluid/ { block="contactFluid"; print; next }

        block=="contactFluid" && /^[[:space:]]*rho/    { sub(/[0-9.eE+-]+/, rhoCF); print; next }
        block=="contactFluid" && /^[[:space:]]*cp/     { sub(/[0-9.eE+-]+/, cpCF);  print; next }
        block=="contactFluid" && /^[[:space:]]*lambda/ { sub(/[0-9.eE+-]+/, lambdaCF); print; next }

        /^[[:space:]]*}/ { print; block=""; next }
        { print }
    ' "$d/constant/solidificationProperties" > "$d/constant/tmp" && mv "$d/constant/tmp" "$d/constant/solidificationProperties"

    # =========================================
    # phaseProperties
    # =========================================
awk -v sigmaWC="$sigmaWC" '
{
    line = $0

    # match beide Varianten: (water contactFluid) oder (contactFluid water)
    if (match(line, /\([[:space:]]*(water[[:space:]]+contactFluid|contactFluid[[:space:]]+water)[[:space:]]*\)/)) {

        pos = RSTART + RLENGTH   # Position NACH ")"

        prefix = substr(line, 1, pos)
        rest   = substr(line, pos)

        # entferne alte Zahl am Anfang von rest
        sub(/^[[:space:]]*[0-9.eE+-]+/, "", rest)

        # baue neu zusammen
        print prefix " " sigmaWC rest
        next
    }

    print
}
' "$d/constant/phaseProperties" > "$d/constant/tmp" \
&& mv "$d/constant/tmp" "$d/constant/phaseProperties"
    # =========================================
    # setFieldsDict (NEU)
    # =========================================
    sed -i "
/fieldValues/,/);/ {
    /alpha.contactFluid[[:space:]]\+1/,/h.contactFluid/ {
        s/\(h.contactFluid[[:space:]]*\)-\?[0-9.eE+-]\+/\1$hCF/
    }
}
" "$d/system/setFieldsDict"
done
