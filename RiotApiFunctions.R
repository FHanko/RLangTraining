library(jsonlite)
library(httr)
key <- "Riot Api Key Here"

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

Champion.Data.All <- function()
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- "/lol/static-data/v3/champions"
  url <- paste(url, apitree, "?champData=all&api_key=", key, sep="")
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

