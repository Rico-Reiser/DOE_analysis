#!/bin/bash

BASE=~/DOE/DOE_3

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

for i in $(seq 1 27); do
    d="$BASE/run$i"
    echo ">>> updating run$i"

    # ==============================
    # 3³ DOE: rho, mu, sigma
    # ==============================

    case $i in
        # ---------- σ = 0.01 ----------
        1)  rhoCF=1400; muCF=0.03; sigmaWC=0.01 ;;
        2)  rhoCF=1600; muCF=0.03; sigmaWC=0.01 ;;
        3)  rhoCF=1800; muCF=0.03; sigmaWC=0.01 ;;
        4)  rhoCF=1400; muCF=0.045; sigmaWC=0.01 ;;
        5)  rhoCF=1600; muCF=0.045; sigmaWC=0.01 ;;
        6)  rhoCF=1800; muCF=0.045; sigmaWC=0.01 ;;
        7)  rhoCF=1400; muCF=0.06; sigmaWC=0.01 ;;
        8)  rhoCF=1600; muCF=0.06; sigmaWC=0.01 ;;
        9)  rhoCF=1800; muCF=0.06; sigmaWC=0.01 ;;

        # ---------- σ = 0.03 ----------
        10) rhoCF=1400; muCF=0.03; sigmaWC=0.03 ;;
        11) rhoCF=1600; muCF=0.03; sigmaWC=0.03 ;;
        12) rhoCF=1800; muCF=0.03; sigmaWC=0.03 ;;
        13) rhoCF=1400; muCF=0.045; sigmaWC=0.03 ;;
        14) rhoCF=1600; muCF=0.045; sigmaWC=0.03 ;;
        15) rhoCF=1800; muCF=0.045; sigmaWC=0.03 ;;
        16) rhoCF=1400; muCF=0.06; sigmaWC=0.03 ;;
        17) rhoCF=1600; muCF=0.06; sigmaWC=0.03 ;;
        18) rhoCF=1800; muCF=0.06; sigmaWC=0.03 ;;

        # ---------- σ = 0.05 ----------
        19) rhoCF=1400; muCF=0.03; sigmaWC=0.05 ;;
        20) rhoCF=1600; muCF=0.03; sigmaWC=0.05 ;;
        21) rhoCF=1800; muCF=0.03; sigmaWC=0.05 ;;
        22) rhoCF=1400; muCF=0.045; sigmaWC=0.05 ;;
        23) rhoCF=1600; muCF=0.045; sigmaWC=0.05 ;;
        24) rhoCF=1800; muCF=0.045; sigmaWC=0.05 ;;
        25) rhoCF=1400; muCF=0.06; sigmaWC=0.05 ;;
        26) rhoCF=1600; muCF=0.06; sigmaWC=0.05 ;;
        27) rhoCF=1800; muCF=0.06; sigmaWC=0.05 ;;
    esac

    # ==============================
    # kinematische Viskosität berechnen
    # ==============================
    nuCF=$(awk "BEGIN {printf \"%.6e\", $muCF/$rhoCF}")

    # feste Werte (kannst du auch DOE machen wenn du willst)
    cpCF=1250
    lambdaCF=0.5
    hCF=-130000

    # =========================================
    # transportProperties
    # =========================================
    awk -v rhoW="$rhoW" -v nuW="$nuW" \
        -v rhoA="$rhoA" -v nuA="$nuA" \
        -v rhoCF="$rhoCF" -v nuCF="$nuCF" '
    BEGIN { block="" }

    /^[[:space:]]*water[[:space:]]*$/        { block="water"; print; next }
    /^[[:space:]]*air[[:space:]]*$/          { block="air"; print; next }
    /^[[:space:]]*contactFluid[[:space:]]*$/ { block="contactFluid"; print; next }

    block=="water" && /^[[:space:]]*rho/ { print "    rho             " rhoW ";"; next }
    block=="water" && /^[[:space:]]*nu/  { print "    nu              " nuW ";";  next }

    block=="air" && /^[[:space:]]*rho/ { print "    rho             " rhoA ";"; next }
    block=="air" && /^[[:space:]]*nu/  { print "    nu              " nuA ";";  next }

    block=="contactFluid" && /^[[:space:]]*rho/ { print "    rho             " rhoCF ";"; next }
    block=="contactFluid" && /^[[:space:]]*nu/  { print "    nu              " nuCF ";";  next }

    /^[[:space:]]*}/ { block=""; print; next }
    { print }
    ' "$d/constant/transportProperties" > "$d/constant/tmp" \
    && mv "$d/constant/tmp" "$d/constant/transportProperties"

    # =========================================
    # solidificationProperties
    # =========================================
    awk -v rhoCF="$rhoCF" -v cpCF="$cpCF" -v lambdaCF="$lambdaCF" '
    BEGIN { block="" }
    /^[[:space:]]*contactFluid/ { block="contactFluid"; print; next }

    block=="contactFluid" && /^[[:space:]]*rho/    { sub(/[0-9.eE+-]+/, rhoCF); print; next }
    block=="contactFluid" && /^[[:space:]]*cp/     { sub(/[0-9.eE+-]+/, cpCF);  print; next }
    block=="contactFluid" && /^[[:space:]]*lambda/ { sub(/[0-9.eE+-]+/, lambdaCF); print; next }

    /^[[:space:]]*}/ { print; block=""; next }
    { print }
    ' "$d/constant/solidificationProperties" > "$d/constant/tmp" \
    && mv "$d/constant/tmp" "$d/constant/solidificationProperties"

    # =========================================
    # phaseProperties (σ)
    # =========================================
    awk -v sigmaWC="$sigmaWC" '
    {
        if (match($0, /\([[:space:]]*(water[[:space:]]+contactFluid|contactFluid[[:space:]]+water)[[:space:]]*\)/)) {
            prefix = substr($0, 1, RSTART+RLENGTH)
            rest   = substr($0, RSTART+RLENGTH)
            sub(/^[[:space:]]*[0-9.eE+-]+/, "", rest)
            print prefix " " sigmaWC rest
            next
        }
        print
    }
    ' "$d/constant/phaseProperties" > "$d/constant/tmp" \
    && mv "$d/constant/tmp" "$d/constant/phaseProperties"


done