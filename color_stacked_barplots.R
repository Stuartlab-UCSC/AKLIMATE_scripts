# vfriedl, July 2019
# create stacked barplots for feature types used in reduced feature models


# Set paths for AKLIMATE results and output figures
# commented paths are for working in Rstudio on own machine

#aklimate_dir <- "/Users/vfriedl/remote_mounts/tap/remote/users/TCGA/GDAN/TMP_group/AKLIMATE_TEMPLATES/results/"
aklimate_dir <- "/projects/sysbio/users/TCGA/GDAN/TMP_group/AKLIMATE_TEMPLATES/results/"

#plot_dir <- "/Users/vfriedl/remote_mounts/tap/remote/users/vfriedl/aklimate/"
plot_dir <- "./"


# cohorts to go through
cohorts <- c("BRCA","COADREAD","LGGGBM","THYM","UCEC")

for(tt in cohorts){
  
  # hardcoded results folders for each cohort (hack because each cohort has a different date)
  if(tt == "BRCA"){
    model_dir <- paste0(aklimate_dir,"AKLIMATE_TEMPLATE_BRCA_20190612_with_filter_no_quantizing_done/models/")
  }
  if(tt == "COADREAD"){
    model_dir <- paste0(aklimate_dir,"AKLIMATE_TEMPLATE_COADREAD_20190616_filter_no_quantize_done/models/")
  }
  if(tt == "LGGGBM"){
    model_dir <- paste0(aklimate_dir,"AKLIMATE_TEMPLATE_LGGGBM_20190619_filter_no_quantize_done/models/")
  }
  if(tt == "THYM"){
    model_dir <- paste0(aklimate_dir,"AKLIMATE_TEMPLATE_THYM_20190613_docker_filter_no_quantize_done/models/")
  }
  if(tt == "UCEC"){
    model_dir <- paste0(aklimate_dir,"AKLIMATE_TEMPLATE_UCEC_20190616_filter_no_quantize_done/models/")
  }
  
  # get list of feature steps
  #steps <- c(5,10,20,50,100,200,500,1000,1500)
  file_list <- list.files(model_dir,pattern="cutoff", full.names = FALSE)
  steps <- sort(unique(sapply(file_list,function(x) as.numeric(strsplit(x,"_",fixed=T)[[1]][3]))))
  
  
  # get the input file names, matching *importance.tab
  file_list <- list.files(model_dir,pattern="importance.tab", full.names = TRUE)
  # feature types
  test_dat <- read.table(paste0(model_dir,"R1:F1_aklimate_multiclass_feature_importance.tab")
                         ,header=TRUE, sep="\t")
  feature_types <- unique(sapply(as.character(test_dat$features),function(x) strsplit(x,":",fixed=T)[[1]][2]))
  print(feature_types)
  
  # data frame holding the proportions for each feature type for each step
  props_df <- matrix(0,nrow = length(feature_types), ncol = length(steps), dimnames = list(feature_types, steps))
  
  for(step in steps){
    
    # data frame to hold the counts for each feature type in each file (i.e. cv fold)
    feature_counts_df <- matrix(0,nrow = length(feature_types), ncol = length(file_list), dimnames = list(feature_types, file_list))
    
    for(file in file_list){
      dat <- read.table(file, header=TRUE, sep="\t")
      
      # if there is less features in the file than the step indicates, just take all the feature in the file
      features_complete <- sapply(as.character(dat$features),function(x) strsplit(x,":",fixed=T)[[1]][2])
      if(length(features_complete) >= step){
        features <- features_complete[1:step]
      }else{
        features <- features_complete
      }
      
      # add counts for each feature type to the data frame
      for(ft in feature_types){
        feature_counts_df[ft,file] <- sum(features==ft)
      }

    }
    
    # add proportions for each feature type to data frame
    total_num <- sum(feature_counts_df)
    for(ft in feature_types){
      props_df[ft,toString(step)] <- sum(feature_counts_df[ft,])/total_num
    }
  }
  
  # ensure the proportions sum up to 1
  for(i in 1:length(steps)){
    sum <- colSums(props_df)[i]
    if(sum != 1){
      print("Warning! Proportions do not sum up to 1")
    }
  }
  
  # sort props_df to always have the same ordering of feature types - HARDCODED FOR NOW
  ordering <- c("GEXP", "METH", "CNVR", "MUTA")
  props_df <- props_df[ordering,]
  
  png(paste0(plot_dir
             ,tt,"_feature_proportion_barplot.png"))
  barplot(props_df, xlab = "number of features", ylab = "proportions in top features"
          , main=paste0("feature types in ",tt," models")
          ,legend.text = rownames(props_df)#sapply(rownames(props),function(x) strsplit(x,"_",fixed=T)[[1]][2])
          , args.legend = list(x = "bottomright"))
  dev.off()
  
  print(tt)
  print(props_df)
  
}
