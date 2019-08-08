# Set paths for AKLIMATE results and output figures

aklimate_dir <- "/scratch/for_gchavez/aklimate_results/"
plot_dir <- "./"


# cohorts to go through
cohorts <- c("brca","coadread","lgggbm","thym","ucec")

# top x features
x = 100

for(tt in cohorts){
  
  # get the input file names, matching *importance.tab
  file_list <- list.files(paste0(aklimate_dir,tt,"/models/"),pattern="importance.tab", full.names = TRUE)
  
  # data frame holding the top features for each CV
  top_df <- c()
    
  for(file in file_list){
    dat <- read.table(file, header=TRUE, sep="\t")
      
    # if there is less features in the file than the step indicates, just take all the feature in the file
    top_feats <- dat[c(1:x),]
    
    # add the cross validation fold the feature came from, e.g. R1:F1
    
    # add features to df
    top_df <- rbind(top_df,top_feats)
  }
    
  # sort data frame and only take the top x features
  
  
  # write table to file
  
}