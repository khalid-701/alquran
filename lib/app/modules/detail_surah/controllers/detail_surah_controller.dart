import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah/detail_surah.dart';
import 'package:alquran/app/db/bookmarks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  AutoScrollController scrollC = AutoScrollController();

  final player = AudioPlayer();
  Verse? lastVerse;
  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(bool lastRead, DetailSurah surah, Verse ayat,
      int indexAyat, String via) async {
    Database db = await database.db;
    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: [
            "surah",
            "number_surah",
            "ayat",
            "juz",
            "via",
            "index_ayat",
            "last_read"
          ],
          where:
              "surah = '${surah.name!.transliteration!.id?.replaceAll("'", "+")}' and number_surah = ${surah.number} and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = '$via' and index_ayat = $indexAyat and last_read = 0");
      if (checkData.isNotEmpty) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      //insert data

      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id?.replaceAll("'", "+")}",
        "number_surah": surah.number,
        "ayat": ayat.number!.inSurah,
        "juz": ayat.meta!.juz,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0
      });
      Get.back();
      Get.snackbar("Berhasil", "Berhasil menambahkan bookmark");
    } else {
      Get.back();
      Get.snackbar("Gagal", "Data sudah ada");
    }
    var data = await db.query("bookmark");
    print(data);
  }

  Future<DetailSurah> detailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void playAudio(Verse ayat) async {
    if (ayat.audio?.primary != null) {
      try {
        lastVerse ??= ayat;
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();

        await player.stop();
        await player.setUrl(ayat.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e.message}");
      } catch (e) {
        // Fallback for all other errors
        Get.defaultDialog(title: "Terjadi Kesalahan.", middleText: "${e}");
      }
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
              title: "Terjadi Kesalahan.", middleText: "${e.message}");
        } else {}
      });
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "URL Audio tidak ada.");
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }

  void stopAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "stop";
      update();
      await player.stop();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
