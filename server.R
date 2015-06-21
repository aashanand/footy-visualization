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
                             'Division',
                             inline = T,
                             tier.values(input$selectCountry,
                                         input$selectSeason))
        })
        
        output$heatMap <- renderChart2({
                create.heat.map(input$selectCountry,
                                input$selectSeason,
                                input$selectTier,
                                input$selectDate)
        })
        
        output$selectDate <- renderUI({
                dateInput('selectDate',"See state of the league as on:",
                          format="M dd yyyy",
                          min=date.values(input$selectCountry,
                                          input$selectSeason,
                                          input$selectTier)[[1]],
                          max=date.values(input$selectCountry,
                                          input$selectSeason,
                                          input$selectTier)[[2]],
                          value=date.values(input$selectCountry,
                                            input$selectSeason,
                                            input$selectTier)[[2]])
        })
        
        output$standingsTable <- renderDataTable(
                standings.table.data(input$selectCountry,
                                     input$selectSeason,
                                     input$selectTier,
                                     input$selectDate),
                options = list(lengthChange=F,autoWidth=F,
                               columnDefs=list(list(width="48%",targets=0))
                               ))
        
})