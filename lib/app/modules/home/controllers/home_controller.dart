import 'dart:convert';

import 'package:alquran/app/db/bookmarks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../../../cosntants/color_constants.dart';
import '../../../data/models/juz/juz.dart';
import '../../../data/models/surah/surah.dart';

class HomeController extends GetxController {
  var isDarkMode = false.obs;
  List<Surah> getSurah = [];
  DatabaseManager database = DatabaseManager.instance;

  void changeTheme() async {
    Get.isDarkMode ? Get.changeTheme(appLight) : Get.changeTheme(appDark);
    isDarkMode.toggle();

    final tema = GetStorage();

    if (Get.isDarkMode) {
      tema.remove("themeDark");
    } else {
      tema.write("themeDark", true);
    }
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmarks =
        await db.query("bookmark", where: "last_read = 0");

    return allBookmarks;
  }

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead =
        await db.query("bookmark", where: "last_read = 1");

    if (dataLastRead.isEmpty) {
      return null;
    } else {
      return dataLastRead.first;
    }
  }

  void deleteBookmark(String id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();
    Get.back();
  }

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
