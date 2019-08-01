#View(confM$byClass)
#View(confM$table)
###(Cohort, Attributes, Readily, Identified, Now, Algorithm)
## Gabe & Jackie & Verrena & Chris
# This script prints the average balance accuracy for each AKLIMATE output file,
# finds the summary statistics, the standard deviation, the standard error, and plots them.

# file_name_list paths:
#in ucsc terminal:"/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep=""
#in gabes computer: /Users/user/Desktop/BD2K_project/data/
#in jackies computer: /Users/jacquelynroger/Documents/research/RMI/gabe/data/
#tumor_type_list: the types of cohorts we're comparing
#stats = confM[[4]]
#bal_accs = stats[,11]
#brca classes
#path to brca
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
colors = c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D")
df_cohort = c()
class_types = c("bal_accs_class1", "bal_accs_class2", "bal_accs_class3", "bal_accs_class4")
# LOOP A: This for loop will run through all the files we have
for (j in 1:length(tumor_type_list)) {
  tt = tumor_type_list[j]
  filepath = paste("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  #num_files: The number of files we have
  num_files = length(file_name_list)
  #Initialize empty list to store the aggregate of all of the balance accuracies in the cohort subtypes
  crossval_bal_acc = c()
  for (i in 1:num_files) {
    file_name = file_name_list[(i)]
    #LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
    if (length(grep("_stats_preds.RData", file_name , fixed = TRUE)) == 1) {
      load(paste0("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="", file_name))
      #Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
      stats = confM[[4]]
      bal_accs_class = c()
      for(w in 1:length(row.names(confM$byClass))){
        bal_accs = stats[w, 11]
        bal_accs_class = c(bal_accs_class, bal_accs)
      }
      crossval_bal_acc = rbind(crossval_bal_acc, bal_accs_class)
    }
  }
  mean_data = c()
  std_data = c()
  z = 1:ncol(crossval_bal_acc)
  for(i in z){
    mean_data = c(mean_data, mean(crossval_bal_acc[,i]))
    std_data = c(std_data, sd(crossval_bal_acc[,i]))
  }
    #this lists the first three letters in each subtype_number
  #substr(dat$subtype_number, 1, 3)
  sub_cohort_names = c()
  dat = read.table(paste0("/scratch/for_gchavez/aklimate_results/subtypes_mapping.tsv")
                   , header=TRUE, sep="\t", check.names = FALSE, stringsAsFactors = FALSE)
  for(i in 1:length(dat$subtype_number)){
    if(toupper(substr(tt, 1, 3)) == substr(dat$subtype_number[i], 1, 3)){
      #print(dat[i,])
      sub_cohort_names = c(sub_cohort_names,dat$subtype_name[i])
    }
  }
  pdf(paste0("/scratch/for_gchavez/aklimate_results","sub_", tt, "-plot.pdf"))
  x = barplot(colMeans(crossval_bal_acc),
    main = paste0("Balanced accuracy across the Sub ", tt, " Cohorts"),
    xlab = "Sub Cohorts",
    ylab = "Balanced Accuracy",
    ylim = c(-0.35, 1.1),
    col= colors,
    border="white"
    ,yaxt='n'
  ) 
  #this adds error bars
  arrows(x, mean_data - std_data, x , mean_data + std_data, length = 0.05, angle = 90, code = 3)
  #this round the BalAcc for each bar to the 2nd decimal digit
  y = round(colMeans(crossval_bal_acc), digits = 2)
  #this creates the y axis
  axis(2,at=c(0,0.2,0.4,0.6,0.8,1),labels = as.character(c(0,0.2,0.4,0.6,0.8,1)))
  #this moves the text for the BalAcc on the bars
  text(x-0.3,colMeans(crossval_bal_acc)+0.03,labels=as.character(y))
  #this is the text for the subcohorts
  if(tt == lgggbm | tt == ucec){
  text(x-0.25, rep(-0.15, length.out=length(x)), labels = sub_cohort_names[1:4], srt = 60)
  }
  if(tt == brca | tt == thym){
    text(x-0.25, rep(-0.10, length.out=length(x)), labels = sub_cohort_names[1:4], srt = 60)
  }
  if(tt == coadread){
    text(x-0.25, rep(-0.2, length.out=length(x)), labels = sub_cohort_names[1:4], srt = 60)
  }
  dev.off()
}
#how to run cd /scratch/for_gchavez/aklimate_results/lib/AKLIMATE_scripts
# Rscript sub_bal_acc_v1.R
