################################
#
# dicom convert and sort
# Ryn Thorn - 3.30.23
# MacOS 12.4
# Requires simple-dicom-sort and dcm2niix
# 
################################

BCyan='\033[1;36m' # Bold Cyan
BYellow='\033[1;33m' # Bold Yellow
BGreen='\033[1;32m' # Bold Green
NC='\033[0m' # No Color

read -p $'\033[1;36mEnter path to main study folder:\e[0m ' base
read -p $'\033[1;36mEnter subject IDs to process separated only by a space (eg. M101 M102 M103):\e[0m ' SUBJ_IDs

export dicom=$base/02_dicom
export nii=$base/03_nii

mkdir -p $dicom
mkdir -p $nii

for i in $SUBJ_IDs ; do 
# Unzipping and folder setup
  echo -e "${BYellow}Unzipping ${i}${NC}"
  cp $base/00_zipped_archive/*${i}* $dicom
  unzip $dicom/*${i}.zip -d $dicom/${i}_d
  mkdir -p $nii/${i}

# Sorting dicoms  

  dicom_sort $base/02_dicom/Y4/${i}/temp $base/02_dicom/Y4/${i} %SeriesName%

# Converting dicoms to nifti
 
  echo -e "${BYellow}Converting ${i} dicoms to nifti${NC}"
  dcm2niix -f %p -v no -o $nii/${i} $dicom/${i}_d

# Folder clean up

  mv $dicom/${i}_d/*${i}/dicom $dicom/${i}
  rm $dicom/*${i}.zip
  rm -r $dicom/${i}_d
  echo -e "${BGreen}${i} processing complete!${NC}"
done