###(Cohort, Attributes, Readily, Identified, Now, Algorithm)
## Gabe & Jackie & Verrena & Chris
# This script prints the average balance accuracy for each Cohort ran through 
# AKLIMATE and compares them in a Boxplot.
# file_name_list paths:
#in ucsc terminal:"/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep=""
#in gabes computer: /Users/user/Desktop/BD2K_project/data/
#in jackies computer: /Users/jacquelynroger/Documents/research/RMI/gabe/data/
#tumor_type_list: the types of cohorts we're comparing 
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
#we initialize an empty list for our dataframe
df_cohort = c()
# LOOP A: This for loop will run through all the files we have
#For: every cohord,
for(j in 1:length(tumor_type_list)){
  #we insure we go through each cohort
  tt = tumor_type_list[j]
  #we find the path to the cohort files
  filepath = paste("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="")
  # file_name_list: we take all those files and list them
  file_name_list = list.files(path = filepath)
  # num_files: We count the number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = c()
  #For every cohord data file,
  for (i in 1:num_files) {
   #file name will temporarily be every file in the list one at a time
    file_name = file_name_list[(i)]
    # LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
    if(length(grep("_stats_preds.RData", file_name ,fixed=TRUE)) == 1){
     #we load the data for the ith corhort
      load(paste0("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="", file_name))
      # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
      stats = confM[[4]]
      #makes sure the data we look at is the balance accuracy
      bal_accs = stats[,11]
      #we store the balance accuracy into a larger list
      bal_accs_all = c(bal_accs_all, bal_accs)
    }
  #When the loop completes we'll have the balance accuracies from all the data files
  }
  #FOR every cohort,
  for(k in 1:length(bal_accs_all)){
    #we will add to the data frame by inserting a tumor type and its corresponding balance accuracy in each row
    df_cohort=rbind(df_cohort, c(tt, bal_accs_all[k]))
  #When this loop completes, the data frame will contain all of the balance accuracies of a single cohort
  }
  #the colomn names of the data frame will be cohort and balance accuracy
  colnames(df_cohort)= c("cohort","balance_accuracy")
#When this loop completes we will have the following
#1) We will have found a path to the files of each cohort
#2) From those files we will have found the meaningful data (balanced accuracy) and put it into a list
#3) From that list, we create a data frame for each cohort and its balanced accuracys
}
#This makes #our data frame and actuall data frame and not a matrix
df_cohort = as.data.frame(df_cohort, stringsAsFactors = FALSE)
#This makes sure we read in our balance accuracys as numeric values in the data frame 
df_cohort$balance_accuracy = as.numeric(df_cohort$balance_accuracy)
#saves our plot as a pdf
pdf(paste0("/scratch/for_gchavez/aklimate_results/all_tumors-plot.pdf"))
#makes a stacked box plot comparing the balanced accuracies of the cohorts
boxplot(balance_accuracy~cohort,
        data=df_cohort,
        main="Balanced accuracies across cohorts",
        ylab="Balanced accuracy",
        xlab="Cohorts",
        ylim = c(0,1),
        col= c("#ED2891","#9EDDF9","#B2509E","#CEAC8F","#FBE3C7"),
        border="brown",
        horizontial = FALSE
)
