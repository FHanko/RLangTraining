library(jsonlite)
library(httr)

key <- as.character(read.table("apikey.txt")[1,])

Summoner.Info <- function(sumname)
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- paste("/lol/summoner/v3/summoners/by-name/", sumname, sep = "")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Meta.Champions <- function(adopts = "all")
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- "/lol/static-data/v3/champions"
  url <- paste(url, apitree,"?champData=", adopts,"&api_key=", key, sep="")
  return(Get.JSON(url))    
}

Summoner.Mastery <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/championmastery/location/EUW1/player/", sumid,"/champions", sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Summoner.Recent <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v1.3/game/by-summoner/", sumid,"/recent", sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Summoner.Current <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/observer-mode/rest/consumer/getSpectatorGameInfo/EUW1/", sumid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Summoner.Matches <- function(sumid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v2.2/matchlist/by-summoner/", sumid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Summoner.Match <- function(mid)
{
  url <- "https://euw.api.riotgames.com"
  apitree <- paste("/api/lol/EUW/v2.2/match/", mid, sep="")
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Meta.Items <- function()
{
  url <- "https://euw1.api.riotgames.com"
  apitree <- "/lol/static-data/v3/items"
  url <- paste(url, apitree, "?api_key=", key, sep = "")
  return(Get.JSON(url))    
}

Get.JSON <-function(geturl)
{
  print(geturl)
  req <- httr::GET(geturl)
  json <- httr::content(req, as = "text")
  ret <- fromJSON(json)
  stat <- ret$status$status_code
  if(!is.null(stat))
  {
    if(stat == 503)
    {
      print(paste(stat, ":No Success will repeat in 2 seconds"))
      Sys.sleep(2)  
      return(Get.JSON(geturl))
    }
    else
    {
      print(paste("No ex for", stat))
    }
  }
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