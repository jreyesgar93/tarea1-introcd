library(rvest)
library(magritrr )


"""
Carga de la pagina que contiene los datos
"""
weather_cdmx <- read_html("https://www.timeanddate.com/weather/mexico/mexico-city/hourly")


"""
Datos a extraer: 

Time
Temp
Weather
Feels Like
wind
Humidity
Chance rain 
Ammount

"""


weather_cdmx %>%
  html_node() %>%
  html_text() %>%
  as.numeric()

weather_cdmx %>%
  html_node() %>%
  html_text() %>%
  as.numeric()

weather_cdmx %>%
  html_nodes(xpath ='')  %>%
  html_text() %>%
  as.numeric()




