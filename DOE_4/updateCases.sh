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
    # 🔥 DOE (nur cp & lambda)
    # ==============================
    case $i in
        2)  lambdaCF=0.2; cpCF=2000 ;;
        3)  lambdaCF=0.2; cpCF=1000 ;;
        4)  lambdaCF=0.5; cpCF=1500 ;;
        5)  lambdaCF=0.5; cpCF=1000 ;;
        6)  lambdaCF=0.8; cpCF=1500 ;;
        7)  lambdaCF=0.8; cpCF=2000 ;;
        8)  lambdaCF=0.2; cpCF=1500 ;;
        9)  lambdaCF=0.5; cpCF=2000 ;;
        10) lambdaCF=0.5; cpCF=1500 ;;
        11) lambdaCF=0.8; cpCF=1000 ;;
    esac

    # ==============================
    # 🔥 ENTHALPIE (aus cp)
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