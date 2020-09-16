
plot_colors <- c("#9E0142", "#D53E4F", "#F46D43", "#FDAE61", 
            "#FEE08B", "#FFFFBF", "#E6F598", "#ABDDA4", 
            "#66C2A5", "#3288BD", "#5E4FA2")

source("pops_to_files.R")
for (i in 1:10){
    png(paste0("TajD_", i, ".png"))
    # par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
    for (x in 1:length(file_names)){
        population <- file_names[x]
        df <- read.table(paste0("tajd.", population,".Tajima.D"), header=TRUE)
        # print(head(df))
        plot_df <- df[df$CHROM == i,]
        nan_coords <- which(is.na(plot_df$TajimaD))
        plot_df <- plot_df[-nan_coords,]
        loess_test <- loess(plot_df$TajimaD ~ plot_df$BIN_START, span=0.1)
        smoothed <- predict(loess_test)

        # smoothed[smoothed<0] <- 0
        if (x==1){
            plot(x=plot_df$BIN_START, y=smoothed, type="l", col=plot_colors[x], 
                 xlab="", ylab="", ylim=c(-1,1.5))
        } else {
            lines(x=plot_df$BIN_START, y=smoothed, type="l", col=plot_colors[x], 
                  xlab="", ylab="", ylim=c(-1,1.5))
        }
    }
    title(main=paste0("Chr",i), 
          xlab="position (Mb)", ylab="Tajima's D")
    abline(h=0)
    # legend("topright", inset=c(-0.3,0), legend=legend_names, fill=plot_colors)
    dev.off() 
}
