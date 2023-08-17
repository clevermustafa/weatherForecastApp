# weatherapp

Weather App is an app which displays weather forecast of 5 days.
Flutter Version: 3.7.5 (chanel stable)
Dart Version: 2.19.2

## Getting Started

Weather App follows Clean Architecture.

Api Key has been stored in firebase for security purpose. 

When app opens for the first time firestore database is invoked and weatherApiKey is fetched and stored locally in shared preference.

Then user navigates to Weather page. Initially EmptyWeather screen is shown when user searches weather forecast by city name , weather forecast of 5 days is shown.


![336744901_929801984719086_8613723659709558400_n](https://user-images.githubusercontent.com/62948764/227791534-2a728e13-0d79-4b0d-a17a-7542801c90fa.jpg)

![338301031_586243960099759_8319788834569747045_n](https://user-images.githubusercontent.com/62948764/227791545-521b383d-b4a7-43ed-ad13-b7bba433734f.jpg)
