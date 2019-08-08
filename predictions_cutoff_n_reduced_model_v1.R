
#Set x to cutoff number
x = 50
#tumor_type_list: the types of cohorts we're comparing
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
for (j in 1:length(tumor_type_list)){
  tt = tumor_type_list[j]
  #prediction class
  filepath = paste("/scratch/for_gchavez/aklimate_results/brca/models/")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = c()
    for(r in 1:5){
      for(f in 1:5){
        #load(paste0("/scratch/for_gchavez/aklimate_results/brca/models/R",r,":F",f,"_cutoff_"
                    #,x,"_rf_reduced_model_predictions.RData"))
        load(paste0("/scratch/for_gchavez/aklimate_results/brca/models/"))
        pedictions = rf.preds
        for (k in 1:length(rf.preds[,1])){
          df.prediction_class = c(df.prediction_class, max(rf.preds[k,]))
        }
      }
    }
  }
