
plotFunQ2 <- function(ds) {
  with(ds, {
    barplot(height=Emissions, width=1, names.arg=year,
            xlab="years", ylab="tons of PM2.5",
            main="PM2.5 evolution for Baltimore City",
            col=c("slategray3"))
  })
}

calcQ2TotEmissionsC <- function(df, vfips="24510") {
  df %>%
    select(year, Emissions, fips) %>%
    filter(fips == vfips)  %>%
    select(year, Emissions) %>%
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}

