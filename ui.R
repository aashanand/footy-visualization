## ui.R
library(shiny)

shinyUI(fluidPage(
        
        title = "European Football Leagues",
        
        titlePanel("European Football leagues"),
        
        fluidRow(
                column(12,
                       h4("1-2 lines about this app")
                )
        ),
        
        fluidRow(
                column(6,
                       selectInput('selectCountry',
                                   'Country',
                                   country.values)
                       ),
                column(6,
                       htmlOutput('selectSeason')
                       )
                ),
        
        fluidRow(
                column(12,
                       htmlOutput('selectTier')
                )
        ),
        
        hr(),
        
        fluidRow(
                column(12,
                       showOutput('heatMap','Highcharts'))
        )
))