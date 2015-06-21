## ui.R
library(shiny)
library(shinythemes)

shinyUI(navbarPage("Euro Footy Charts",
                   tabPanel("Visualizations",
        fluidPage(
        
        tags$head(tags$script(src = "https://code.highcharts.com/highcharts.js"),
                  tags$script(src = "https://code.highcharts.com/highcharts-more.js"),
                  tags$script(src = "https://code.highcharts.com/modules/exporting.js"),
                  tags$script(src = "https://code.highcharts.com/modules/heatmap.js")
        ),
        
        title = "Euro Footy Charts",
        
        theme = shinytheme("flatly"),
        
        # titlePanel("Euro Footy Charts"),
        
        fluidRow(
                column(12,
                       h4("Explore data from 8 football leagues in 5 countries, spanning 127 years.")
                )
        ),
        
        hr(),
        
        fluidRow(
                column(4,
                       selectInput('selectCountry',
                                   'Country:',
                                   country.values)
                       ),
                column(4,
                       htmlOutput('selectSeason')
                       ),
                column(4,
                       htmlOutput('selectDate')
                )
        ),
        
        fluidRow(
                column(12,
                       htmlOutput('selectTier')
                )
        ),
        
        hr(),
        
        tabsetPanel(type="tabs",
                    tabPanel("Results Matrix",showOutput('heatMap','highcharts')),
                    tabPanel("Standings",dataTableOutput('standingsTable')),
                    tabPanel("Ranking Evolution",h6("This plot might take a few moments to render. Zoom by dragging your mouse over the plot. Filter by clicking the legend."),showOutput('storyPlot','highcharts'))
                    )
        )
),
tabPanel("About",
         fluidPage(includeMarkdown('README.md')))))