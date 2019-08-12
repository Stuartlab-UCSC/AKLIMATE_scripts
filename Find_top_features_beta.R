###(Cohort, Assays, Readily, Identified, Now, Algorithm)
#by Gabe & verenna
#/scratch/for_gchavez/aklimate_results/brca/models/
#this is where our junkle data is at
#list_of_sets = c(jklm$rf.stats$importance)
#the five cohorts we're looking at
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
#for later use
df_cohort = c()
# LOOP A: This for loop will run through all the server cohort files we have
for (i in 1:length(tumor_type_list)) {
  #an abriviation that loops through all five server cohorts
  tt = tumor_type_list[i]
  print(tt)
  #this is where we will eventually stack all the junkle data together
  Junkle_data_list = c()
  #the path to th files
  filepath = paste("/scratch/for_gchavez_old/aklimate_results/",tt,"models")
   # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  feature_table = c()
  #this for loop
  for (j in 1:num_files) {
    file_name = file_name_list[(j)]
    if (length(grep("_multiclass_feature_importance", file_name , fixed = TRUE)) == 1) {
      # Read tabular data into R
      data_table = read.table(
        file_name,
        header = TRUE,
        sep = "\t",
        dec = ".",
        stringsAsFactors = FALSE
      )
      #load(paste0("/Users/user/Desktop/BD2K_project/data/", file_name))
      #list_of_sets = c(data_table)
      #put the data files in a list called:junkle_data_list
      #Junkle_data_list = c(Junkle_data_list, Junkle_data_list[j])
      
      # cut data frame to top-x features
      list_of_sets = data_table[c(1:x), ]
      
      # add column with the cross validation fold
      
      
      feature_table = rbind(feature_table, list_of_sets)
    }
  }
  print("big list finished")
  x = 10
  #takes the first set in our list of sets (set = cohorst)
  #feature_table = c(list_of_sets[[1]], list_of_sets[[2]])
  #grabs the first 10 rows in our set
  feature_table[order(feature_table$importance,decreasing = TRUE),]
  
  top_features = feature_table[1:x,1]
  top_importances = feature_table[1:x,2]
  top_list = rbind(top_features, top_importances)
  #initializes an empty vector
  print(top_list)
  # write.table(top_features, file = paste0("/scratch/for_gchavez/aklimate_results/",tt,"_top_features", x ,"-table.tsv")
  #,append = FALSE, quote = FALSE, sep = "\t", row.names = TRUE,
  #col.names = TRUE)
  #pdf(paste0("/scratch/for_gchavez/aklimate_results/",tt, "_top", x , "-plot.pdf"))
  #plot(top_features$importance, col="blue")
  print("done")
}
