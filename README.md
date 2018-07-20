---
title: "Exploratory Analysis Week4 - Project2"
date: "July, 2018"
author: Pascal P
output:
  html_document:
    toc: true
    number_sections: true
    df_print: paged
    highlight: zenburn
    theme: simplex
---

# Details
  Can be found at [Coursera - Exploratory Data Analysis](https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2)
  
  The introduction is repeated here for convenience:
  
  *Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the [EPA National Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).*

  *For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.*
  
# Goal of assigment
  Explore the National Emissions Inventory database and see what it says about fine particulate matter pollution in the United states over the 10-year period 1999–2008.
  
  Specifically, the following questions and tasks must be addressed in the exploratory analysis providing plot as evidences.
  
  1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?  
  Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
  
  2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?  
  Use the base plotting system to make a plot answering this question.
    
  3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?  
  Which have seen increases in emissions from 1999–2008?  
  Use the ggplot2 plotting system to make a plot answer this question.
    
  4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
    
  5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
  
  6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").  
  Which city has seen greater changes over time in motor vehicle emissions?
  
# Work done
  - A main script `all_plots.R` which build the 6 required plots, by sourcing the 6 `qr[1-6].R`, it uses `dplyr` and `ggplot2` `R`-packages.  
  It also contains some comments on what was done.   
  This script assumes the data is available in the same directory this script is located.  
  Data downloadable [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip).   
  Organisation  
```
all_plots.R
qr1.R
qr2.R
qr3.R
qr4.R
qr5.R
qr6.R
support.R
plots/
README.md
Source_Classification_Code.rds # not provided
summarySCC_PM25.rds            # not provided
```

  - All plots are png files saved under `plots/` sub-directory.