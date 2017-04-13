library(jsonlite)
library(httr)

key <- as.character(read.table("apikey.txt")[1,])

Summoner.Info <- function(sumname)
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- paste("/lol/summoner/v3/summoners/by-name/", sumname, sep = "")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Meta.Champions <- function(adopts = "all")
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- "/lol/static-data/v3/champions"
  url <- paste(url, apitree,"?champData=", adopts,"&api_key=", key, sep="")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Summoner.Mastery <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/championmastery/location/EUW1/player/", sumid,"/champions", sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Summoner.Recent <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v1.3/game/by-summoner/", sumid,"/recent", sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Summoner.Current <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/observer-mode/rest/consumer/getSpectatorGameInfo/EUW1/", sumid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Summoner.Matches <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v2.2/matchlist/by-summoner/", sumid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Summoner.Match <- function(mid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v2.2/match/", mid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)
}

Meta.Items <- function()
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- "/lol/static-data/v3/items"
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  print(url)
  req <- httr::GET(url)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  return(ret)             
}

Time.Requests <- function(j)
{
  ret = NULL
  i <- 0
  for (i in 1:nrow(j)) {
    print(i)
    argtt <- list(j[i,]$par)
    f <- get(as.character(j[i,]$fun))
    if(i == 1) {ret <- list(f(argtt))}
    else
    {
    ret <- append(ret, list(f(argtt)))    
    }
    Sys.sleep(1.2)
  }
  return(ret)
}