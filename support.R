
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

num_of_years <- function(ds) { length(unique(ds$year)) }

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
