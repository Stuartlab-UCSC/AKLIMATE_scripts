#gabriel chavez
#this is a script to find the balance acuracy of a matrix
#
#***confM Script (1)***
#note: file path is non-universal 
load("/Users/user/Desktop/BD2K_project/R1_F1_junkle_final_model_stats_preds.RData")
stats = confM[[4]]
bal_accs = stats[,11]
avg_bal_acc = mean(stats[,11])
print(avg_bal_acc)

#read in only files that end in stats_preds.Rdata and preform conf script (1)


