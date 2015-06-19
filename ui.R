## ui.R
library(shiny)

data('engsoccerteams', package='engsoccerdata')

shinyUI(fluidPage(
        
        title = "Historical Football Visualizations",
        
        titlePanel("Historical European Football Visualizations"),
        
        fluidRow(
                column(6,
                       htmlOutput('selectLeague')
                       ),
                column(6,
                       htmlOutput('selectSeason')
                       )
        ),
        
        hr()
))