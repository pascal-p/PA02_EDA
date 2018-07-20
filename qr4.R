
plotFunQ4 <- function(ds) {
  ggplot(ds, aes(x=as.factor(ds$year), y=Emissions/1000, label=round(Emissions/1000, 1))) +
    geom_bar(stat="identity", fill="slategray3") +
    xlab("years") + ylab("kilotons of PM2.5") +
    scale_colour_gradientn(colours=rainbow(num_of_years(ds))) +
    geom_label(aes(fill=year, label=round(Emissions/1000)), colour="white", show.legend=F) +
    ggtitle(expression("PM"[2.5]*" emissions from coal combustion related sources in the US (in kilotons)")) + 
    theme_classic() +
    theme(
      plot.title = element_text(color="black", size=12, face="bold", hjust=0.5)
    )
}

calcQ4CoalCombEmissionsUS <- function(nei, scc, rexpr="comb.*coal") {
  df_scc_coal_comb <- scc %>%
    select(SCC, Short.Name) %>%
    filter(grepl(rexpr, Short.Name, ignore.case=T)) %>%
    select(SCC)
  
  nei %>%
    select(SCC, year, Emissions) %>%
    filter(SCC %in% df_scc_coal_comb$SCC) %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}
