library(rvest)
library(magritrr )


"""
Carga de la pagina que contiene los datos
"""
weather_cdmx <- read_html("https://www.timeanddate.com/weather/mexico/mexico-city/hourly")
x<-1

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


time<-weather_cdmx %>%
        html_node() %>%
        html_text() %>%
        as.numeric()


temp<-weather_cdmx %>%
        html_node() %>%
        html_text() %>%
        as.numeric()


weather<-weather_cdmx %>%
            html_node() %>%
            html_text() %>%
            as.character()


feels_like<-weather_cdmx %>%
              html_node() %>%
              html_text() %>%
              as.numeric()



wind<-weather_cdmx %>%
          html_node() %>%
          html_text()window()
          as.numeric()

          
humidity<-weather_cdmx %>%
            html_node() %>%
            html_text() %>%
            as.numeric()


chance_rain<-weather_cdmx %>%
                html_node() %>%
                html_text() %>%
                as.numeric()

ammount<-weather_cdmx %>%
            html_node() %>%
            html_text() %>%
            as.numeric()



"""
Juntar todas las variables en una sola base de datos y guardar resultado en csv

"""
          