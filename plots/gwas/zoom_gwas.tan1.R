gene <- read.table("Sbicolor_454_v3.1.1.gene.gff3",sep="\t",skip=1)
snp_position <- 62463940
range_length <- 100000
chromosome <- 4
string_chrom <- "Chr04"
output_file <- "tan1_regional_manhattan.png"
gemma_output <- "plink.pruned.assoc.txt"
raise <- 10
max_ylim <- 90
ylim_by <- 10

## gene_tan1 <- gene[gene$V1=="Chr04" & gene$V3=="gene" & gene$V4>snp_position-range_length & gene$V4<snp_position+range_length,]
# gwas <- read.table("plink.pruned.assoc.txt", header=TRUE)
gwas <- read.table(gemma_output, header=TRUE)

gwas_gene<-gwas[gwas$chr==chromosome & gwas$ps>snp_position-range_length & gwas$ps<snp_position+range_length,]

# regional manhatton plot for Tan1 gene
png(output_file, width=6, 
    height=3, units="in", res=600, type="cairo")
par(mai=c(0.2,0.5,0.2,0.2),
    mgp=c(1.5,0,0))
plot(gwas_gene$ps, -log10(gwas_gene$p_wald)+raise, pch=16,
     col=ifelse(-log10(gwas_gene$p_wald)==max(-log10(gwas_gene$p_wald)),
                "red","black"), 
     ylim=c(0,max(-log10(gwas_gene$p_wald)+raise+1)), 
     cex=0.5, axes=F, xlab="", ylab="-log10(p value)", cex.lab=1)
axis(side=2, at=seq(raise,max_ylim,by=ylim_by), 
     labels=seq(0,max_ylim-ylim_by,by=ylim_by), cex.axis=1, tck = -0.01,
     mgp=c(3, 0.3, .05),las=2)
axis(side=1, at=seq(snp_position-range_length,snp_position+range_length,length=6),
     labels=seq(snp_position-range_length,snp_position+range_length,length=6),
     pos=0.5,cex.axis=0.7,tck = -0.01,mgp=c(3, 0.3, .05))
abline(h=raise-1)
segments(snp_position,-1,snp_position,max_ylim,col=2)
gene_chr<-gene[gene$V1==string_chrom,]
gene_chr<-gene_chr[gene_chr$V4> snp_position-range_length & gene_chr$V5 <snp_position+range_length,]
gene_chr<-gene_chr[grep("gene",gene_chr$V3),]
for(i in 1:nrow(gene_chr)){
    segments(gene_chr$V4[i],
             ifelse(i%%2==0,6,2.5),gene_chr$V5[i],
             ifelse(i%%2==0,6,2.5),lwd=7,lend=2,col="deepskyblue1")

}
dev.off()
