###(Cohort, Attributes, Readily, Identified, Now, Algorithm)
## Gabe & Jackie & Verrena & Chris
# This script prints the average balance accuracy for each AKLIMATE output file,
# finds the summary statistics, the standard deviation, the standard error, and plots them.

# file_name_list paths:
#in ucsc terminal:"/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep=""
#in gabes computer: /Users/user/Desktop/BD2K_project/data/
#in jackies computer: /Users/jacquelynroger/Documents/research/RMI/gabe/data/
#tumor_type_list: the types of cohorts we're comparing 
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
df_cohort = c()
# LOOP A: This for loop will run through all the files we have
for(j in 1:length(tumor_type_list)){
  tt = tumor_type_list[j]
  filepath = paste("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = c()
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
  for(k in 1:length(bal_accs_all)){
    df_cohort=rbind(df_cohort, c(tt, bal_accs_all[k]))
  }
  colnames(df_cohort)= c("cohort","balance_accuracy")
}
df_cohort = as.data.frame(df_cohort, stringsAsFactors = FALSE)
df_cohort$balance_accuracy = as.numeric(df_cohort$balance_accuracy)
#print(df_cohort)
pdf(paste0("/scratch/for_gchavez/aklimate_results/",tt,"-plot.pdf"))
boxplot(balance_accuracy~cohort,
        data=df_cohort,
        main="Balance accuracies across cohorts",
        xlab="Balance accuracy",
        ylab="Cohorts",
        ylim = c(0,1),
        col="orange",
        border="brown",
        horizontial = TRUE
)
