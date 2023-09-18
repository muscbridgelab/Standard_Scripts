################################
#
# PyDesigner processing
# Ryn Thorn - 3.30.23
#
################################

BCyan='\033[1;36m' # Bold Cyan
BYellow='\033[1;33m' # Bold Yellow
BGreen='\033[1;32m' # Bold Green
NC='\033[0m' # No Color

read -p $'\033[1;36mEnter subject IDs to process separated only by a space (eg. M101 M102 M103):\e[0m ' SUBJ_IDs
read -p $'\033[1;36mEnter path to study folder (the main folder housing all of your files for this process):\e[0m ' base
read -p $'\033[1;36mEnter DKI file name to process INCLUDING file extension. Eg. DKI_30.nii or DKI_BIPOLAR_2.5_64dir_50slices.nii.gz or etc:\e[0m ' DKI
read -p $'\033[1;36mEnter TOPUP file name to process INCLUDING file extension. Eg. DKI_30_TOPUP.nii or DKI_BIPOLAR_2.5_64dir_50slices_TOPUP.nii.gz or etc (leave blank if subject does not have TOPUP data):\e[0m ' TOPUP

mkdir -p $base/03_Analysis

for i in $SUBJ_IDs ; do 
  echo -e "${BYellow}Beginning file prep ${i}${NC}"
  mkdir -p $base/03_Analysis/${i}
  cp $base/02_Data/${i}/**/$DKI $base/03_Analysis/${i}/DKI.nii
  DKIn=$base/03_Analysis/${i}/DKI.nii
  [ -f $base/02_Data/${i}/**/$TOPUP ] && cp $base/02_Data/${i}/**/$TOPUP $base/03_Analysis/${i}/DKI_TOPUP.nii
  TOPUPn=$base/03_Analysis/${i}/DKI_TOPUP.nii
  inputs="$DKIn $TOPUPn"
  echo -e "${BYellow}Beginning PyDesigner for ${i}${NC}"
  conda activate dmri
  pydesigner -o $base/03_Analysis/${i} -s $inputs
done
