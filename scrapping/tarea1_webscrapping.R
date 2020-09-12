
library(rvest)
library(magritrr)


'''
Carga de la pagina que contiene los datos

'''
weather_cdmx <- read_html("https://www.timeanddate.com/weather/mexico/mexico-city/hourly")


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


time_scrapping<-function(html_name,th_pos){
  
  # Esta función es igual a la anterior pero para obtener el tiempo
  
  vec<-c()
  for (i in c(1:24)){
    value<-html_name %>%
      html_node(xpath=paste('//*[@id="wt-hbh"]/tbody/tr[',i,']/th[',th_pos,']',sep="")) %>%
      html_text() %>%
      as.character()
    vec<-c(vec,value)
  }
  return(vec)
}

time<-time_scrapping(weather_cdmx,1)

temp<-weather_scrapping(weather_cdmx,2)

weather<-weather_scrapping(weather_cdmx,3)


feels_like<-weather_scrapping(weather_cdmx,4)


wind<-weather_scrapping(weather_cdmx,5)
                
humidity<-weather_scrapping(weather_cdmx,7)


chance_rain<-weather_cdmx %>%
                html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 9) and parent::*)]') %>%
                html_text() %>%
                sub("%", "", .) %>%
                as.numeric() %>% 
                (function(x)x/100)

# otra forma de hacer lo mismo
# chance_rain2<-weather_cdmx %>%
#   html_node("td:nth-child(9)") %>%
#   html_text()
# as.numeric(sub("%","",chance_rain2))/100


ammount<-weather_cdmx %>%
            html_nodes(xpath = '//td[(((count(preceding-sibling::*) + 1) = 10) and parent::*)]') %>%
            html_text() %>%
            as.character()

'''
Juntar todas las variables en una sola base de datos y guardar resultado en csv

'''     
write.csv(data.frame(time,temp,weather,chance_rain),"weather_cdmx.csv")
