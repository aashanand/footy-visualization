## ui.R
library(shiny)

shinyUI(fluidPage(
        
        tags$head(tags$script(src = "https://code.highcharts.com/highcharts.js"),
                  tags$script(src = "https://code.highcharts.com/highcharts-more.js"),
                  tags$script(src = "https://code.highcharts.com/modules/exporting.js"),
                  tags$script(src = "https://code.highcharts.com/modules/heatmap.js")
        ),
        
        title = "Euro Footy Charts",
        
        titlePanel("Euro Footy Charts"),
        
        fluidRow(
                column(12,
                       h4("Explore data from 682 seasons of football, covering 8 leagues in 5 countries.")
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
        
        fluidRow(
                column(6,
                       htmlOutput('selectDate')
                       )
                ),
        
        hr(),
        
        tabsetPanel(type="tabs",
                    tabPanel("Results Matrix",showOutput('heatMap','Highcharts')),
                    tabPanel("Standings",dataTableOutput('standingsTable'))
                    
        
)))