## global.R
library(engsoccerdata)
library(plyr)
library(dplyr)

data('engsoccerdata2', 'bundesliga',
     'italycalcio', 'holland1', 'spainliga')

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

## Tier column recode function
# tier.recode <- function(cname, tiercol){
#         if (cname=="Germany"){
#                 tiercol <- revalue(as.character(tiercol), c("1"="Bundesliga"))
#         } else if (cname=="Italy"){
#                 tiercol <- revalue(as.character(tiercol), c("1"="Serie A"))
#         } else if (cname=="Netherlands"){
#                 tiercol <- revalue(as.character(tiercol), c("1"="Eredivisie"))
#         } else if (cname=="Spain"){
#                 tiercol <- revalue(as.character(tiercol), c("1"="La Liga"))
#         }
#         return(tiercol)
# }

## Calculated columns for all datasets
country.dfs <- llply(country.dfs,
                     function(x) mutate(x, seasonValue=paste(Season,"-",Season+1)))
# country.dfs <- llply(seq_along(country.dfs),
#                      function(x,names) mutate(country.dfs[[x]],
#                                               tier=tier.recode(names[x],
#                                                                country.dfs[[x]]$tier)),
#                      names=names(country.dfs))

## Selector value generators for 'selectSeason' and 'selectTier' selectors
season.values <- function(country){
        as.list(sort(unique(country.dfs[[country]]$seasonValue),decreasing=T))
}

tier.values <- function(country,season){
        relevanttiers <- country.dfs[[country]]$tier[which(country.dfs[[country]]$seasonValue==season)]
        as.list(unique(relevanttiers))
}
