################################
#
# dicom convert and sort
# Ryn Thorn - 3.30.23
#
################################


export base=/Volumes/vdrive/helpern_users/benitez_a/PUMA/PUMA_Imaging_reorg
export dicom=$base/02_dicom
export nii=$base/03_nii

BCyan='\033[1;36m' # Bold Cyan
BYellow='\033[1;33m' # Bold Yellow
BGreen='\033[1;32m' # Bold Green
NC='\033[0m' # No Color

read -p $'\033[1;36mEnter subject IDs to process separated only by a space (eg. M101 M102 M103):\e[0m ' SUBJ_IDs

for i in $SUBJ_IDs ; do 
  echo -e "${BYellow}Unzipping ${i}${NC}"
  cp $base/00_zipped_archive/*${i}* $dicom
  unzip $dicom/*${i}.zip -d $dicom/${i}_d
  mkdir -p $nii/${i}
done
  
for i in $SUBJ_IDs ; do 
  echo -e "${BYellow}Converting ${i} dicoms to nifti${NC}"
  dcm2niix -f %p -v no -o $nii/${i} $dicom/${i}_d
done

for i in $SUBJ_IDs ; do 
  mv $dicom/${i}_d/*${i}/dicom $dicom/${i}
  rm $dicom/*${i}.zip
  rm -r $dicom/${i}_d
  echo -e "${BGreen}${i} processing complete!${NC}"
done