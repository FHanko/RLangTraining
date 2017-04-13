library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)

PlotDQF <- function(sumname)
{
print(sumname)
source("RiotApiFunctions.R", local = TRUE)

match.current <- Summoner.Current(Summoner.Info(sumname)$id)
match.current.sum.ids <- match.current$participants$summonerId
cmatchpar.names <- match.current$participants$summonerName
cmatchpar.names

# Development
#match.current <- Summoner.Matches(Summoner.Info(sumname)$id)
#match.current <- Summoner.Match(head(match.current$matches$matchId, 1))
#match.current.sum.ids <- match.current$participantIdentities$player$summonerId
#cmatchpar.names <- match.current$participantIdentities$player$summonerName
#

j= NULL
j$fun <- c(rep("Summoner.Matches",10))
j$par <- match.current.sum.ids
j <- as.data.frame(j, ncol(2))
j

matches.By.Par <- Time.Requests(j)
match.ids.agr <- NULL
i <- 0
for (i in 1:length(matches.By.Par))
{
  match.ids.By.Par <- NULL
  match.ids.By.Par$mid <- head(matches.By.Par[[i]]$matches$matchId, 10)
  match.ids.By.Par$sum.Name <- rep(cmatchpar.names[i], 10)
  match.ids.By.Par <- as.data.frame(match.ids.By.Par, ncol=2)
  match.ids.agr <- rbind(match.ids.agr, match.ids.By.Par)
}
match.ids.agr$id <- NULL
print(match.ids.agr)
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

DQFplot <- ggplot(other.df, aes(x = other.df$master, y = 1, fill = other.df$sum.Name)) + geom_bar(stat = "identity") +
  labs(x = "Summoner", y = "Games played with players in this match") +
  scale_fill_discrete(name = "Duo Partner") + scale_y_continuous(breaks = 1:10)
return(DQFplot)
}
