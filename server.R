## server.R
library(shiny)

shinyServer(function(input, output) {
        output$selectSeason <- renderUI({
                selectInput('selectSeason','Season',season.list)
        })
        output$selectTier <- renderUI({
                selectInput('selectTier','Tier',tier.list)
        })
})