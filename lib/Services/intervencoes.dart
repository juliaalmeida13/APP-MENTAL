import 'dart:convert';

import 'package:app_mental/classes/intervencao.dart';
import 'package:flutter/services.dart';

List<Intervencao> intervencoes = [];

Future<void> loadIntervencoes() async {
  final String response =
      await rootBundle.loadString('assets/text/intervencoes.json');
  final data = await json.decode(response);

  for (dynamic it in data) {
    final Intervencao intervencao = Intervencao.fromJson(it);
    intervencoes.add(intervencao);
  }
}
