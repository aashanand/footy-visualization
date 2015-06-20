## server.R
library(shiny)

shinyServer(function(input, output) {
        
        output$selectSeason <- renderUI({
                selectInput('selectSeason',
                            'Season',
                            season.values(input$selectCountry),
                            selected = input$selectSeason)
        })
        
        output$selectTier <- renderUI({
                if (length(tier.values(input$selectCountry,
                                       input$selectSeason))==0)
                        return()
                
                radioButtons('selectTier',
                             'Division', inline = T,
                             tier.values(input$selectCountry,
                                         input$selectSeason))
        })
        
        output$heatMap <- renderChart2({
                create.heat.map(input$selectCountry,
                                input$selectSeason,
                                input$selectTier)
        })
})