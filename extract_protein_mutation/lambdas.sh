#!/bin/bash

for run in run"$prod"a run"$prod"b run"$prod"c run"$prod"d run"$prod"e
do

rm -rf ../$run/tmp

mkdir -p ../$run/tmp

##----------------------------
END=$time
for((i=1;i<=END;i++))
do

# column1 column2 column3 
# frame_number time (ps) lambda_value

## extract every 100th line (based on my frequency of writing coordinates this corresponds to every 20 ps) {nsavc*time_step}
## the lambda cutoff used here is > 0.9 for dominant frame

# for block2 = wild type or reference
grep 'LAMBDA>' ../"$run"/output_"$i"_0 | awk 'NR%1000==0' | awk '$3>0.9 {print $1=$2/20, $2, $3}' > ../"$run"/tmp/wt_prod"$i".lam

# for block3 = mutation
grep 'LAMBDA>' ../"$run"/output_"$i"_0 | awk 'NR%1000==0' | awk '$4>0.9 {print $1=$2/20, $2, $4}' > ../"$run"/tmp/mut_prod"$i".lam

done
#-------------------------

#--------------------------------
for block in wt mut
do
END=$time
for((m=1;m<=END;m++))
do
export j=`wc -l ../$run/tmp/"$block"_prod"$m".lam | awk '{print $1}'`
#echo $j

end1=$j
for((k=1;k<=end1;k++))
do
export t=`awk '{print $1}' ../$run/tmp/"$block"_prod"$m".lam | sed -n ''$k'p'`
echo set f"$k" = $t >> ../$run/tmp/"$block"_frames"$m".dat
done

echo set end"$m" = $j >> ../$run/tmp/"$block"_frames"$m".dat

done

done
#--------------------------------
done
