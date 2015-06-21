## ui.R
library(shiny)

shinyUI(fluidPage(
        
        tags$head(tags$script(src = "https://code.highcharts.com/highcharts.js"),
                  tags$script(src = "https://code.highcharts.com/highcharts-more.js"),
                  tags$script(src = "https://code.highcharts.com/modules/exporting.js"),
                  tags$script(src = "https://code.highcharts.com/modules/heatmap.js")
        ),
        
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