library(rvest)
library(magritrr )


'''
Carga de la pagina que contiene los datos

'''
weather_cdmx <- read_html("https://www.timeanddate.com/weather/mexico/mexico-city/hourly")
x<-1


'''
Datos a extraer: 

Time
Temp
Weather
Feels Like
wind
Humidity
Chance rain 
Ammount

'''

weather_scrapping<-function(html_name,td_pos){
   
       # Esta función toma tomo argumentos el html, 
      #  la posición del elemento a extraer.
        # Return Character vector
      
        vec<-c()
        for (i in c(1:24)){
                value<-html_name %>%
                        html_node(xpath=paste('//*[@id="wt-hbh"]/tbody/tr[',i,']/td[',td_pos,']',sep="")) %>%
                        html_text() %>%
                        as.character()
                vec<-c(vec,value)
        }
        return(vec)
}





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


feels_like<-weather_scrapping(weather_cdmx,4)


wind<-weather_scrapping(weather_cdmx,5)
                
humidity<-weather_scrapping(weather_cdmx,7)

chance_rain<-weather_cdmx %>%
                html_node() %>%
                html_text() %>%
                as.numeric()

ammount<-weather_cdmx %>%
            html_node() %>%
            html_text() %>%
            as.numeric()

'''
Juntar todas las variables en una sola base de datos y guardar resultado en csv

'''     