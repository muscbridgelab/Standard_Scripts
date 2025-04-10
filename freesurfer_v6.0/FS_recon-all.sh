#####################################
#
# Freesurfer 6.0 recon-all 
# Ryn Thorn - 9.14.21
#
#####################################

export base=/Path/to/study/folder
ids=("a101" "a102" "a103")

for i in ${ids[@]} ; do 
  mkdir $base/${i}
  recon-all -all -i $base/T1.nii -sd $base/${i} -subjid ${i}
done

