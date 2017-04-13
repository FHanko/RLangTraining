library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)

source("RiotApiFunctions.R", local = TRUE)

match.current <- Summoner.Current(Summoner.Info("Mango%20MSev")$id)
match.current.sum.ids <- match.current$participants$summonerId
cmatchpar.names <- match.current$participants$summonerName
cmatchpar.names

j= NULL
j$fun <- c(rep("Summoner.Matches",10))
j$par <- match.current.sum.ids
j <- as.data.frame(j, ncol(2))
j

matches.By.Par <- Time.Requests(j)
match.ids.agr <- NULL
for (i in 1:length(matchesByPar))
{
  match.ids.By.Par <- NULL
  match.ids.By.Par$mid <- head(matches.By.Par[[i]]$matches$matchId, 10)
  match.ids.By.Par$sum.Name <- rep(cmatchpar.names[i], 10)
  match.ids.By.Par <- as.data.frame(match.ids.By.Par, ncol=2)
  match.ids.agr <- rbind(match.ids.agr, match.ids.By.Par)
}
match.ids.agr$id <- NULL

# deprecated?
dups <- match.ids.agr[ duplicated(match.ids.agr$mid) ,]$mid
pre <- match.ids.agr[ which(match.ids.agr$mid %in% dups) ,]
all.names <- as.character(unique(pre$sum.Name))
other.df <- NULL
for(i in 1:length(all.names))
{
  all.per.sum <- pre[ (which(pre$mid %in% pre[(pre$sum.Name == all.names[i]),]$mid)) ,]
  other.in.prev <- all.per.sum[all.per.sum$sum.Name != all.names[i],]
  other.in.prev$master <- all.names[i]
  other.df <- rbind(other.df, other.in.prev)
}

other.df

table(pre)

ggplot(other.df, aes(x = other.df$master, y = 1, fill = other.df$sum.Name)) + geom_bar(stat = "identity") +
  labs(x = "Summoner", y = "Games played with players in this match") +
  scale_fill_discrete(name = "Duo Partner") + scale_y_continuous(breaks = 1:10)