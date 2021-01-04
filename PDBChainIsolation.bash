#!/bin/bash

# Isolate specific CHAIN in PDB files
clear
printf "

PDBChainIsolation

Developed by: Tan Yong Chiang
Kindly mention in acknowledgement or citation if has helped your publication, thank you!

-----------------------------------------------------------------
"
printf "
Current Directory is %s
" $PWD
printf "
Enter Directory Containing PDB Files to be Converted:

"
read PdbDir

clear
printf "

PDBChainIsolation

Developed by: Tan Yong Chiang
Kindly mention in acknowledgement or citation if has helped your publication, thank you!

-----------------------------------------------------------------
"
printf "
Current Directory is %s
" $PWD
printf "
Enter OUTPUT Directory:

"
read OutputDir

clear
printf "

PDBChainIsolation

Developed by: Tan Yong Chiang
Kindly mention in acknowledgement or citation if has helped your publication, thank you!

-----------------------------------------------------------------
"
printf "
Current Directory is %s
" $PWD
printf "
Enter Location of Configuration File:

"
read ConfDir

clear

dos2unix $ConfDir

cd $PdbDir

while IFS= read -r file_line
do 
	PdbFileName=$(echo $file_line | awk -F "," '{print $1}')
	PdbChainID=$(echo $file_line | awk -F "," '{print $2}')
	OutputFileName="$PdbFileName"'_Chain'"$PdbChainID"
	awk '$1 ~ /HELIX/ {print $0}' $PdbDir/$PdbFileName'.pdb' > $OutputDir/$OutputFileName'.pdb'
	awk '$1 ~ /SHEET/ {print $0}' $PdbDir/$PdbFileName'.pdb' >> $OutputDir/$OutputFileName'.pdb'
	awk '$1 ~ /CISPEP/ {print $0}' $PdbDir/$PdbFileName'.pdb' >> $OutputDir/$OutputFileName'.pdb'
	awk -v awvar=$PdbChainID '$1 ~ /ATOM/ && $5 ~ awvar { print $0 }' $PdbDir/$PdbFileName'.pdb' >> $OutputDir/$OutputFileName'.pdb'
	awk '$1 ~ /CONECT/ {print $0}' $PdbDir/$PdbFileName'.pdb' >> $OutputDir/$OutputFileName'.pdb'
	echo "Done $OutputFileName"
done < $ConfDir

clear

printf "

-----------------------------------------------------------------

PDBChainIsolation

Developed by: Tan Yong Chiang
Kindly mention in acknowledgement or citation if has helped your publication, thank you!

-----------------------------------------------------------------

Done Conversion.




"