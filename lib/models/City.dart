
class cityWeather{

  String _cityname ;
  var _lat ;
  var _lng ;
  String _main ;
  String _description ;
  var _temp ;
  var _temp_min ;
  var _temp_max ;
  var _pressure;
  var _humidity ;
  var _windSpeed ;
  var _datetime;
  var _country;
  var _sunrise;
  var _sunset;

  cityWeather(
      this._cityname,
      this._lat,
      this._lng,
      this._main,
      this._description,
      this._temp,
      this._temp_min,
      this._temp_max,
      this._pressure,
      this._humidity,
      this._windSpeed,
      this._datetime,
      this._country,
      this._sunrise,
      this._sunset);

  get sunset => _sunset;

  set sunset(value) {
    _sunset = value;
  }

  get sunrise => _sunrise;

  set sunrise(value) {
    _sunrise = value;
  }

  get country => _country;

  set country(value) {
    _country = value;
  }

  get datetime => _datetime;

  set datetime(value) {
    _datetime = value;
  }

  get windSpeed => _windSpeed;

  set windSpeed(value) {
    _windSpeed = value;
  }

  get humidity => _humidity;

  set humidity(value) {
    _humidity = value;
  }

  get pressure => _pressure;

  set pressure(value) {
    _pressure = value;
  }

  get temp_max => _temp_max;

  set temp_max(value) {
    _temp_max = value;
  }

  get temp_min => _temp_min;

  set temp_min(value) {
    _temp_min = value;
  }

  get temp => _temp;

  set temp(value) {
    _temp = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get main => _main;

  set main(String value) {
    _main = value;
  }

  get lng => _lng;

  set lng(value) {
    _lng = value;
  }

  get lat => _lat;

  set lat(value) {
    _lat = value;
  }

  String get cityname => _cityname;

  set cityname(String value) {
    _cityname = value;
  }
}
