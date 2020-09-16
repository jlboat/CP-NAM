library(SimRAD)
library(seqinr)

site_pos_cut<-function(apek1_1,apek1_2,window.size,rfsq){
    density<-NULL
    rfsq<-rfsq
    tmp<-gregexpr(pattern =apek1_1,rfsq[1])
    tmp<-tmp[[1]]+1
    tmp1<-gregexpr(pattern =apek1_2,rfsq[1])
    tmp1<-tmp1[[1]]+1
    tmp<-c(tmp,tmp1)
    tmp<-sort(tmp)
    n<-max(tmp)%/%window.size
    for(i in 1:n){
        interval_tmp<-tmp[tmp>(i-1)*window.size & tmp<i*window.size]
        number_cut_site<-length(interval_tmp)
        density_tmp<-data.frame((i-1)*window.size+1,i*window.size,number_cut_site)
        density<-rbind(density,density_tmp)
    }
    names(density)<-c("Start","End","number")
    return(density)
}

sb.genome<-read.fasta("Sbicolor_454_v3.0.1.fa")

# apek1_1<-"GCAGC"
# apek1_2<-"GCTGC"
psti_1 <- "CTGCAG"
# psti_2 <- "GACGTC"
mspi_1 <- "CCGG"
# mspi_2 <- "GGCC"

dens<-NULL

for (i in 1:10){
    write.fasta(sb.genome[i], names=names("Chr"),file.out=paste("chr",i,".fasta",sep=""), open = "w", nbchar = 60, as.string = FALSE)
    rfsa<-ref.DNAseq(paste("chr",i,".fasta",sep=""),subselect.contigs = TRUE)
    # with 200,000 window size
    dens1 <- site_pos_cut(psti_1, mspi_1, 200000, rfsa)
    #dens1 <- rbind(dens1, site_pos_cut(mspi_1, mspi_2, 200000, rfsa))
    dens1 <- cbind(rep(paste("CHR",i,sep=""),nrow(dens1)),dens1)
    names(dens1)[1]<-"CHR"
    dens<-rbind(dens,dens1)
    print(paste("Chromosome",i," was done!",sep=""))
}

sim_path<-"."
write.table(dens,sprintf("%s/density_cut_site.txt",sim_path),quote=F,row.names=F,sep="\t")
# In silico digest for length distribution
library(SimRAD)

# ApeKI : G|CWGC  which is equivalent of either G|CAGC or  G|CTGC
# MspI  : C|CGG
# PstI  : CTGCA|G
cs_5p1 <- "CTGCA"
cs_3p1 <- "G"
cs_5p2 <- "C"
cs_3p2 <- "CGG"

number_of_segment<-NULL
segment_length<-NULL
setwd(".")
for(i in 1:10){
    rfsa<-ref.DNAseq(paste("chr",i,".fasta",sep=""),subselect.contigs = TRUE)
    simseq.dig1 <- insilico.digest(rfsa, cs_5p1, cs_3p1, cs_5p2, cs_3p2, verbose=TRUE)
    number_of_segment_tmp<-length(simseq.dig1)
    segment_length_tmp<-width(simseq.dig1)
    number_of_segment<-c(number_of_segment,number_of_segment_tmp)
    segment_length_tmp<-data.frame(chr=i,segment_length_tmp)
    names(segment_length_tmp)<-c("Chr","segment_length")
    segment_length<-rbind(segment_length,segment_length_tmp)
    print(paste("Chromosome",i," was done!",sep=""))
}

Chr<-c("CHR01","CHR02","CHR03","CHR04","CHR05","CHR06","CHR07","CHR08","CHR09","CHR10")
number_of_segment<-data.frame(Chr,number_of_segment)
write.table(number_of_segment,"number_of_segment.txt",row.names=F,quote=F)
write.table(segment_length,"segment_length.txt",row.names=F,quote=F)
