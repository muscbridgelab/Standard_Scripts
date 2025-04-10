#####################################
#
# Norms for Freesurfer 6.0 outputs 
# Ryn Thorn - 2.5.21
#
#####################################

cd /Path/to/study/folder
export nomis=/Path/to/nomis/NOMIS/NOMIS/NOMIS.py
export subjdir=02_Data
export csv=01_Protocols/nomis_setup.csv
export output=04_Summary/NOMIS

mkdir $output

conda activate nomis
python $nomis -csv $csv -s $subjdir -o $output

