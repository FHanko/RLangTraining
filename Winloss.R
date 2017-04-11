library(ggplot2)

source("RiotApiFunctions.R", local = TRUE)

glist <- Summoner.Recent(Summoner.Info("Mango%20MSev")$id)

plotvar <- glist$games$stats$win
plotvar <- as.data.frame(plotvar)
plotvar
plot <- ggplot(plotvar, aes(x = 1, fill = plotvar)) + geom_bar(width=1)
plot + coord_polar(theta = "y") + 
  scale_fill_discrete(
    name="Legend",
    breaks=c("FALSE", "TRUE"),
    labels=c("Loss", "Win")) + 
  theme(
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()) + 
  scale_y_continuous(breaks = 1:10) +
  labs(y = paste(sum(plotvar == TRUE) / 10 * 100, "%"))