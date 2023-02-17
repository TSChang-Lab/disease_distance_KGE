# Defining the distance between diseases using SNOMED CT embeddings
### Mingzhou Fu, Yu Yan, Loes M Olde Loohuis, and Timothy S Chang

## Data description
### Disease distance files
Locate in the folder /disease_distance_metrics

1. **ICD_Distance_short.txt**

Include all pairwise distances of ICD-10 codes, including knowledge-graph embedding-based (embed_dist), ICD-10 tree-based (naive_dist), comorbidity-based (jaccard_dist), and genetic correlation-based (gen_dist). Also include the study type that the genetic correlation results based on.

2. **ICD_Distance_full.txt**

In addition to **ICD_Distance_short.txt**, adding more information for each pair, including the number of cases in UCLA EHR (N1/N2/N_pairs), raw genetic correlation (gen_cor) and its cooresponding standard deviation (gen_cor_sd), confidence of the correlation estimation (d1_confidence/d2_confidence), and heritability estimation for each ICD (h2_D1/h2_D2).


### Selected raw data files with data sources
Locate in the folder /data

1. **final_embed_matrix.rda**

Downloadable from https://drive.google.com/file/d/1BwxQpXwgIBBAFTTn0Kv8SUdCBTa6rVw_/view?usp=sharing

The .Rdata file of pre-trained SNOMED-CT embeddings. 

Reference: D. Chang, I. Balažević, C. Allen, D. Chawla, C. Brandt, A. Taylor, Benchmark and Best Practices for Biomedical Knowledge Graph Embeddings, in: Proceedings of the 19th SIGBioMed Workshop on Biomedical Language Processing, Association for Computational Linguistics, Online, 2020: pp. 167–176. https://doi.org/10.18653/v1/2020.bionlp-1.18.

2. **/Embed_Dist/raw/joint_CONCEPT.rda**

The mapping from SNOMED-CT concepts to ICD-10 codes.

Reference: Odysseus Data Services, Inc, ATHENA – OHDSI VOCABULARIES REPOSITORY, (2022). https://athena.ohdsi.org/search-terms/terms (accessed March 4, 2022)

3. **/Genetic_Dist/raw/mine_corr.xlsx** and **/Genetic_Dist/raw/mine_h2.xlsx**

Mined genetic correlation and heritability results from literatures.

Reference: G. Jia, Y. Li, H. Zhang, I. Chattopadhyay, A. Boeck Jensen, D.R. Blair, L. Davis, P.N. Robinson, T. Dahlén, S. Brunak, M. Benson, G. Edgren, N.J. Cox, X. Gao, A. Rzhetsky, Estimating heritability and genetic correlations from large health datasets in the absence of genetic data, Nat Commun. 10 (2019) 5508. https://doi.org/10.1038/s41467-019-13455-0


## Citation information
M. Fu, Y. Yan, L.M. Olde Loohuis, T.S. Chang, Defining the distance between diseases using SNOMED CT embeddings, Journal of Biomedical Informatics. 139 (2023) 104307. https://doi.org/10.1016/j.jbi.2023.104307.

