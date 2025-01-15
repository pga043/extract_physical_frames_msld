#!/bin/bash


grep 'ATOM' ../../prep/core.pdb | awk '{print $3}' > core.dat

END=9 #`cat ../nblocks`
for((i=1;i<=END;i++))
do
grep 'ATOM' ../../prep/site1_sub"$i"_frag.pdb | awk '{print $3}' > sub"$i".dat
done

rm sub8.dat
mv sub9.dat sub8.dat


#rm *.str

END1=`cat ../../nblocks`
for((i=1;i<=END1;i++))
#for i in 1
do
echo "* ATOM NAMES for a particular ligand" > lig"$i".str
echo "* CORE + SUB" >> lig"$i".str
echo "*" >> lig"$i".str 
echo >> lig"$i".str
echo "define lig"$i "-" >> lig"$i".str
echo "  select ( -" >> lig"$i".str
while read p
do
echo "  atom LIG 1" $p ".or. -" >> lig"$i".str
done < <(cat core.dat)

while read q
do
echo "  atom LIG 1" $q ".or. -" >> lig"$i".str
done < <(cat sub"$i".dat)

echo "  none ) end" >> lig"$i".str

done

#rm *.dat

