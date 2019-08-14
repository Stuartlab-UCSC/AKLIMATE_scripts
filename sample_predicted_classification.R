#*********************************************************************************************************************
#This script takes the tumor types and makes a list with each sample and which class that sample was predicted to be.
#Choosing a value for (x) will tell us how long our list will be.
#in a future update, perhaps we can make another column listing which crox validation fold the sample comes from
#*********************************************************************************************************************
#Set x to cutoff number
x = 10
#tumor_type_list: the types of cohorts we're comparing
tumor_type_list = c("brca", "coadread", "lgggbm", "thym", "ucec")
for (j in 1:length(tumor_type_list)){
  tt = tumor_type_list[j]
  df.prediction_class = c()
  samples = c()
  samples = rownames(rf.preds)
  #prediction class
  filepath = paste0("/scratch/for_gchavez/aklimate_results/",tt,"/models/")
  # file_name_list: Takes all the files and lists them
  file_name_list = list.files(path = filepath)
  # num_files: The number of files we have
  num_files = length(file_name_list)
  # Initialize empty list to store the aggregate of all of the balance accuracies in this cohort
  bal_accs_all = c()
  print(tt)
  print("prediction cutoff")
      pedictions = rf.preds
      for (k in 1:length(rf.preds[,1])){
        #df.prediction_class = c(df.prediction_class, max(rf.preds[k,]))
        if(max(rf.preds[k,]) == rf.preds[k,1]){
          df.prediction_class = c(df.prediction_class, 1)
        }
        if(max(rf.preds[k,]) == rf.preds[k,2]){
          df.prediction_class = c(df.prediction_class, 2)
        }
        if(max(rf.preds[k,]) == rf.preds[k,3]){
          df.prediction_class = c(df.prediction_class, 3)
        }
        if(max(rf.preds[k,]) == rf.preds[k,4]){
          df.prediction_class = c(df.prediction_class, 4)
        }
        if(max(rf.preds[k,]) == rf.preds[k,5]){
          df.prediction_class = c(df.prediction_class, 5)
        }
      }
      #SPC (Sample.Prediction.Class)
      SPC = cbind(samples, df.prediction_class)
    #}
  #}
  print(SPC)
}
