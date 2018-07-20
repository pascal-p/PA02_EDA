
plotFunQ6 <- function(ds) {
  ggplot(ds, aes(x=as.factor(ds$year), y=Emissions)) +
    scale_colour_gradientn(colours=rainbow(num_of_years(ds))) +
    geom_bar(stat="identity", fill="slategray3") +
    geom_label(aes(fill=year, label=Emissions), colour="white", show.legend=F) +
    xlab("years") + ylab("tons of PM2.5") +
    facet_wrap(~fips, nrow=1, ncol=2) +
    ggtitle(expression("Comparison PM"[2.5]*" emissions from motor vehicle in Baltimore City vs LA county")) +
    theme_classic() +
    theme(
      panel.background = element_rect(fill="azure1", colour="black", size=0.5, linetype="solid"),
      strip.background = element_rect(fill="lightskyblue3", colour="black", size=0.5),
      plot.title = element_text(color="black", size=12, face="bold", hjust=0.5)
    )
}

calcQ6TotEmissionsMotorVehC <- function(df, vfips="24510", vtype="ON-ROAD",
                                        vcity="Baltimore City") {
  withSelection(df, vfips, vtype, vcity)
}
