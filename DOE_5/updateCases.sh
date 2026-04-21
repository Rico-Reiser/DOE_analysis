#!/bin/bash

# =========================================
# BASISPFAD (WSL)
# =========================================
BASE=/home/rico-reiser/DOE/DOE_4

# =========================================
# KONSTANTE (BLEIBEN FIX)
# =========================================
rhoCF=1400
nuCF=3e-6
sigmaWC=0.05

# =========================================

for i in $(seq 2 11); do
    d="$BASE/run$i"
    echo ">>> updating run$i"

    # ==============================
    # DEFAULT WERTE
    # ==============================
    cpCF=1250
    lambdaCF=0.5

    # ==============================
    # update cp and lambda
    # ==============================
    case $i in
        1)  lambdaCF=0.55; cpCF=1000 ;;
        2)  lambdaCF=1.0; cpCF=2000 ;;
        3)  lambdaCF=0.55; cpCF=2000 ;;
        4)  lambdaCF=0.1; cpCF=1500 ;;
        5)  lambdaCF=0.1; cpCF=2000 ;;
        6)  lambdaCF=0.1; cpCF=1000 ;;
        7)  lambdaCF=0.55; cpCF=1500 ;;
        8)  lambdaCF=1.0; cpCF=1500 ;;
        9) lambdaCF=0.55; cpCF=1500 ;;
        10) lambdaCF=1.0; cpCF=1000 ;;
    esac

    # ==============================
    # enthalpy 
    # ==============================
    hCF=$(echo "-100 * $cpCF" | bc)

    # =========================================
    # solidificationProperties anpassen
    # =========================================
    awk -v cpCF="$cpCF" -v lambdaCF="$lambdaCF" '
    BEGIN { block="" }

    /^[[:space:]]*contactFluid/ { block="contactFluid"; print; next }

    block=="contactFluid" && /^[[:space:]]*cp/ {
        print "    cp            " cpCF ";"
        next
    }

    block=="contactFluid" && /^[[:space:]]*lambda/ {
        print "    lambda        " lambdaCF ";"
        next
    }

    /^[[:space:]]*}/ { print; block=""; next }
    { print }

    ' "$d/constant/solidificationProperties" > "$d/constant/tmp" \
    && mv "$d/constant/tmp" "$d/constant/solidificationProperties"

    # =========================================
    # setFieldsDict anpassen
    # =========================================
    sed -i "
/fieldValues/,/);/ {
    /alpha.contactFluid[[:space:]]\+1/,/h.contactFluid/ {
        s/\(h.contactFluid[[:space:]]*\)-\?[0-9.eE+-]\+/\1$hCF/
    }
}
" "$d/system/setFieldsDict"

done