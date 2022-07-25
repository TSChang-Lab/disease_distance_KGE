all=$(ls /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/data/Genetic_Dist/raw/GWAS_SUMSTAT/*sumstats*)
ntot=$(echo $all | awk '{print NF}')
i=$1
for j in $(seq 1 $ntot); do
    if [ "$j" -gt "$i" ]; then
      
      # Get the 2 files that I am going to study
      a=$( echo $all | awk -v n=$i '{print $n}' )
      b=$( echo $all | awk -v n=$j '{print $n}' )
      
      # Make  clean names
      namea=$( echo $a | sed 's/.sumstats.gz//' | sed 's/.*GWAS_SUMSTAT\///')
      nameb=$( echo $b | sed 's/.sumstats.gz//' | sed 's/.*GWAS_SUMSTAT\///')
      echo $namea, $nameb
      
      # run the program
      /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/code/Genetic_Dist/ldsc/ldsc.py \
        --rg ${a},${b} \
        --ref-ld-chr /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/code/Genetic_Dist/eur_w_ld_chr/ \
        --w-ld-chr /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/code/Genetic_Dist/eur_w_ld_chr/ \
        --out /Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/code/Genetic_Dist/Cor/Cor_${namea}_${nameb}

    fi
done
