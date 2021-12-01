# AQI
Simple iOS app in Swift to show AQI for some cities using websocket using Combine + MVVM

This app follows MVVM
This app uses combine framework
The app supports iOS 13.0+ for all iOS mobile devices

Consists of two pages:
---------------------------------------
 AQI Table View Page
  - Fectches AQI information from web socket
  - Loads this information on table view
  - When fresh data is received from the socket its mapped to the existing data i.e. 
      if new data contains existing city it updates the city modal 
      else new object is created for the city
      if the new data misses any city we have received earlier then we keep that previous entry
  - When AQI crosses some threshold then tableview cell show some animation to grab attension
  
  View:
    AQIViewController creates an object to AQIViewModal (aqiViewModal)
    AQIViewcontroller creates a property which is used to load data on views (info)
    AQICell is the customised table view cell to show the records
    AQICell informs AQIViewModal if AQI of city moves to different category
    
  Modal:
    AqiInfo contains all relevant information required to show the table view
    Uses enum AQICategory to assign category and uses its computed propety to generate relevant colors
    Follows Codable protocol
    
 ViewModal:
    Asks DataManager to download data every 5 seconds
    Receives data using completion block
    Modifies received data to get impactful data for views
    Uses combine to forward this data to AQIViewController and asks it to refresh UI
    
--------------------------------------- 
 City AQI View Page
  - Tapping on any cell on the previous page pushes this one
  - Fetches data in cycle of 30 seconds to create AQI barchart using XYCharts
  
  View:
    CityAQIController creates an object to CityViewModal (cityViewModal)
    CityAQIController creates a property which is used to load data on views (info)
    It shows the name of the selected city on the title
    AQIChart creates bar chart to monitor AQI of city over a duration
    
  Modal:
    CityAQI contains all relevant information required to show the bar graph for a city over a time
    Uses enum AQICategory to assign category and uses its computed propety to generate relevant colors
    Follows Codable protocol
    
 ViewModal:
    Asks DataManager to download data every 30 seconds
    Receives data using completion block
    Identifies selected city aqi object from the received data and add it to existing array
    Uses combine to forward this array to CityAQIController and asks it to refresh UI
 
  
 --------------------------------------- 
 Helper -- DataManager
    Uses generic object complying to Decodable protocol to return data for websocket
    Takes dispatchInterval as input paarmeter and listens to connetion to update data
    
    
    
  
    
    
    
    
    
 
