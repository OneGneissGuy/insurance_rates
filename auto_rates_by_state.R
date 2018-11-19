library(plotly)
df <- read.csv("https://raw.githubusercontent.com/OneGneissGuy/insurance_rates/master/auto.csv")

df$hover <- with(df, paste(State, '<br>', "Auto Rates", Annual.Rate))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

p <- plot_geo(df, locationmode = 'USA-states') %>%
  add_trace(
    z = ~Annual.Rate, text = ~hover, locations = ~Abbreviation,
    color = ~Annual.Rate, colors = 'Blues'
  ) %>%
  colorbar(title = "US Dollars") %>%
  layout(
    title = 'Annual Auto Insurance Rates by State',
    geo = g
  )
api_create(p, filename = "r-docs-auto-rates-by-state")
