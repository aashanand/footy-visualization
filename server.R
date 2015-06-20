## server.R
library(shiny)

shinyServer(function(input, output) {
        
        output$selectSeason <- renderUI({
                selectInput('selectSeason',
                            'Season',
                            season.values(input$selectCountry))
        })
        
        output$selectTier <- renderUI({
                radioButtons('selectTier',
                             'Division',
                             tier.values(input$selectCountry,
                                         input$selectSeason))
        })
})