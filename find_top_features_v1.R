###(Cohort, Assays, Readily, Identified, Now, Algorithm)
#Want to find the most important features of each cancer cohort

#precondition: x must be less that or equal to the numba of features in the first set.
#set numba of top features (x)
x = 10
#helps so we dont have to write jk... over agian
load("/Users/user/Desktop/BD2K_project/data/R1_F1_junkle_final_model.RData")
list_of_sets = jklm$rf.stats$importance
#takes the first set in our list of sets (set = cohorst)
first_set = list_of_sets[[1]]
#finds the first name of the first set
first_set_name = names(list_of_sets)[1]
#grabs the first 10 rows in our set
first_x_features_and_importances = first_set[1:x]
#initializes an empty vector
first_x_features = c()
first_x_importances = c()
#this loop, 
for(i in 1:x){
  #combines the lists
  first_x_features = c(first_x_features, names(first_x_features_and_importances)[i])
  #same as above for the features
  first_x_importances = c(first_x_importances, first_x_features_and_importances[[i]])                    
}
#tells where to put what in each coloumn
top_features = cbind(feature = first_x_features,
                     importance = first_x_importances,
                     set = first_set_name)
#when running for real, replace 5 with length(list_of_sets)
for(j in 2:5){
  current_set = list_of_sets[[j]]
  #can improve by making into a function!
  current_set_name = names(list_of_sets)[j]
  current_x_features_and_importances = current_set[1:x]
  current_x_features = c()
  current_x_importances = c()
  for(k in 1:x){
    current_x_features = c(current_x_features, names(current_x_features_and_importances)[k])
    current_x_importances = c(current_x_importances, current_x_features_and_importances[[k]])                    
  }
  current_top_features = cbind(feature = current_x_features,
                               importance = current_x_importances,
                               set = current_set_name)
  top_features = rbind(top_features, current_top_features)
  
  top_features = as.data.frame(top_features)
  top_features$importance = as.numeric(as.character(top_features$importance))
 attach(top_features, warn.conflicts = FALSE)
  top_features = top_features[order(-importance),]
  top_features = top_features[1:x,]
}
print(top_features)
