## ui.R
library(shiny)

shinyUI(fluidPage(
        
        title = "European Football Leagues",
        
        titlePanel("European Football leages"),
        
        fluidRow(
                column(12,
                       h4("1-2 lines about this app")
                )
        ),
        
        fluidRow(
                column(4,
                       selectInput('selectCountry','Country',country.list)
                       ),
                column(4,
                       htmlOutput('selectSeason')
                       ),
                column(4,
                       htmlOutput('selectTier')
                )
        ),
        
        hr()
))