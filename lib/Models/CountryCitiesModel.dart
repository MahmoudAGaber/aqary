
class CountryCitiesModel {
  Map<String, List<String>> countries;

  CountryCitiesModel({required this.countries});

  factory CountryCitiesModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> tempCountries = {};
    json.forEach((key, value) {
      tempCountries[key] = List<String>.from(value);
    });
    return CountryCitiesModel(countries: tempCountries);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    countries.forEach((key, value) {
      data[key] = value;
    });
    return data;
  }
}

class Countries {
  String countryName;
  List<String> citiesAndAreas;

  Countries({required this.countryName, required this.citiesAndAreas});

  Map<String, dynamic> toJson() {
    return {
      'countryName': countryName,
      'citiesAndAreas': citiesAndAreas,
    };
  }
}