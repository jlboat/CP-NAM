sim_dig <- read.table("density_cut_site.txt",header=T)
sim_dig$CHR<-gsub("CHR","",sim_dig$CHR)
sim_dig$CHR<-as.numeric(sim_dig$CHR)

chr1<-nrow(sim_dig[sim_dig$CHR==1,])/2
chr2<-nrow(sim_dig[sim_dig$CHR<2,])+nrow(sim_dig[sim_dig$CHR==2,])/2
chr3<-nrow(sim_dig[sim_dig$CHR<3,])+nrow(sim_dig[sim_dig$CHR==3,])/2
chr4<-nrow(sim_dig[sim_dig$CHR<4,])+nrow(sim_dig[sim_dig$CHR==4,])/2
chr5<-nrow(sim_dig[sim_dig$CHR<5,])+nrow(sim_dig[sim_dig$CHR==5,])/2
chr6<-nrow(sim_dig[sim_dig$CHR<6,])+nrow(sim_dig[sim_dig$CHR==6,])/2
chr7<-nrow(sim_dig[sim_dig$CHR<7,])+nrow(sim_dig[sim_dig$CHR==7,])/2
chr8<-nrow(sim_dig[sim_dig$CHR<8,])+nrow(sim_dig[sim_dig$CHR==8,])/2
chr9<-nrow(sim_dig[sim_dig$CHR<9,])+nrow(sim_dig[sim_dig$CHR==9,])/2
chr10<-nrow(sim_dig[sim_dig$CHR<10,])+nrow(sim_dig[sim_dig$CHR==10,])/2

sim_dig$id<-paste0(sim_dig$CHR,"_",sim_dig$Start)

png("digest.png", width = 6, height = 6, units = 'in', res = 300)
plot(sim_dig$number,col=ifelse(sim_dig$CHR%%2==0,"black","gray"),type="h", ylab="Enzyme cut sites", xlab="Chromosome", cex.lab=1, axes=F)
axis(side=2,at=seq(1,800,length=9),labels=seq(0,800,length=9), cex.lab=0.8, cex.axis = 0.8, las=2)
axis(side=1,at=c(chr1,chr2,chr3,chr4,chr5,chr6,chr7,chr8,chr9,chr10),labels=c("1","2","3","4","5","6","7","8","9","10"),cex.axis=0.8)
dev.off()
