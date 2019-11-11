library(rvest)

#data collection - web scraping off autotrader

data_bmw_4_series = data.frame(manufactorer= character(),model = character(),year=character(), body = character(), miles = character()
                               ,engine_size= character(), power = character(), gearbox = character(), 
                               location = character(), price = character())

rooturl<-'https://www.autotrader.co.uk/car-search?sort=sponsored&radius=1500&postcode=cb237xs&onesearchad=Used&onesearchad=Nearly%20New&onesearchad=New&make=BMW&model=3%20SERIES&page='
#scrape the data


#outputting error - i believe its because the lack of data causes a different amount of rows which cannot be collected
  
for (i in c(2:10)){
  page = paste(rooturl,i,sep='')
  html_page = read_html(page)

  
  page_data = data.frame(manufactorer='BMW', model = '3 series',
                  year=html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(1)')), 
                  body = html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(2)')), 
                  miles = html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(3)')), 
                  engine_size = html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(4)')),
                  power = html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(5)')),
                  gearbox = html_text(html_nodes(html_page,'.listing-key-specs li:nth-child(6)')), 
                  distance = html_text(html_nodes(html_page,'.seller-location')), 
                  price = html_text(html_nodes(html_page,'.vehicle-price')))
  
  data_bmw_4_series= rbind(data_bmw_4_series, page_data)
  
  
}

matches  = regmatches(data_bmw_4_series$miles, regexpr("[[:digit:]]+", data_bmw_4_series$miles))
data_bmw_4_series$miles =  as.numeric(unlist(matches))




