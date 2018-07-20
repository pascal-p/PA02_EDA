
plotFunQ5 <- function(ds) {
  ggplot(ds, aes(x=as.factor(ds$year), y=Emissions, label=Emissions)) +
    geom_bar(stat="identity", fill="slategray3") +
    xlab("years") + ylab("tons of PM2.5") +
    scale_colour_gradientn(colours=rainbow(num_of_years(ds))) +
    geom_label(aes(fill=year, label=Emissions), colour="white", show.legend=F) +
    ggtitle(expression("PM"[2.5]*" emissions from motor vehicle in Baltimore City (tons)")) + 
    theme_classic() +
    theme(
      plot.title = element_text(color="black", size=12, face="bold", hjust=0.5)
    )
}

calcQ5TotEmissionsMotorVehC <- function(df, vfips="24510", vtype="ON-ROAD") {
  df %>%
    select(year, Emissions, fips, type) %>%
    filter(fips == vfips, type == vtype) %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}
