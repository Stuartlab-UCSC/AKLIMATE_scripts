###(Cohort, Assays, Readily, Identified, Now, Algorithm)
#by Gabe & verenna
#/scratch/for_gchavez/aklimate_results/brca/models/
#the five cohorts we're looking at
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
#for later use
df_cohort = c()
# LOOP A: This for loop will run through all the server cohort files we have
for (i in 1:length(tumor_type_list)) {
  #an abriviation that loops through all five server cohorts
  tt = tumor_type_list[i]
  #this is where we will eventually stack all the junkle data together
  Junkle_data_list = c()
  #the path to th files
  filepath = paste("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  #this for loop
  for (j in 1:num_files) {
    file_name = file_name_list[(j)]
    if (length(grep("_junkle_final_model.RData", file_name , fixed = TRUE)) == 1) {
      load(paste0("/scratch/for_gchavez/aklimate_results/",tt,"/models/",sep="", file_name))
      #this is where our junkle data is at
      list_of_sets = c(jklm$rf.stats$importance)
      #put the data files in a list called:junkle_data_list
      Junkle_data_list = c(Junkle_data_list, Junkle_data_list[j])
    }
  }
 x = 100
  #takes the first set in our list of sets (set = cohorst)
  first_set = list_of_sets[[1]]
  #finds the first name of the first set
  first_set_name = names(list_of_sets)[1]
  #grabs the first 10 rows in our set
  first_x_features_and_importances = first_set[1:x]
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
    current_CV = c(current_CV, ceiling(1))
  }
  #tells where to put what in each coloumn
  top_features = cbind(feature = first_x_features,
                       importance = first_x_importances,
                       set = first_set_name,
                       cross_validation = current_CV)
  #when running for real, replace 5 with length(list_of_sets)
  for (j in 2:5) {
    current_set = list_of_sets[[j]]
    #can improve by making into a function!
    current_set_name = names(list_of_sets)[j]
    current_x_features_and_importances = current_set[1:x]
    current_x_features = c()
    current_x_importances = c()
    current_CV = c()
    for (k in 1:x) {
      current_x_features = c(current_x_features,
                             names(current_x_features_and_importances)[k])
      current_x_importances = c(current_x_importances,
                                current_x_features_and_importances[[k]])
      current_CV = c(current_CV, ceiling(j/10452))
    }
    current_top_features = cbind(feature = current_x_features,
                                 importance = current_x_importances,
                                 set = current_set_name,
                                 cross_validation = current_CV)
    top_features = rbind(top_features, current_top_features)
    
    top_features = as.data.frame(top_features)
    top_features$importance = as.numeric(as.character(top_features$importance))
    attach(top_features, warn.conflicts = FALSE)
    top_features = top_features[order(-importance),]
    top_features = top_features[1:x,]
  }
  
  print(top_features)
  write.table(top_features, file = paste0("/scratch/for_gchavez/aklimate_results/",tt,"_top_features", x ,"-table.tsv")
              ,append = FALSE, quote = FALSE, sep = "\t", row.names = TRUE,
              col.names = TRUE)
  pdf(paste0("/scratch/for_gchavez/aklimate_results/",tt, "_top", x , "-plot.pdf"))
  plot(top_features$importance, col="blue")
  print("done")
}
