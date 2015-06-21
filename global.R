## global.R
# library(engsoccerdata)
library(plyr)
library(dplyr)
library(rCharts)

data('engsoccerdata2', 'bundesliga',
     'italycalcio', 'holland1', 'spainliga',package="engsoccerdata")

# Static selector values for 'Country' selector
country.values <- list("England", "Germany",
                       "Italy", "Netherlands",
                       "Spain")

country.dfs <- list("England" = engsoccerdata2,
                    "Germany" = bundesliga,
                    "Italy" = italycalcio,
                    "Netherlands" = holland1,
                    "Spain" = spainliga)

rm('engsoccerdata2', 'bundesliga',
     'italycalcio', 'holland1', 'spainliga')

## One of the datasets has a non-standard field name and field structure
colnames(country.dfs[["England"]])[
        which(colnames(country.dfs[["England"]])=="Date")] <- 'date'
country.dfs[["England"]]$tier <- country.dfs[["England"]]$division

## Calculated columns for all datasets
country.dfs[["Germany"]]$tier <- revalue(
        as.character(country.dfs[["Germany"]]$tier), c("1"="Bundesliga"))
country.dfs[["Italy"]]$tier <- revalue(
        as.character(country.dfs[["Italy"]]$tier), c("1"="Serie A"))
country.dfs[["Netherlands"]]$tier <- revalue(
        as.character(country.dfs[["Netherlands"]]$tier), c("1"="Eredivisie"))
country.dfs[["Spain"]]$tier <- revalue(
        as.character(country.dfs[["Spain"]]$tier), c("1"="Primera Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season<1992)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season<1992)]), 
                c("1"="Football League First Division",
                  "2"="Football League Second Division",
                  "3"="Football League Third Division",
                  "3a"="Football Leage Third Division North",
                  "3b"="Football League Third Division South",
                  "4"="Football League Fourth Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season%in%1992:2004)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season%in%1992:2004)]), 
                c("1"="Premier League",
                  "2"="Football League First Division",
                  "3"="Football League Second Division",
                  "4"="Football League Third Division"))
country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season>2004)] <- 
        revalue(as.character(country.dfs[["England"]]$tier[which(country.dfs[["England"]]$Season>2004)]), 
                c("1"="Premier League",
                  "2"="Football League Championship",
                  "3"="Football League One",
                  "4"="Football League Two"))

country.dfs <- llply(country.dfs,
                     function(x) mutate(x, seasonValue=paste(Season,"-",Season+1),
                                        goaldif=hgoal-vgoal))
country.dfs <- llply(country.dfs,
                     function(x) mutate(x, result=ifelse(goaldif>0,1,
                                                         ifelse(goaldif<0,3,2))))

## Selector value generators for 'selectSeason' and 'selectTier' selectors
season.values <- function(country){
        as.list(sort(unique(country.dfs[[country]]$seasonValue),decreasing=T))
}

tier.values <- function(country,season){
        relevanttiers <- country.dfs[[country]]$tier[which(country.dfs[[country]]$seasonValue==season)]
        as.list(unique(relevanttiers))
}

season.table <- function(df,cutoff=NULL){
        temp <-
                rbind(
                        df %>% select(team=home, opp=visitor, GF=hgoal, GA=vgoal),
                        df %>% select(team=visitor, opp=home, GF=vgoal, GA=hgoal)
                ) #rbind two copies of the orignal df, simply reversing home/away team for each match
        if (!is.null(cutoff)) {
                temp <- filter(temp,date<cutoff)
        }
                
        temp1<-
                temp %>%
                mutate(GD = GF-GA) %>%
                group_by(team) %>%
                summarize(GP = n(),
                          gf = sum(GF),
                          ga = sum(GA),
                          gd = sum(GD),
                          W = sum(GD>0),
                          D = sum(GD==0),
                          L = sum(GD<0)
                ) %>%
                mutate(Pts = (W*3) + D) %>%
                arrange(desc(Pts))
        
        temp1 <- temp1 %>% mutate(pos = rank(desc(Pts)))
        temp1
}

heat.map.data <- function(country,season,div){
        df <- filter(country.dfs[[country]],
                     seasonValue==season & tier==div)
        
        df1 <- season.table(df)
        df1 <- df1 %>% select(team,pos) %>% arrange(pos)
        
        homeorder <- df1$team
        visitororder <- rev(df1$team)
        
        df$xpos <- aaply(df$visitor,1,function(x) which(homeorder==x)-1)
        df$ypos <- aaply(df$home,1,function(x) which(visitororder==x)-1)
        
        heatmapdata <- list()
        for (i in 1:dim(df)[1]){
                heatmapdata[[length(heatmapdata)+1]] <- list(
                        x=df[i,]$xpos,
                        y=df[i,]$ypos,
                        value=df[i,]$result,
                        fixture=paste(df[i,]$home,"vs.",df[i,]$visitor),
                        score=df[i,]$FT,
                        date=df[i,]$date)
        }
        
        return(list(homeorder,visitororder,heatmapdata))
}

create.heat.map <- function(country,season,tier){
        if(!is.null(season)&!is.null(tier)){
                hmd <- heat.map.data(country,season,tier)
                h1 <- Highcharts$new()
                h1$title(text=paste("Results Matrix for",tier,season))
                h1$chart(type="heatmap",height=800)
                h1$xAxis(categories=hmd[[1]],
                         labels=list(rotation=-90),
                         opposite=TRUE,
                         title=list(text="Away Team"),
                         gridLineColor="transparent",
                         lineColor="transparent",
                         tickColor="transparent")
                h1$yAxis(categories=hmd[[2]],
                         gridLineColor="transparent",
                         title=list(text="Home Team"))
                h1$series(data=hmd[[3]],
                          borderWidth=1,
                          dataLabels=list(enabled=TRUE,
                                          formatter="#!function(){return this.point.score;}!#"))
                h1$tooltip(followTouchMove=TRUE,followPointer=TRUE,
                           formatter="#!function(){return '<b>'+this.point.fixture+'</b><br>'+Highcharts.dateFormat('%b %d %Y',new Date(this.point.date))+'<br>'+this.point.score;}!#")
                h1$addParams(colorAxis=list(dataClasses=list(
                        list(from=1,to=1,color='#91bfdb',name="Home Win"),
                        list(from=2,to=2,color='#ffffbf',name="Draw"),
                        list(from=3,to=3,color='#fc8d59',name="Away Win")
                )))
                h1$addAssets(js=c("https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js",
                                 "https://code.highcharts.com/highcharts.js",
                                 "https://code.highcharts.com/highcharts-more.js",
                                 "https://code.highcharts.com/modules/exporting.js",
                                 "https://code.highcharts.com/modules/heatmap.js"))
                h1
        } else {
                Highcharts$new()
        }
}
