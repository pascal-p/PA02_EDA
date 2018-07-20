library(dplyr)
library(ggplot2)

loadFiles <- function(filename="./exdata_data_NEI_data.zip") {
  file_list <- dir(pattern = "*.rds")
  if (length(file_list) == 0) { # do we need to unzip the file
    l <- strsplit(basename(filename), c("\\."))
    suffix <- l[[1]][[-1]]
    if (suffix == "zip") { unzip(filename) }
    file_list <- dir(pattern = "*.rds")
  }
  # now load the 2 rds file in memory, in order
  dsl = list()
  ix <- 1
  for (file in sort(file_list, decreasing=T)) {
    dsl[[ix]] <- readRDS(file)
    ix <- ix + 1
  }
  return(dsl)
}

plotFunQ1 <- function(ds) {
  with(ds, { 
    barplot(height=Emissions/1000, width=1, names.arg=year,
            xlab="years", ylab="kilotons of PM2.5",
            main="PM2.5 evolution for the US",
            col=c("slategray3"))
    }
  )
}

plotFunQ2 <- function(ds) {
  with(ds, {
    barplot(height=Emissions, width=1, names.arg=year,
            xlab="years", ylab="tons of PM2.5",
            main="PM2.5 evolution for Baltimore City",
            col=c("slategray3"))
  })
}

num_of_years <- function(ds) { length(unique(ds$year)) }

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

withPng <- function(df, plotfun, filename="plots/plot1.png", ptype='base') {
  png(filename=filename, width=520, height=520, bg="white")
  if (ptype == 'base') {
    plotfun(df)
  }
  else {
    # assume ggplot2
    ggp <- plotfun(df)
    print(ggp)
  }
  dev.off()
}

calcQ1TotEmissionsUS <- function(df) {
  df %>%
    select(year, Emissions, fips) %>%
    select(year, Emissions) %>% 
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}

calcQ2TotEmissionsC <- function(df, vfips="24510") {
  df %>%
    select(year, Emissions, fips) %>%
    filter(fips == vfips)  %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}

calcQ3TotEmissionsPerTypeC <- function(df, vfips="24510") {
  df %>%
    filter(fips == vfips)  %>%
    select(year, Emissions, type) %>%
    group_by(type, year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
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

calcQ5TotEmissionsMotorVehC <- function(df, vfips="24510", vtype="ON-ROAD") {
  df %>%
    select(year, Emissions, fips, type) %>%
    filter(fips == vfips, type == vtype) %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}

withSelection <- function(df, vfips="24510", vtype="ON-ROAD", 
                          vcity="Baltimore City") {
  df %>% 
    select(year, Emissions, fips, type) %>%
    filter(fips == vfips, type == vtype) %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T) %>%
    mutate(fips = vcity)
}

calcQ6TotEmissionsMotorVehC <- function(df, vfips="24510", vtype="ON-ROAD",
                                        vcity="Baltimore City") {
  withSelection(df, vfips, vtype, vcity)
}

#
# main 
#
if (!exists("dsl")) { 
  dsl <- loadFiles() 
  nei <- tibble::as.tibble(dsl[[1]])
  scc <- tibble::as.tibble(dsl[[2]])
}

## Q1 - Calculate total emissions from PM2.5 in the US over the 10-year period 1999–2008.
tot_emiss_us <- calcQ1TotEmissionsUS(nei)
withPng(tot_emiss_us, plotFunQ1)
 
## Q2 - Calculate total emissions from PM2.5 for Baltimore City over the 10-year period 1999–2008.
tot_emiss_balt <- calcQ2TotEmissionsC(nei)
withPng(tot_emiss_balt, plotFunQ2, "plots/plot2.png")
 
## Q3 - Calculate total emissions per type for Baltimore City over the 10-year period 1999–2008.
tot_emiss_by_type <- calcQ3TotEmissionsPerTypeC(nei)
withPng(tot_emiss_by_type, plotFunQ3, "plots/plot3.png", ptype='ggplot2')
 
## Q4 - Calculate total emissions coal combustion related for the US over the 10-year period 1999–2008
tot_coal_emiss_us <- calcQ4CoalCombEmissionsUS(nei, scc)
withPng(tot_coal_emiss_us, plotFunQ4, "plots/plot4.png", ptype='ggplot2')
    
## Q5 - Calculate total emissions from motor vehicle sources for Baltimore City 
tot_vehicle_emiss_balt <- calcQ5TotEmissionsMotorVehC(nei)
withPng(tot_vehicle_emiss, plotFunQ5, "plots/plot5.png", ptype='ggplot2')
 
## Q6 - Calculate total emissions from motor vehicle sources for Baltimore City 

# Q6.1 - Calculate total emissions from motor vehicle sources for Baltimore City (Q5)
tot_vehicle_emiss_balt <- calcQ6TotEmissionsMotorVehC(nei)

# Q6.2 - Calculate total emissions from motor vehicle sources for LA county 
tot_vehicle_emiss_la <- calcQ6TotEmissionsMotorVehC(nei,
                                                    vfips="06037", vcity="Los Angeles County")
# Q6.3 - Combine and plot...
withPng(rbind(tot_vehicle_emiss_balt, tot_vehicle_emiss_la), 
        plotFunQ6, "plots/plot6.png", ptype='ggplot2')
