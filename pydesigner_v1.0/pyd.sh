################################
#
# dicom convert and sort
# Ryn Thorn - 3.30.23
#
################################


export base=/Volumes/vdrive/helpern_users/benitez_a/PUMA/PUMA_Imaging_reorg
export analysis=/Volumes/vdrive/helpern_users/benitez_a/PUMA/PUMA_Analysis_reorg/pydesigner_v1.0
export nii=$base/PUMA_Imaging_reorg/03_nii
export pyd=$base/PUMA_Analysis_reorg/pydesigner_v1.0

BCyan='\033[1;36m' # Bold Cyan
BYellow='\033[1;33m' # Bold Yellow
BGreen='\033[1;32m' # Bold Green
NC='\033[0m' # No Color

read -p $'\033[1;36mEnter subject IDs to process separated only by a space (eg. M101 M102 M103):\e[0m ' SUBJ_IDs

for i in $SUBJ_IDs ; do 
  echo -e "${BYellow}Setting up files${NC}"
  mkdir -p $analysis/02_Data/${i}
  for f in nii bvec bval json ; do
    cp $base/03_nii/${i}/DKI_BIPOLAR_2.5mm_64dir_50slices.${f} $analysis/02_Data/${i}/DKI.${f}
  done
  for f in nii json ; do
    cp $base/03_nii/${i}/DKI_BIPOLAR_2.5mm_64dir_50slices_TOP_UP_PA.${f} $analysis/02_Data/${i}/DKI_TOPUP.${f}
  done
done
  
for i in $SUBJ_IDs ; do 
  mkdir $analysis/03_Analysis/${i}
  pydesigner -o $analysis/03_Analysis/${i} -s $analysis/02_Data/${i}/DKI.nii $analysis/02_Data/${i}/DKI_TOPUP.nii
done
