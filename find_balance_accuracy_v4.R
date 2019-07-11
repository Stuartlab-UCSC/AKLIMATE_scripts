##gabriel chavez
#This script prints the average balance accuracy for each 
#confusion matrix in each file in a folder for an unspecified number of files
#
#
#***confM Script (2)***
##note: file path is non-universal 
file_name_list = list.files(path = "/scratch/for_gchavez/aklimate_results/thym/models/")

#files_name_list 
num_files = length(file_name_list)
for (i in 1:num_files) {
  #file_name <- file_name_list[i]
  file_name = file_name_list[(i)]
  if(length(grep("_stats_preds.RData", file_name ,fixed=TRUE)) == 1){
    
    load(paste0("/scratch/for_gchavez/aklimate_results/thym/models/", file_name))
    stats = confM[[4]]
    bal_accs = stats[,11]
    avg_bal_acc = mean(stats[,11])
    print(avg_bal_acc)
  }
  
}
#data frame with files name and balance accuarcy
file = c(file_name_list) 
balance_accuracy = c(avg_bal_acc) 
df = data.frame(file, balance_accuracy)       # df is a data frame

save(ts, file = "ts.Rda")

#bal_acc_list = c(avg_bal_acc1, avg_bal_acc2,..., avg_bal_accN)
mean1 = (sum(bal_accs))/length(bal_accs)
print(cat("mean: ", mean1))

SD1 = sd(bal_accs)
print(cat("SD: ", SD1))

SE = sd(bal_accs)/sqrt(length(bal_accs))
print(cat("SE: ", SE))
