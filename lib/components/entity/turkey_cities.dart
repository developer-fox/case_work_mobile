
import 'dart:convert';

import 'package:flutter/services.dart';

class CitiesOfTurkey{
  static CitiesOfTurkey? _instance = CitiesOfTurkey._init();
  static CitiesOfTurkey get instance {
    _instance ??= CitiesOfTurkey._init();
    return _instance!;
  }

  String? _noParsedData;
  late List<String> cities;

  CitiesOfTurkey._init();

  static loadEntities() async {
    instance._noParsedData = await rootBundle.loadString("asset/cities_of_turkey.json");
    final decodedData = (await json.decode(instance._noParsedData!) as List).cast<Map<String,dynamic>>();
    instance.cities = decodedData.map((e) => e["name"] as String).toList();
  }
}