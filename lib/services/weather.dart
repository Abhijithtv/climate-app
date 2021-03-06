import 'package:cilma/services/location.dart';
import 'package:cilma/services/networking.dart';

const apiKey = '4eed08ec9138a873582098725ae8ca56';
const openWeatherMapURl = 'https://api.openweathermap.org/data/2.5/weather';
const units = 'metric';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherMapURl?q=$cityName&appid=$apiKey&units=$units';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    var locationBrain = LocationBrain();
    await locationBrain.determinePosition();
    var lat = locationBrain.lat;
    var lng = locationBrain.lng;

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURl?lat=$lat&lon=$lng&appid=$apiKey&units=$units');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
