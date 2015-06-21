## global.R
library(engsoccerdata)
library(plyr)
library(dplyr)
library(rCharts)

data('engsoccerdata2', 'bundesliga',
     'italycalcio', 'holland1', 'spainliga')

# Static selector values for 'Country' selector
country.values <- list("England", "Germany",
                       "Italy", "Netherlands",
                       "Spain")

country.dfs <- list("England" = engsoccerdata2,
                    "Germany" = bundesliga,
                    "Italy" = italycalcio,
                    "Netherlands" = holland1,
                    "Spain" = spainliga)

rm('engsoccerdata2', 'bundesliga',
     'italycalcio', 'holland1', 'spainliga')

## One of the datasets has a non-standard field name and field structure
colnames(country.dfs[["England"]])[
        which(colnames(country.dfs[["England"]])=="Date")] <- 'date'
country.dfs[["England"]]$tier <- country.dfs[["England"]]$division

## Calculated columns for all datasets
country.dfs[["Germany"]]$tier <- revalue(
        as.character(country.dfs[["Germany"]]$tier), c("1"="Bundesliga"))
country.dfs[["Italy"]]$tier <- revalue(
        as.character(country.dfs[["Italy"]]$tier), c("1"="Serie A"))
country.dfs[["Netherlands"]]$tier <- revalue(
        as.character(country.dfs[["Netherlands"]]$tier), c("1"="Eredivisie"))
country.dfs[["Spain"]]$tier <- revalue(
        as.character(country.dfs[["Spain"]]$tier), c("1"="Primera Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season<1992)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season<1992)]), 
                c("1"="Football League First Division",
                  "2"="Football League Second Division",
                  "3"="Football League Third Division",
                  "3a"="Football Leage Third Division North",
                  "3b"="Football League Third Division South",
                  "4"="Football League Fourth Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season%in%1992:2004)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season%in%1992:2004)]), 
                c("1"="Premier League",
                  "2"="Football League First Division",
                  "3"="Football League Second Division",
                  "4"="Football League Third Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season>2004)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season>2004)]), 
                c("1"="Premier League",
                  "2"="Football League Championship",
                  "3"="Football League One",
                  "4"="Football League Two"))

country.dfs <- llply(country.dfs,
                     function(x) mutate(x, seasonValue=paste(Season,"-",Season+1)))

## Selector value generators for 'selectSeason' and 'selectTier' selectors
season.values <- function(country){
        as.list(sort(unique(country.dfs[[country]]$seasonValue),decreasing=T))
}

tier.values <- function(country,season){
        relevanttiers <- country.dfs[[country]]$tier[which(country.dfs[[country]]$seasonValue==season)]
        as.list(unique(relevanttiers))
}

heat.map.data <- function(country,season,div){
        df <- filter(country.dfs[[country]],
                     seasonValue==season & tier==div)
        df
}

create.heat.map <- function(country,season,tier){
        if(!is.null(season)&!is.null(tier)){
                df <- heat.map.data(country,season,tier)
                h1 <- Highcharts$new()
                h1$title(text=paste("Results Matrix for",tier,season))
                h1$chart(type="heatmap")
                h1$xAxis(categories=as.list(unique(df$visitor)))
                h1$yAxis(categories=as.list(unique(df$home)))
                h1
        } else {
                Highcharts$new()
        }
}
