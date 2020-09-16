
plot_colors <- c("#9E0142", "#D53E4F", "#F46D43", "#FDAE61", 
            "#FEE08B", "#FFFFBF", "#E6F598", "#ABDDA4", 
            "#66C2A5", "#3288BD", "#5E4FA2")

source("pops_to_files.R")
for (i in 1:10){
    png(paste0("NtDiv_", i, ".png"))
    par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
    for (x in 1:length(file_names)){
        population <- file_names[x]
        df <- read.table(paste0("nt_diversity.", population,".sites.pi"), header=TRUE)
        # print(head(df))
        plot_df <- df[df$CHROM == i,]
        loess_test <- loess(plot_df$PI ~ plot_df$POS, span=0.05)
        smoothed <- predict(loess_test)
        smoothed[smoothed<0] <- 0
        if (x==1){
            plot(smoothed, x=plot_df$POS, type="l", col=plot_colors[x], 
                 xlab="", ylab="", ylim=c(0,0.23))
        } else {
            lines(plot_df$POS, smoothed, type="l", col=plot_colors[x], 
                  xlab="", ylab="", ylim=c(0,0.23))
        }
    }
    title(main=paste0("Chr",i), 
          xlab="position (Mb)", ylab="nucleotide diversity")
    legend("topright", inset=c(-0.3,0), legend=legend_names, fill=plot_colors)
    dev.off() 
}
