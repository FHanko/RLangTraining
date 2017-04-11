library(ggplot2)

source("RiotApiFunctions.R", local = TRUE)

glist <- Summoner.Recent(Summoner.Info("Mango%20MSev")$id)

plotvar <- glist$games$stats$goldEarned
plotvar <- as.data.frame(plotvar)
plotvar$index <- (row.names(plotvar))
plotvar

ggplot(plotvar, aes(x = index, y = plotvar, fill = plotvar)) + geom_bar(stat = "identity") +
  scale_x_discrete(limits = plotvar$index) + labs(x = "Game", y = "Gold") + scale_fill_continuous(name = "Legend")