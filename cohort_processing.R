# get packages
library(ggplot2)
library(reshape2)
require(viridis)
 
# simulate cohort data
mydata = replicate(15, sort(runif(15, 1, 100), T))
mydata[lower.tri(mydata)] = NA
 
# convert to df and add cohort label
mydata = t(mydata)
mydata = as.data.frame(mydata)
mydata$cohort = as.factor(c(15:1))
 
# reshape and reorder
mydata = na.omit(melt(mydata, id.vars = "cohort"))
mydata$variable = as.numeric(gsub("V","",mydata$variable))
mydata$cohort = factor(mydata$cohort, levels=rev(levels(mydata$cohort)))
 
# plot cohort
ggplot(mydata, aes(variable, cohort)) +
 theme_minimal() +
 xlab('Week') +
 ylab('Cohort') +
 geom_tile(aes(fill = value), color='white') +
 scale_fill_viridis(direction = -1) +
 scale_x_continuous(breaks = round(seq(min(mydata$variable), max(mydata$variable), by = 1)))
