View(confM$byClass)
View(confM$table)
###(Cohort, Attributes, Readily, Identified, Now, Algorithm)
## Gabe & Jackie & Verrena & Chris
# This script prints the average balance accuracy for each AKLIMATE output file,
# finds the summary statistics, the standard deviation, the standard error, and plots them.

# file_name_list paths:
#in ucsc terminal:"/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep=""
#in gabes computer: /Users/user/Desktop/BD2K_project/data/
#in jackies computer: /Users/jacquelynroger/Documents/research/RMI/gabe/data/
#tumor_type_list: the types of cohorts we're comparing
stats = confM[[4]]
bal_accs = stats[,11]
#brca classes
#path to brca
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
df_cohort = c()
class_types = c(bal_accs_class1, bal_accs_class2, bal_accs_class3, bal_accs_class4)
# LOOP A: This for loop will run through all the files we have
for (j in 1:length(tumor_type_list)) {
  tt = tumor_type_list[j]
  filepath = paste("/Users/user/Desktop/BD2K_project/data/")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  #num_files: The number of files we have
  num_files = length(file_name_list)
  #Initialize empty list to store the aggregate of all of the balance accuracies in the cohort subtypes
  for (i in 1:num_files) {
    file_name = file_name_list[(i)]
    #LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
    if (length(grep("_stats_preds.RData", file_name , fixed = TRUE)) == 1) {
      load(paste0("/Users/user/Desktop/BD2K_project/data/", file_name))
      #Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
      stats = confM[[4]]
      for(w in 1:length(row.names(confM$byClass))){
        bal_accs = stats[w, 11]
        bal_accs_class[w] = c(bal_accs)
      }
    }
    bal_accs_class1= c(bal_accs_class[1])
    bal_accs_class2= c(bal_accs_class[2])
    bal_accs_class3= c(bal_accs_class[3])
    bal_accs_class4= c(bal_accs_class[4])
  }
  pdf(paste0("/Users/user/Desktop/BD2K_project/data/","sub_", tt, "-plot.pdf"))
  boxplot(bal_accs_class ~ class_types,
    data = df_cohort,
    main = "Balance accuracy across sub", tt, "cohort",
    xlab = "Balance accuracy",
    ylab = "Sub Cohorts",
    ylim = c(0, 1),
    col = "orange",
    border = "brown",
    horizontial = TRUE
  )
}