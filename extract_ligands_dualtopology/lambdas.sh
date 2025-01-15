#!/bin/bash

export nblocks=`cat ../nblocks`

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
## the lambda cutoff used here is > 0.98 for dominant frame
nblocks=$nblocks
for((n=1;n<=nblocks;n++))
do
# for block2 = wild type or reference
# first block starts from column 3
export k=`echo "scale = 2; ($n + 2)" | bc -l`

grep 'LAMBDA>' ../"$run"/output_"$i"_0 | awk 'NR%1000==0' | awk -v a="$k" '$a > 0.99 {print $1=$2/20, $2, $a}' > ../"$run"/tmp/block_"$n"_"$i".lam
done

done
#-------------------------

#--------------------------------

nblocks=$nblocks
for((n=1;n<=nblocks;n++))
do
END=$time
for((m=1;m<=END;m++))
do
export j=`wc -l ../$run/tmp/block_"$n"_"$m".lam | awk '{print $1}'`
#echo $j

end1=$j
for((k=1;k<=end1;k++))
do
export t=`awk '{print $1}' ../$run/tmp/block_"$n"_"$m".lam | sed -n ''$k'p'`
echo set f"$k" = $t >> ../$run/tmp/block_"$n"_frames"$m".dat
done

echo set end"$m" = $j >> ../$run/tmp/block_"$n"_frames"$m".dat

done

done


#--------------------------------
done
