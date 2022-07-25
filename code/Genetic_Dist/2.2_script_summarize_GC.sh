echo "p1 p2 rg se z p h2_obs h2_obs_se h2_int h2_int_se gcov_int gcov_int_se" > /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/data/Genetic_Dist/mod/Genetic_Correlation_of_UKB_diseases.txt
for i in /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/code/Genetic_Dist/Cor/Cor_* ; do
  val=$(cat $i | grep '^/opt.*sumstat' | cut -d" " -f4-)
  d1=$( echo $i | sed 's/.*Cor_//' | sed 's/_.*//')
  d2=$( echo $i | sed 's/.*Cor.*_//' | sed 's/.log//')
  echo $d1 $d2 $val >> /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/data/Genetic_Dist/mod/Genetic_Correlation_of_UKB_diseases.txt
done 
