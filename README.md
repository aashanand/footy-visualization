# About Euro Footy Charts

Ever wanted to go back in time to check out what was happening in the Premier League on the day you were born? Or maybe you just want to show your scouser mates that Liverpool were only top of the league on Christmas because they hadn't yet faced the other top teams...

The idea behind Euro Footy Charts is to build interactive visualizations that let anyone with an internet connection to explore historical football data, going all the way back to the first English top-flight match in 1888.

## How to use

#### Inputs
The main inputs require you to select a country, season and league. Currently, data for lower divisions are only available for England. Once you have picked your options, you can explore 3 different data outputs. You can optionally choose a date in the middle of the season to view the state of the league at that point in time.

#### Outputs
The **fixture map** details every game played in the league during a given season, its results and scores. Hover over a match for additional details. Choosing a date mid-way through a season removes any matches played before that date from the map. These interim snapshots provide context for how teams succeeded or struggled at different points in time during a season, which you don't get with just a post-season summary.

The **standings** tab displays the detailed league table for the year chosen, including details about number of matches played, goals scored and points. This table can also be regenerated for specific days during a season to see how the league standings looked at different points within a season.

Finally, the **ranking evolution** tab displays a time-series of each team's league position over the course of the season. While the standings table is a horizontal cross-section of league rankings, the ranking evolution chart is more of a vertical cross-section of the same data.

## Acknowledgements
1. The [engsoccerdata R package](https://github.com/jalapic/engsoccerdata) by James Curley contains the raw data used to generate these visualizations. I claim no responsibility for any errors in this data.
2. I used the [Highjarts javascript library](http://www.highcharts.com/) to create the fixture map and the ranking evolution chart. I used [rCharts](http://rcharts.io/) to generate javascript from R code, and put it all together using [RStudio](http://www.rstudio.com/) and [Shiny](http://shiny.rstudio.com/).
3. The fixture map builds on James Curley's static [visualization of La Liga 2013/2014 matches](http://rpubs.com/jalapic/laliga) using ggplot2. I have merely made the visualization interactive and dynamic, allowing anyone to reproduce it for any of the 682 league seasons for which the data is available, as well as for partial seasons.
4. The ranking evolution is inspired by similar visualizations by Keenan Davis [-link-](http://kenandavis.com/projects/a_season_visualized/), Ramnath Vaidyanathan [-link-](http://bl.ocks.org/ramnathv/5649396) and Anna Powell-Smith [-link-](http://thestoryoftheseason.com/). I have merely made the visualization dynamic, allowing users to regenerate it for multiple seasons and partial seasons.
5. Stefan Wilhelm's post [here](http://stefan-wilhelm.net/interactive-highcharts-heat-maps-in-r-with-rcharts/) saved me many hours of trying to figure out why the Highcharts heatmap wouldn't render using rCharts.
6. If you have ever posted anything on [stackoverflow](http://stackoverflow.com/), I have much gratitude for you.

#### Link to this app:
[https://aashanand.shinyapps.io/eurofootycharts](https://aashanand.shinyapps.io/eurofootycharts)

#### Code for this app:
[https://github.com/aashanand/footy-visualization](https://github.com/aashanand/footy-visualization)

### Contact

Aash Anand - aashirwad at uchicago dot edu
