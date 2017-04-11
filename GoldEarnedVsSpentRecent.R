library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)

source("RiotApiFunctions.R", local = TRUE)

glist <- Summoner.Recent(Summoner.Info("Mango%20MSev")$id)
plotvar = NULL
plotvar1 <- glist$games$stats$goldEarned
plotvar2 <- glist$games$stats$goldSpent
plotvar$ind <- 1:10
plotvar$earned <- plotvar1
plotvar$spent <- plotvar2
plotvar <- as.data.frame(plotvar)
plotvar
names(plotvar) <- c("Game", "Earned", "Spent")
plotvar <- melt(plotvar, id.vars = "Game")
plotvar
p1 <- ggplot(plotvar, aes(y=value,x=Game, fill = variable)) + geom_bar(stat="identity", position = "dodge", width = 0.5) +
  scale_x_discrete(limits =(plotvar$Game)) +
  scale_fill_discrete(name = "Legend") + labs(y = "Gold")


grouped <- group_by(plotvar, Game)
suma <- summarise(grouped, diff=diff(value))
suma
thplot <- as.data.frame(suma)
thplot
p2 <- ggplot(thplot, aes(x=Game, y = diff, fill = diff)) + geom_bar(stat="identity", position = "dodge", width = 0.5)+
  scale_x_discrete(limits =(plotvar$Game)) + labs(y = "difference") +
  scale_fill_continuous(name = "Legend") + -

grid.arrange(p1, p2, ncol = 2)

