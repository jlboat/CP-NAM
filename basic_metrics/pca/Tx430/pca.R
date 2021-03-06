library(SNPRelate)

args <- commandArgs(trailingOnly=TRUE)

if (is.na(args[1])){
    print("ERROR: No file included.")
    print("Rscript pca.R variants.vcf")
    quit("no")
}

vcf.snp <- args[1]
snpgdsVCF2GDS(vcf.snp, "all.gds", method="biallelic.only")
snpgdsSummary("all.gds")
genofile <- snpgdsOpen("all.gds")

snpset2 <- snpgdsLDpruning(genofile,ld.threshold = 1,maf=0.1,num.thread=4)
snpset2.id <- unlist(snpset2)

pca <- snpgdsPCA(genofile,snp.id=snpset2.id,num.thread=4)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))
EV = pca$eigenvect[,1:20]
tab <- data.frame(sample.id = pca$sample.id,EV,stringsAsFactors = FALSE)
save(pca,file="pca.rda")
write.table(tab,"pca.IBD.txt",quote=F,row.names=F,sep="\t")
