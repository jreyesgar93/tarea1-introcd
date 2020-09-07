library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

lego_movie %>%
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_node(".ratingValue span") %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_nodes(xpath = '//*[@id="title-overview-widget"]/div[1]/div[2]/div/div[1]/div[1]/div[1]/strong/span')  %>%
  html_text() %>%
  as.numeric()

lego_movie %>%
  html_nodes(".primary_photo+ td a") %>%
  html_text() %>%
  trimws()


