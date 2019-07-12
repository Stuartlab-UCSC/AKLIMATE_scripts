## Gabe & Jackie
# This script prints the average balance accuracy for each AKLIMATE output file,
# finds the summary statistics, the standard deviation, the standard error, and plots them.

# file_name_list: Takes all the files and lists them
file_name_list = list.files(path = "/scratch/for_gchavez/aklimate_results/thym/models/")
# num_files: The number of files we have
num_files = length(file_name_list)

# Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
bal_accs_all = list()

# LOOP A: This for loop will run through all the files we have 
for (i in 1:num_files) {
  file_name = file_name_list[(i)]
  # LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
  if(length(grep("_stats_preds.RData", file_name ,fixed=TRUE)) == 1){
    load(paste0("/scratch/for_gchavez/aklimate_results/thym/models/", file_name))
    stats = confM[[4]]
    bal_accs = stats[,11]
    bal_accs_all = c(bal_accs_all, bal_accs)
  }
}

# This now contains all balance accuracies for the cohort
#unlist: flattens a list and turns in into sorta a vector
bal_accs_all = unlist(bal_accs_all)

# Make a boxplot of the balance accuracies in this cohort
boxplot(bal_accs_all, horizontal = TRUE, main = "Balance accuracies across cohorts", xlab = "Balance accuracy", ylim = c(0, 1))
