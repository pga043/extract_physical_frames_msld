# extract_physical_frames_MS&#03bb;D
1. Make a new directory within your main direcotry containing all the different run directories.
2. The README file has three portions \
   i). lambdas.sh => this script will try to extract lambda values from output_*_0 file corresponding to the saving frequecny of \
                     dcd file \
   ii). traj_extract.inp => this CHARMM file will merge all the dominant frames from different dcds within a given replica. \
                            Example: dcd_1, dcd_2, dcd_3 and so on witihn run82a \
                            so, by the end you would have generated 5 dcds files corresponding to 5 replicas. \

   iii). orient.inp => this will orient and merge the 5 dcd files into one dcd file. \


So, this is for protein mutation, single site with single mutation (but, it will be same procedure for more mutations at a single site).

In the end, you will get two trajectories, one for WT and one for mutant which have dominant frames from x runs (production runs) in 5 replicas or however many replicas that you ran.
