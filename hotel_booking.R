install.packages("ggplot2")
install.packages('tidyverse')
library(ggplot2)
library(tidyverse)
hotelBooking <- read.csv("downloads/hotel_booking.csv")

#To view the hotel data
#View(hotel_booking)

#hypothesis that people with children have to book in advance.
ggplot(data = hotelBooking)+
  geom_point(mapping = aes(x=lead_time, y=children))

#Suggests that guests without children book the most weekend nights. Is this true? 
ggplot(data = hotelBooking)+ 
  geom_point(mapping = aes(x=stays_in_weekend_nights, y=children))

#Your stakeholder is interested in developing promotions based on different booking distributions, 
#but first they need to know how many of the transactions are occurring for each different distribution 
#type.
ggplot(data = hotelBooking)+
  geom_bar(mapping = aes(x = distribution_channel, 
                         fill=market_segment))+
  facet_wrap(~deposit_type)+
  theme(axis.text.x = element_text(angle = 45))

#which market segments generate the largest number of bookings, 
#and where these bookings are made (city hotels or resort hotels). 

ggplot(data = hotelBooking)+
  geom_bar(mapping = aes(x = hotel, 
                         fill = market_segment))+
  facet_wrap(~market_segment)

#Create a plot that shows the relationship between lead time and guests 
#traveling with children for online bookings at city hotels

onlineTACityHotels <- hotelBooking %>%
  filter(hotel=="City Hotel") %>%
  filter(market_segment=="Online TA")
ggplot(data = onlineTACityHotels) +
  geom_point(mapping = aes(x = lead_time, 
                           y = children,
                           color = market_segment))

# The plot shows that the bookings with children tend to have a short lead time, 
# and bookings with 3 children have a much short lead time (<200 days). 
# So, promotions targeting families can be made closer to the valid booking dates. 

#visualization breaking down payment type by city because it will help inform how 
#the company targets promotions in the future

minDate <- min(hotelBooking$arrival_date_year)
maxDate <- max(hotelBooking$arrival_date_year)

ggplot(data = hotelBooking)+
  geom_bar(mapping = aes(x=market_segment))+
  facet_wrap(~hotel)+
  theme(axis.text.x = element_text(angle = 45)) +
  labs(title = "Comparision of market segments: City Hotel booking vs Resort Hotel Booking",
       subtitle = paste0("Date From: ",minDate,"to ", maxDate),
       x="Market Segment",
       y="Number of Bookings")



