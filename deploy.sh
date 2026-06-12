#!/bin/bash

#   I. Fetch inputs
# ===================
echo "--------------------------"
echo "  DOWNLOAD FORCING FILES  "
echo "--------------------------"

if [ ! -d "FORCING" ]; then mkdir FORCING; fi

if [ ! -f "INPUTS/ORCA2_ICE_v5.0.0.tar.gz" ]; then 
   wget "https://gws-access.jasmin.ac.uk/public/nemo/sette_inputs/r5.0.0/ORCA2_ICE_v5.0.0.tar.gz" -O FORCING/ORCA2_ICE_v5.0.0.tar.gz || exit 2
fi
if [ ! -f "INPUTS/ORCA_R2_zps_domcfg.nc" ]; then tar -xf ORCA2_ICE_v5.0.0.tar.gz .; fi
echo "   --> DONE DOWNLOAD"


#   II. Set up config
# =====================:
echo "----------------------------"
echo "   CREATE CONFIG ORCA2_PY   "
echo "----------------------------"

# config
touch ../work_cfgs.txt
if ! grep -qx "ORCA2_PY OCE ICE" ../work_cfgs.txt; then
    echo "ORCA2_PY OCE ICE" >> ../work_cfgs.txt
fi
cp arch-ORCA2_PY_GCC_CPL.fcm ../../arch/
echo "   --> DONE CONFIG"


#   III. Compile
# ================
echo "------------------"
echo "   COMPILE NEMO   "
echo "------------------"

../../makenemo -m ORCA2_PY_GCC_CPL -r ORCA2_PY -n ORCA2_PY -j 3 || exit 4

# just in case - reinit EXP00
for file in EXPREF/* job.ksh
   do
      cp $file EXP00/
   done
echo "   --> DONE COMPILE"
