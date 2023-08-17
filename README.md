# weatherapp

Weather App is an app which displays weather forecast of 5 days.
Flutter Version: 3.7.5 (chanel stable)
Dart Version: 2.19.2

## Getting Started

Weather App follows Clean Architecture.

Api Key has been stored in firebase for security purpose. 

When app opens for the first time firestore database is invoked and weatherApiKey is fetched and stored locally in shared preference.

When app opens it asks for the location permission.
After then if user gives permission initially app featches weather forecast of user's current location and then user can also search weather forecast by city name by clicking on search icon on the top. It shows weather forecast of 5 days.

If user doesnot allow location permission EmptyWeather screen is shown which holds search button which navigates to search by city name dialog.

If user doesnot allow location permission for consecutive 2 time (means location permission denied forever) at that time toast message is shown mentioning user needs to go to app settings to enable location permission.

![image](https://github.com/clevermustafa/weatherapp/assets/62948764/4b4b4014-4e6a-4188-8e30-b5f007cbc765)

![image](https://github.com/clevermustafa/weatherapp/assets/62948764/3fce3f9c-b441-40a7-b4b3-4fe1e72b1cd2)

![image](https://github.com/clevermustafa/weatherapp/assets/62948764/b3286149-fb85-481d-9af1-dc7f38cedf3d)
