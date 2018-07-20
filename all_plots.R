library(dplyr)
library(ggplot2)

source("support.R")
source("qr1.R")
source("qr2.R")
source("qr3.R")
source("qr4.R")
source("qr5.R")
source("qr6.R")

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
