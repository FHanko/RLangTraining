library(ggplot2)

source("RiotApiFunctions.R", local = TRUE)

ret <- Summoner.Mastery((Summoner.Id.From.Name("Mango%20MSev"))$id)

ret <- as.data.frame(ret)

chart <- ggplot(ret, aes(x = championLevel, y=1))+
  geom_bar(width = 1, stat = "identity", aes(fill = ret$championLevel))
chart + coord_polar(theta = "y")