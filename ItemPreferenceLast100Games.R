library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)

source("RiotApiFunctions.R", local = TRUE)

itda <- Meta.Items()
glist <- Summoner.Matches(Summoner.Info("FNC%20Rekkles")$id)
totalitems <- c()

adcmatches <- subset(glist$matches, glist$matches$role=="DUO_CARRY" & glist$matches$season=="PRESEASON2017")
head(adcmatches$matchId, 3)
print(adcmatches[1,]$timestamp, digits = 21)
j= NULL
j$fun <- c(rep("Summoner.Match",100))
j$par <- head(adcmatches$matchId, 100)
j <- as.data.frame(j, ncol(2))
j
vv <- 0
m <- Time.Requests(j)
for(uga in 1:length(m))
{
  cm <- m[[uga]]
  pid <- Position(cm, cm$participantIdentities$player$summonerName == "FNC Rekkles")
  ail <-  c(cm$participants$stats$item0[pid], cm$participants$stats$item1[pid], cm$participants$stats$item2[pid],
            cm$participants$stats$item3[pid], cm$participants$stats$item4[pid], cm$participants$stats$item5[pid])
  ail
  
  vv <- vv + cm$participants$stats$visionWardsBoughtInGame[pid]
  
  for(uit in ail)
  {
    ina <- eval(parse(text = (paste("itda$data$`", uit ,"`$name", sep = ""))))
    print(ina)
    if(!is.null(ina))
    { totalitems <- append(totalitems, ina) }          
  }
}


totalitems
totalitemstable <- table(totalitems)
totalitemsdf <- as.data.frame(totalitemstable)
totalitemsdf <- subset(totalitemsdf, totalitemsdf$Freq>=5)
ggplot(totalitemsdf, aes(x = totalitemsdf$totalitems, y = totalitemsdf$Freq, fill = totalitemsdf$Freq)) + geom_bar(stat = "identity") +
  labs(x = "Item", y = "Count") + coord_flip() + scale_fill_continuous(name = "Item Count")
  
  
  vv
  