##gabriel chavez
#This script prints the average balance accuracy for each 
#confusion matrix in each file in a folder for an unspecified number of files
#
#
#***confM Script (2)***
##note: file path is non-universal 
file_name_list = list.files(path = "/Users/user/Desktop/BD2K_project/data/")
#files_name_list 
num_files = length(file_name_list)
for (i in 1:num_files) {
  if(i%%2 == 0){
    file_name = file_name_list[[i]]
    load(paste0("/Users/user/Desktop/BD2K_project/data/", file_name))
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
print("mean: ")
print(mean1)

SD1 = sd(bal_accs)
print("SD: ")
print(SD1)

SE = sd(bal_accs)/sqrt(length(bal_accs))
print("SE: ")
print(SE)
