import 'dart:convert';
import 'dart:developer';

import 'package:alquran/app/data/models/surah/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/juz/juz.dart';

class HomeController extends GetxController {
  var isDarkMode = false.obs;

  List<Surah> getSurah=[];
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List? data = (json.decode(res.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      getSurah = data.map((e) => Surah.fromJson(e)).toList();
      return getSurah;
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");
      var res = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];
      Juz juz = Juz.fromJson(data);
      allJuz.add(juz);
    }

    return allJuz;
  }
}
