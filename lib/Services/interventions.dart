import 'dart:convert';

import 'package:app_mental/classes/Intervention.dart';
import 'package:app_mental/classes/category.dart';
import 'package:flutter/services.dart' show rootBundle;

class Interventions {
  Interventions._privateConstructor();

  static final Interventions _instance = Interventions._privateConstructor();

  factory Interventions() {
    return _instance;
  }

  List<Category> categories = [];

  Map<String, List<Intervention>> interventions =
      Map<String, List<Intervention>>();

  Future<String> getInterventionsJson() async {
    return rootBundle.loadString('assets/text/intervencoes.json');
  }

  Future<String> getCategoriesJson() async {
    return rootBundle.loadString('assets/text/grupos_de_intervencoes.json');
  }

  loadGroups() async {
    if (categories.isEmpty) {
      final response = await getCategoriesJson();
      final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

      categories =
          parsed.map<Category>((json) => Category.fromJson(json)).toList();
    }
  }

  loadInterventions() async {
    if (interventions.isEmpty) {
      final response = await getInterventionsJson();
      final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

      final List<Intervention> parsedList = parsed
          .map<Intervention>((json) => Intervention.fromJson(json))
          .toList();
      for (var p in parsedList) {
        if (interventions[p.grupo] == null) {
          interventions[p.grupo] = [];
        }
        interventions[p.grupo]!.add(p);
      }
    }
  }

  Map<String, List<Intervention>> getInterventions() {
    return interventions;
  }

  Intervention? getInterventionById(String id) {
    Intervention? intervention;
    interventions.values.forEach((list) => list.forEach((value) => {
          if (value.id == id) {intervention = value}
        }));
    return intervention;
  }

  List<Intervention>? getInterventionsByCategory(String cat) {
    return interventions[cat];
  }

  List<Category> getCategories() {
    return categories;
  }

  Category? getCategory(String cat) {
    return categories.firstWhere((element) => element.nome == cat);
  }
}
