
plotFunQ3 <- function(ds) {
  ggplot(ds, aes(x=as.factor(ds$year), y=Emissions)) +
    scale_colour_gradientn(colours=rainbow(num_of_years(ds))) +
    geom_bar(stat="identity", fill="slategray3") +
    geom_label(aes(fill=year, label=Emissions), colour="white", show.legend=F) +
    xlab("years") + ylab("tons of PM2.5") +
    facet_wrap(~type, nrow=2, ncol=2) +
    ggtitle(expression("PM"[2.5]*" emissions per type for Baltimore city (tons)")) +
    theme_classic() +
    theme(
      panel.background = element_rect(fill="azure1", colour="black", size=0.5, linetype="solid"),
      strip.background = element_rect(fill="lightskyblue3", colour="black", size=0.5),
      plot.title = element_text(color="black", size=12, face="bold", hjust=0.5)
    )
}

calcQ3TotEmissionsPerTypeC <- function(df, vfips="24510") {
  df %>%
    filter(fips == vfips)  %>%
    select(year, Emissions, type) %>%
    group_by(type, year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}
