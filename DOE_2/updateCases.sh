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
    # transportProperties (OK)
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
    #  physicalProperties.contactFluid
    # =========================================
    # =========================================
#  physicalProperties.contactFluid
# =========================================

cd ~/DOE/DOE_2 || exit 1

for i in $(seq 1 32); do
    d="run$i"

    echo ">>> fixing $d"

    # ==============================
    # DOE Werte
    # ==============================
    case $i in
        # niedrige ν
        1|3|5|7|9|11|13|15)   nuCF=2.85714e-6 ;;
        2|4|6|8|10|12|14|16) nuCF=2.22222e-6 ;;

        # hohe ν
        17|19|21|23|25|27|29|31) nuCF=4.28571e-5 ;;
        18|20|22|24|26|28|30|32) nuCF=3.33333e-5 ;;
    esac

    case $i in
        # rho = -1
        1|3|5|7|9|11|13|15|17|19|21|23|25|27|29|31)
            rhoCF=1430 ;;

        # rho = +1
        2|4|6|8|10|12|14|16|18|20|22|24|26|28|30|32)
            rhoCF=1781 ;;
    esac

    # ==============================
    # physicalProperties fix
    # ==============================
    awk -v nuCF="$nuCF" -v rhoCF="$rhoCF" '
    /^[[:space:]]*rho[[:space:]]/ {
        print "    rho     [1 -3 0 0 0 0 0] " rhoCF ";"
        next
    }
    /^[[:space:]]*nu[[:space:]]/ {
        print "    nu      [0 2 -1 0 0 0 0] " nuCF ";"
        next
    }
    { print }
    ' "$d/constant/physicalProperties.contactFluid" > "$d/tmp" \
    && mv "$d/tmp" "$d/constant/physicalProperties.contactFluid"

done
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
    # phaseProperties
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

    # =========================================
    # setFieldsDict
    # =========================================
    sed -i "
/fieldValues/,/);/ {
    /alpha.contactFluid[[:space:]]\+1/,/h.contactFluid/ {
        s/\(h.contactFluid[[:space:]]*\)-\?[0-9.eE+-]\+/\1$hCF/
    }
}
" "$d/system/setFieldsDict"

done