library(ggplot2)
library(reshape2)
library(dplyr)
library(grid)
library(gridExtra)
source("RiotApiFunctions.R", local = TRUE)

matches <- Summoner.Matches(Summoner.Info("Mango%20MSev")$id)

champion.data <- Meta.Champions("info")
champion.data.frame <- as.data.frame(champion.data)
  
x <- champion.data.frame[grepl("\\.name", names(champion.data.frame))]
y <- unlist(x, recursive = FALSE)
champs <- levels(y)

x <- champion.data.frame[grepl("\\.id", names(champion.data.frame))]
ids <- NULL
for(i in 1:length(x)) {ids <- rbind(ids, x[[i]])}
ids

id.champ <- NULL
id.champ$id <- ids
id.champ$champ <- champs
id.champ.frame <- as.data.frame(id.champ)

matches.per.champ <- as.data.frame(table(matches$matches$champion))
matches.per.champ <- head(arrange(matches.per.champ, desc(Freq)), 15)

colnames(matches.per.champ) <- c("id","freq")
matches.per.champ = merge(id.champ.frame, matches.per.champ, by = "id")
ggplot(matches.per.champ, aes(x = matches.per.champ$champ, y = matches.per.champ$freq)) +
  geom_bar(stat = "identity") + coord_flip() + labs(x = "Champion", y = "Total ranked games")

