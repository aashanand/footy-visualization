## server.R
library(dplyr)
library(engsoccerdata)

data(list=c("bundesliga", "holland1",
            "engsoccerdata2", "spainliga",
            "italycalcio"), package="engsoccerdata")
colnames(engsoccerdata2)[which(colnames(engsoccerdata2)=="Date")]='date'

league.list <- list("Bundesliga","Eredivisie",
                    "English Premier League",
                    "La Liga","Serie A")

season.list <- as.list(1:10)


shinyServer(function(input, output) {
        output$selectLeague <- renderUI({
                selectInput("league","League",league.list)
        })
        
        output$selectSeason <- renderUI({
                selectInput("season","Season",season.list)
        })
        
})