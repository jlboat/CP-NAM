library(qtl2)

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("At least one argument must be supplied (Population)\n", call.=FALSE)
} else if (length(args)==1) {
  pop <- as.character(args[1])
}

cores <- 6
num_phenotypes <- 1

biomass <- read_cross2(paste0("rqtl2_", pop, ".yaml"))
# map <- est_map(cross=biomass, 
#                      maxit=10000, 
#                      tol=1e-6, 
#                      error_prob=0.0001, 
#                      map_function="haldane", 
#                      cores=cores, 
#                      quiet=FALSE, 
#                      save_rf=TRUE)
saveRDS(biomass$gmap, paste0(pop, ".map.Rdata"))
# biomass$gmap <- map

biomass$gmap <- insert_pseudomarkers(biomass$gmap, step=1)
pr <- calc_genoprob(biomass, biomass$gmap, cores=cores)
saveRDS(pr, paste0(pop, ".genoprob.pr.Rdata"))
apr <- genoprob_to_alleleprob(pr, cores=cores)
saveRDS(apr, paste0(pop, ".alleleProb.apr.Rdata"))

kinship <- calc_kinship(pr, cores=cores)
saveRDS(kinship, paste0(pop, ".kinship.pr.Rdata"))

out <- scan1(pr, biomass$pheno, cores=cores)
saveRDS(out, paste0(pop, ".out.Rdata"))

# Process
peaks <- find_peaks(out, biomass$gmap, threshold=3, drop=1.5)
saveRDS(peaks, paste0(pop, ".peaks.Rdata"))
# bayes_int(out, map, lodcolumn=1, chr=3, prob=0.95)

out_pg <- scan1(pr, biomass$pheno, kinship, cores=cores)
saveRDS(out_pg, paste0(pop, ".lmm.Rdata"))

# Estimate heritability
herit <- est_herit(biomass$pheno, kinship)
saveRDS(herit, paste0(pop, ".herit.Rdata"))

# Plot H-K and LMM
png(paste0(pop, ".H-K_LMM.png"))
color <- c("slateblue", "violetred")
par(mar=c(4.1, 4.1, 1.6, 1.1))
ymx <- max(maxlod(out), maxlod(out_pg))
for(i in 1:num_phenotypes) {
    plot(out, biomass$gmap, lodcolumn=i, col=color[1], main=colnames(biomass$pheno)[i],
                      ylim=c(0, ymx*1.02), type="p", pch=20)
    plot(out_pg, biomass$gmap, lodcolumn=i, col=color[2], add=TRUE, type="p", pch=20)
    legend("topleft", lwd=2, col=color, c("H-K", "LMM"), bg="gray90", lty=c(1,1,2))
}
dev.off()
