setwd("C:/Users/jaely/Documents/Mozambique_Adivaricata")

thetas_caldeira<-read.table('thetas_caldeira_all.pestPG',header=TRUE)
thetas_pemba<-read.table('thetas_pemba_narrow_all.pestPG',header=TRUE)

thetas_wimbe<-read.table('thetas_wimbe.pestPG',header=TRUE)
thetas_peninsula<-read.table('thetas_peninsula.pestPG',header=TRUE)

colnames(thetas_caldeira)<-c('first','Chr','WinCenter','tW','tP','tF','tH','tL','Tajima','fuf','fud','fayh','zeng','nSites')
colnames(thetas_pemba)<-c('first','Chr','WinCenter','tW','tP','tF','tH','tL','Tajima','fuf','fud','fayh','zeng','nSites')
colnames(thetas_wimbe)<-c('first','Chr','WinCenter','tW','tP','tF','tH','tL','Tajima','fuf','fud','fayh','zeng','nSites')
colnames(thetas_peninsula)<-c('first','Chr','WinCenter','tW','tP','tF','tH','tL','Tajima','fuf','fud','fayh','zeng','nSites')

#Check that all datasets have same number of sites
sum(thetas_caldeira$nSites)
sum(thetas_pemba$nSites)
sum(thetas_wimbe$nSites)
sum(thetas_peninsula$nSites)

#Pi
pi_caldeira<-sum(thetas_caldeira$tP)/sum(thetas_caldeira$nSites)
pi_pemba<-sum(thetas_pemba$tP)/sum(thetas_pemba$nSites)
pi_wimbe<-sum(thetas_wimbe$tP)/sum(thetas_wimbe$nSites)
pi_peninsula<-sum(thetas_peninsula$tP)/sum(thetas_peninsula$nSites)

#Watterson's theta
tW_caldeira<-sum(thetas_caldeira$tW)/sum(thetas_caldeira$nSites)
tW_pemba<-sum(thetas_pemba$tW)/sum(thetas_pemba$nSites)
tW_wimbe<-sum(thetas_wimbe$tW)/sum(thetas_wimbe$nSites)
tW_peninsula<-sum(thetas_peninsula$tW)/sum(thetas_peninsula$nSites)

#Tajima's D
sum(thetas_caldeira$Tajima*thetas_caldeira$nSites)/sum(thetas_caldeira$nSites)
sum(thetas_pemba$Tajima*thetas_pemba$nSites)/sum(thetas_pemba$nSites)
sum(thetas_pemba_broad$Tajima*thetas_pemba_broad$nSites)/sum(thetas_pemba_broad$nSites)
