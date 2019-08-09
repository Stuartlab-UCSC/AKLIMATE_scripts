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
  filepath = paste("/Users/user/Desktop/BD2K_project/data/")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  
  feature_df = c()
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
      data_table = data_table[c(1:x), ]
      
      # add column with the cross validation fold
      
      
      feature_table = rbind(feature_df, data_table)
    }
  }
  print("big list finished")
  x = 10
  #takes the first set in our list of sets (set = cohorst)
  feature_table = c(list_of_sets[[1]], list_of_sets[[2]])
  #grabs the first 10 rows in our set
  first_x_features_and_importances = df.first_set[1:x]
  #initializes an empty vector
  first_x_features = c()
  first_x_importances = c()
  current_CV = c()
  #this loop,
  for (i in 1:x) {
    #combines the lists
    first_x_features = c(first_x_features,
                         names(first_x_features_and_importances)[i])
    #same as above for the features
    first_x_importances = c(first_x_importances, first_x_features_and_importances[[i]])
    for (j in 1:5) {
      #this is for which iteration 
      if (file_name == grepl("R",j,"_")) {
        current_CV = j
      }
      #this is for cross validation fold
      #if (file_name == grepl("_F",j)){
      #  current_CV = j
      #}
      
    }
  }
  #tells where to put what in each coloumn
  top_features = cbind(
    feature = first_x_features,
    importance = first_x_importances,
    cross_validation = current_CV
  )
  
  
  print(top_features)
  # write.table(top_features, file = paste0("/scratch/for_gchavez/aklimate_results/",tt,"_top_features", x ,"-table.tsv")
  #,append = FALSE, quote = FALSE, sep = "\t", row.names = TRUE,
  #col.names = TRUE)
  #pdf(paste0("/scratch/for_gchavez/aklimate_results/",tt, "_top", x , "-plot.pdf"))
  #plot(top_features$importance, col="blue")
  print("done")
}
