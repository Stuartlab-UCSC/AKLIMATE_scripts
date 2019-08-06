#Set x to cutoff number
x = 50
#tumor_type_list: the types of cohorts we're comparing
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
for (j in 1:length(tumor_type_list)){
  tt = tumor_type_list[j]
  #prediction class
  df.prediction_class_tt = c()
  filepath = paste("/scratch/for_gchavez/aklimate_results/brca/models/")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = c()
  for (i in 1:num_files){
    file_name = file_name_list[(i)]
    # LOOP B: This if statement makes sure we only go into the files that are specifically AKLIMATE output files
    if (length(grep("_cutoff_",50,"_rf_reduced_model_predictions", file_name , fixed = TRUE)) == 1) {
      load(paste0("/scratch/for_gchavez/aklimate_results/brca/models/", file_name))
      # Initialize empty list to store the aggregate of all of the predictions in this cohort
      pedictions = rf.preds
    }
    for (k in 1:length(rf.preds[,1])){
      df.prediction_class_tt = c(rownames(rf.preds)[k],max(rf.preds[k,], prediction_class_tt))
    }
  }
}  
