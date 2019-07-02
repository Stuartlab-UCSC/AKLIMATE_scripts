##gabriel chavez
#This script prints the average balance accuracy for each 
#confusion matrix in each file in a folder for an unspecified number of files
#
#
#***confM Script (2)***

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
#command:

