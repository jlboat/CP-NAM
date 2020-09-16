library(vcfR)
library(grid)
library(LDheatmap)

# REQUIRES OUTPUT FROM: filter_coordinates.bash

vcf <- read.vcfR("NAM.tan1.recode.vcf")
#camber <- read.csv("Chinese_Amber.txt", header=F)
#list_camber <- vcfR2SnpMatrix(vcf, subjects=camber[,1])
rgb.palette <- colorRampPalette(rev(c("blue", "orange", "red")), space = "rgb")

snpMat <- vcfR2SnpMatrix(vcf)

png("tan1.png")
LDheatmap(snpMat$data, snpMat$genetic.distances, title="Tan1", 
          SNP.name = c("S04_62463940"), color=rgb.palette(18),
          geneMapLabelX=0.6, geneMapLabelY=0.1)
dev.off()

vcf <- read.vcfR("NAM.tan2.recode.vcf")
snpMat <- vcfR2SnpMatrix(vcf)

png("tan2.png")
LDheatmap(snpMat$data, snpMat$genetic.distances, title="Tan2",
          SNP.name = c("S02_6940113"), color=rgb.palette(18),
          geneMapLabelX=0.6, geneMapLabelY=0.1)
dev.off()

vcf <- read.vcfR("NAM.z.recode.vcf")
snpMat <- vcfR2SnpMatrix(vcf)

png("z-locus.png")
LDheatmap(snpMat$data, snpMat$genetic.distances, title="Z locus",
          SNP.name = c("S02_57797411"), color=rgb.palette(18),
          geneMapLabelX=0.6, geneMapLabelY=0.1)
dev.off()

vcf <- read.vcfR("NAM.unknown.recode.vcf")
snpMat <- vcfR2SnpMatrix(vcf)

png("unknown.png")
LDheatmap(snpMat$data, snpMat$genetic.distances, title="Chr7:8111484",
          SNP.name = c("S07_8111484"), color=rgb.palette(18),
          geneMapLabelX=0.6, geneMapLabelY=0.1)
dev.off()

vcf <- read.vcfR("NAM.waxy.recode.vcf")
snpMat <- vcfR2SnpMatrix(vcf)

png("waxy.png")
LDheatmap(snpMat$data, snpMat$genetic.distances, title="Waxy",
          SNP.name = c("S10_1948816"), color=rgb.palette(18),
          geneMapLabelX=0.6, geneMapLabelY=0.1)
dev.off()
