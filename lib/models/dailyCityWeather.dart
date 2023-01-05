

class dailyCityWeather {

  var _datetime;

  String _dateString;

  String _main;

  String _description;

  dailyCityWeather(
      this._datetime, this._dateString, this._main, this._description);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get main => _main;

  set main(String value) {
    _main = value;
  }

  String get dateString => _dateString;

  set dateString(String value) {
    _dateString = value;
  }

  get datetime => _datetime;

  set datetime(value) {
    _datetime = value;
  }
}