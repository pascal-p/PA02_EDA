
plotFunQ1 <- function(ds) {
  with(ds, { 
    barplot(height=Emissions/1000, width=1, names.arg=year,
            xlab="years", ylab="kilotons of PM2.5",
            main="PM2.5 evolution for the US",
            col=c("slategray3"))
  }
  )
}

calcQ1TotEmissionsUS <- function(df) {
  df %>%
    select(year, Emissions, fips) %>%
    select(year, Emissions) %>% 
    group_by(year) %>%
    summarize_all(funs(as.integer(sum(.))), na.rm=T)
}
