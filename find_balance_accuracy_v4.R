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
  #file_name <- file_name_list[i]
  if(length(grep("_file.R","my_file.R",fixed=TRUE)) == 1){
    file_name = file_name_list[(i)]
    #load(paste0("/Users/user/Desktop/BD2K_project/data/", file_name))
    stats = confM[(4)]
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
