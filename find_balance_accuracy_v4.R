##gabriel chavez
#This script prints the average balance accuracy for each AKLIMATE output file,
#finds the summary statistics, the standard deviation, the standard error, and plots them.
#
#***confM Script (2)***
##note: file path is non-universal 
#path = "Enter the path for where the AKLIMATE file on your terminal or machine are located"
#path in ucsc terminal: /scratch/for_gchavez/aklimate_results/thym/models/
#path in gabes computer: /Users/user/Desktop/BD2K_project/data/
#file_name_list: Takes all the files and lists them
file_name_list = list.files(path = "/scratch/for_gchavez/aklimate_results/thym/models/")
#num_files: The number of files we have
num_files = length(file_name_list)
#LOOP A: This for loop will run through all the files we have 
for (i in 1:num_files) {
  #file_name <- file_name_list[i]
  file_name = file_name_list[(i)]
  #LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
  if(length(grep("_stats_preds.RData", file_name ,fixed=TRUE)) == 1){
    load(paste0("/scratch/for_gchavez/aklimate_results/thym/models/", file_name))
    stats = confM[[4]]
    bal_accs = stats[,11]
    avg_bal_acc = mean(stats[,11])
    print(avg_bal_acc)
  }
  
}
#prints mean, median, min, max, 1st & 3rd quart of all the AKLIMATE outputs balance accuracys
summary(bal_accs)
#prints the standard deviation of all the AKLIMATE outputs balance accuracys
SD1 = sd(bal_accs)
print(cat("SD: ", SD1))
#prints the standard error of all the AKLIMATE outputs balance accuracys
SE = sd(bal_accs)/sqrt(length(bal_accs))
print(cat("SE: ", SE))
#a plot of all the means in the AKLIMATE outputs
plot(bal_accs)

#***STILL IN DEVELOPMENT (1)***
#We want to take these results and put it into a .txt file and use that information in the 
#text file to create a box and wisker plot with the diffrent cancer cohorts.
# x-axis: avg_bal_acc (scale: 0.0 to 1.0), y-axis: Cohorts


#***STILL IN DEVELOPMENT (2)***
#Next we want to create a dataframe that has two columns. One column is the file name and 
#the second column is the balance accuracy for that file.
#We will then use write_tsv (part of the readr package) to write that dataframe to a tsv file.
#This should result in us having a tsv file containing the results for all of the files.
#data frame with files name and balance accuarcy
file = c(file_name_list) 
balance_accuracy = c(avg_bal_acc) 
df = data.frame(file, balance_accuracy)       # df is a data frame

save(ts, file = "ts.Rda")

#***STILL IN DEVELOPMENT (3)***
#later down the road we want to make a sickle plot which will be able to give us insights
#as to which features preform the best. 
# x-axis: avg_bal_acc (scale: 0.0 to 1.0), y-axis: # feautres (scale: full to sparse)
