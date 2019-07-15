## Gabe & Jackie & Verrena & Chris
# This script prints the average balance accuracy for each AKLIMATE output file,
# finds the summary statistics, the standard deviation, the standard error, and plots them.

# file_name_list paths:
#in ucsc terminal: /scratch/for_gchavez/aklimate_results/thym/models/
#in gabes computer: /Users/user/Desktop/BD2K_project/data/
#in jackies computer: /Users/jacquelynroger/Documents/research/RMI/gabe/data/

#tumor_type_list: the types of cohorts we're comparing 
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
# LOOP A: This for loop will run through all the files we have 
for(tt in tumor_type_list){
  filepath = paste("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = list()
  for (i in 1:num_files) {
    file_name = file_name_list[(i)]
    # LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
    if(length(grep("_stats_preds.RData", file_name ,fixed=TRUE)) == 1){
      load(paste0("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="", file_name))
      # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
      stats = confM[[4]]
      bal_accs = stats[,11]
      bal_accs_all = c(bal_accs_all, bal_accs)
    }
  }
  # This now contains all balance accuracies for the cohort
  #unlist: flattens a list and turns in into sorta a vector
  bal_accs_all = unlist(bal_accs_all)
  
  # Make a boxplot of the balance accuracies in this cohort
  pdf(paste0("/scratch/for_gchavez/aklimate_results/",tt,"-plot.pdf"))
  boxplot(bal_accs_all, horizontal = TRUE, main = "Balance accuracies across cohorts", xlab = "Balance accuracy"
          , ylim = c(0, 1), ylab = "Cohorts", names = c("BRCA"))
  dev.off()
}
pdf(paste0("/scratch/for_gchavez/aklimate_results/",BACC,"-plot.pdf"))
boxplot(bal_accs_all, main = "Balance accuracies across cohorts", at = c(length(tt)),
names = c(tt), las = 2,
col = c("orange","red", "blue", "green", "purple"),
border = "brown", horizontal = TRUE, notch = TRUE, xlab = "Balance accuracy"
, ylim = c(0, 1), ylab = "Cohorts"
