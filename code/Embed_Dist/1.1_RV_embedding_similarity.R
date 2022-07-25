# Basic setups
start_time = Sys.time()
pacman::p_load(tidyverse, rlist, pracma)

# Anlaysis starts here
infile_path = "/Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/data/Embed_Dist/raw/"
output_path = "/Users/Mingzhou/Desktop/Projects/Disease.Similarity/GitHub/data/Embed_Dist/mod/"
# Load in the datasets
load(paste0(infile_path, 'final_embed_matrix.rda'))
load(paste0(infile_path, "joint_CONCEPT.rda"))

json_ids = names(final_embed_matrix)
unique_icd = unique(joint_CONCEPT$ICD_10)
unique_icd_lst = as.list(unique_icd)
icd_3digit = unique_icd_lst[lapply(unique_icd_lst, nchar) == 3]

# Part 1. Create a full list of matrices for ICD codes
short_matrix_lst = list()
short_matrix_id_lst = list()
for (i in 1:length(icd_3digit)) {
  if (i %% 10 == 1) {
    print(i)
    end_time = Sys.time()
    time_diff = end_time - start_time
    print(time_diff)
  }
  icd1 = icd_3digit[[i]]
  snomed_ids_1 = joint_CONCEPT %>% filter(ICD_10 == icd1) %>% pull(SNOMED_id)
  snomed_colnames_1 = paste0('X', snomed_ids_1)
  inter_two_1 = intersect(snomed_colnames_1, json_ids)
  if (length(inter_two_1) >= 1) {
    sample_matrix_1 = final_embed_matrix %>% select(all_of(inter_two_1))
    short_matrix_lst = list.append(short_matrix_lst, sample_matrix_1)
    short_matrix_id_lst = list.append(short_matrix_id_lst, icd1)
  }
}
print(length(short_matrix_id_lst))

save(short_matrix_id_lst, file = paste0(output_path, "short_matrix_id_lst.rda"))
save(short_matrix_lst, file = paste0(output_path, "short_matrix_lst.rda"))
print("Calculate disease matrix finished! Saved successfully!")

# Part 2. Start calculate RV coefficients
print("Start RV coefficients! Total numbers of interations: ")
print(length(short_matrix_lst))

result_apply =
  lapply(1:length(short_matrix_lst), function(i) {
    if (i %% 50 == 1) {
      print(i)
      print(Sys.time() - start_time)
    }
    c(rep(NA, i-1), 
      unlist(lapply(i:length(short_matrix_lst), function(j) {
        RVadjMaye(short_matrix_lst[[i]], short_matrix_lst[[j]], center = TRUE)
      })))
  })

short_sim = matrix(unlist(result_apply), nrow = length(short_matrix_lst))

# Assign colnames/rownames to the **short_sim** with **short_matrix_id_lst**
colnames(short_sim) = unlist(short_matrix_id_lst)
rownames(short_sim) = unlist(short_matrix_id_lst)
dim(short_sim)
# 1619,1619

# Finalize the embed_sim data (disease similarity based on knowledge-graph embedding)
embed_sim = short_sim
save(embed_sim, file = paste0(output_path, "embed_sim.rda"))

end_time = Sys.time()
time_diff = end_time - start_time
print(time_diff)
