# RadioAPI-POC

Investigate Radio API

## Main Features

1. **Investigate Radio API**
   - Explore and utilize the functionalities provided by the Radio API to display and manage radio stations.

2. **Import AVFoundation for RadioPlayer**
   - Integrated the AVFoundation framework to work with the RadioPlayer engine, allowing for smooth audio streaming and control.

3. **Search for Radio Stations**
   - Implemented a search functionality to find radio stations based on user input.

4. **Search for Radio Stations by Country**
   - Enhanced search functionality to filter radio stations by selected countries, providing a more targeted user experience.

5. **Pagination**
   - Implemented pagination to load radio stations incrementally as the user scrolls, ensuring efficient data handling and a seamless user experience.

## Project Description

This project investigates the capabilities of the Radio API by creating a small application that displays a list of radio stations. The main page showcases radio stations with image icons, titles, and comma-separated tags. The navigation bar includes a country flag selector, allowing users to filter radio stations by country. Pagination is implemented to load more stations as the user scrolls. Additionally, a default search functionality enables users to search for radio stations within the selected country. When a radio station is selected, a detailed StationView is displayed with a large image, play/pause button, and the real sizes of the image. The RadioPlayer engine from [FRadioPlayer](https://github.com/fethica/FRadioPlayer) is integrated to handle audio playback.

### Search for Stations without Country Selection
<iframe width="150" height="150" src="https://www.youtube.com/embed/YOUR_VIDEO_ID_1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Search for Stations for Selected Country
<iframe width="150" height="150" src="https://www.youtube.com/embed/YOUR_VIDEO_ID_2" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
