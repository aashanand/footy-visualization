## ui.R
library(shiny)

shinyUI(fluidPage(
        
        title = "European Football Leagues",
        
        titlePanel("European Football leages"),
        
        fluidRow(
                column(4,
                       selectInput('selectCountry','Select Country',country.list)
                       ),
                column(4,
                       selectInput('selectSeason','Select Season',season.list)
                       ),
                column(4,
                       selectInput('selectTier','Select Tier',tier.list)
                )
        ),
        
        hr()
))