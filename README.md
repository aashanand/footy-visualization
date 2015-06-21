# footy-visualization
A Shiny App built on the engsoccerdata R package

Maintenance/To-Do:
1. Re-deploy with new data when jalapic releases updated versions of the engsoccerdata R package.
2. Refactor league selector if jalapic releases new tables
3. Refactor initial dataset loading if there exists a way to load datasets directly into named list without creating copies.
4. Radio button needs to remember selection for England only
5. App needs to not reload outputs twice when inputs change
6. Remove ugly timeoutMS error from console (related to selectDate input)


Post to StackOverflow/Research Later:
1. how to use assign() to dispatch assignment methods
2. shiny: ui.R possibly crashes when named list is large
3. shiny: reactive expressions vs. global functions pros & cons