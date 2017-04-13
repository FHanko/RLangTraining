library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)

source("RiotApiFunctions.R", local = TRUE)

champinfo <- Meta.Champions("info")
champinfo.frame <- as.data.frame(champinfo)
agrnames <- NULL
names <- (champinfo.frame[ grepl("name", colnames(champinfo.frame))])
for(i in 1:length(names))
{
  agrnames <- c(agrnames, gsub("[^a-zA-Z]", "", as.character((champinfo.frame[ grepl("name", colnames(champinfo.frame))])[[i]])) )
}
agrnames <- sort(agrnames)
agrnames <- gsub("LeBlanc", "Leblanc", agrnames)
agrnames <- gsub("ChoGath", "Chogath", agrnames)
agrnames <- gsub("KhaZix", "Khazix", agrnames)
agrnames <- gsub("VelKoz", "Velkoz", agrnames)
agrnames <- gsub("Wukong", "MonkeyKing", agrnames)
champall <- Meta.Champions()
champstatdf <- NULL
for(i in 1:length(agrnames))
{
  cdf <- eval(parse(text = (paste("as.data.frame(",(paste("champall$data$", agrnames[i],"$stats", sep = "")), ")", sep = ""))))
  cdf$name <- agrnames[i]
  champstatdf <- rbind(champstatdf, cdf)
}

champstatdf
champstatdfmelt <- melt(champstatdf)
colnames(champstatdfmelt)
champstatdfmelt <- champstatdfmelt[(champstatdfmelt$name == "TwistedFate"),]
ggplot(champstatdfmelt, aes(x = name, y = value, fill = variable)) + geom_bar(stat = "identity",width = 0.8) + coord_flip()