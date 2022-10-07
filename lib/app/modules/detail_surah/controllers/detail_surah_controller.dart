import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {

  // RxString kodisiAudio = "stop".obs;
  final player = AudioPlayer();

  Verse? lastVerse;

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
        ayat.kondisiAudio ="playing";
        update();
        await player.play();
        ayat.kondisiAudio ="stop";
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
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e}");
      }
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
              title: "Terjadi Kesalahan.", middleText: "${e.message}");
        } else {
        }
      });
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "URL Audio tidak ada.");
    }
  }
  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio  ="pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }
  void resumeAudio(Verse ayat) async {
    try {

      ayat.kondisiAudio  ="playing";
      update();
      await player.play();
      ayat.kondisiAudio  ="stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e.message}");
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }
  void stopAudio(Verse ayat) async {
    try {

      ayat.kondisiAudio ="stop";
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
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "${e}");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
