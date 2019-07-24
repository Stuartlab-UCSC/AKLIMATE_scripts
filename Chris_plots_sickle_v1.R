 #script version of above
  filepath = "/Users/user/Desktop/BD2K_project/"
# file_name_list: Takes all the files and lists them
#file_name_list = list.files(path = filepath)
# num_files: The number of files we have
#num_files = length(file_name_list)
tumor_type_list = c("BRCA", "COADREAD", "LGGGBM", "THYM", "UCEC")

for (tt in tumor_type_list) {
  
  dat = read.table(paste0(filepath,tt,"_balanced_accuracy_reduced_feature_sets.tab")
                   , header=TRUE, row.names=1, sep="\t", check.names = FALSE)
  #file_name = file_name_list[(j)]
  
  mean_data = c()
  std_data = c()
  x = 1:9
  for(i in 1:9){
    mean_data = c(mean_data, mean(dat[,i]))
    std_data = c(std_data, sd(dat[,i]))
  }
  png(paste0(filepath,tt, "_balaccVfeatures-plot.png"))
  plot(x, mean_data, ylim = c(.65, 1), ylab = "Balanced Accuracy", xaxt = "n", xlab = "Number of Features", 
       main = paste0("# Features vs. Balanced Accuracy\nin " ,tt))
  grid()
  lines(x, mean_data, col = "red")
  axis(1, at=x, labels = colnames(dat))
  arrows(x, mean_data - std_data, x , mean_data + std_data, length = 0.05, angle = 90, code = 3)
  dev.off()
}
