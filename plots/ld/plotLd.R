

bp_file <- c("NAM.stat","NAM.chr01.stat","NAM.chr02.stat","NAM.chr03.stat","NAM.chr04.stat","NAM.chr05.stat","NAM.chr06.stat","NAM.chr07.stat","NAM.chr08.stat","NAM.chr09.stat","NAM.chr10.stat")

png("LD_decay_figure2.png",width=10,height=7,res=600,unit="in",type="cairo")
par(mai=c(1,1,0.5,0.5))
plot(0,0,xlim=c(0,600000),ylim=c(0,0.6),axes=F, type="n",xlab="Distance KB",ylab=expression(r^2),cex.lab=1.5)
axis(1,at=seq(0,600000,length=7),labels=seq(0,600,length=7))
axis(2,at=c(0,0.1,0.2,0.3,0.4,0.5,0.6),labels=c(0,0.1,0.2,0.3,0.4,0.5,0.6))
col <- c("red","chocolate","coral4","cornflowerblue","cornsilk4","cyan2","darkblue","darkgoldenrod2","blue","blueviolet","darkolivegreen4")
for(i in c(2:11,1)){
    ld <- read.table(bp_file[i],header=F)
    smoothingSpline = smooth.spline(ld$V1,ld$V2, spar=0.05)
    lines(smoothingSpline,col=col[i],lwd=ifelse(i==1,2,1),lty=2)
}

legend("topright",legend=c("Whole genome","Chr01","Chr02","Chr03","Chr04","Chr05","Chr06","Chr07","Chr08","Chr09","Chr10"),pch=15,col=col,bty="n",cex=1.5)
#legend(300000,0.6,legend=c("RILS","Landraces"),lty=c(2,1),bty="n",lwd=3,cex=1.5)
dev.off()
